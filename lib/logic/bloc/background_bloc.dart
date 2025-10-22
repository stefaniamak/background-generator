import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_manager/isolate_manager.dart';
import '../../data/models/background_config.dart';
import '../../utils/app_constants.dart';
import '../isolate/background_pattern_isolate.dart';
import 'background_event.dart';
import 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  IsolateManager<dynamic, dynamic>? _isolateManager;

  BackgroundBloc() : super(BackgroundState.initial()) {
    on<UpdateBackgroundConfig>((event, emit) {
      // Check if only colors changed (not random seed)
      final onlyColorsChanged = event.config.randomSeed == state.config.randomSeed;
      
      if (onlyColorsChanged) {
        // Only update config, don't regenerate pattern
        emit(state.copyWith(config: event.config));
      } else {
        // Random seed changed, need to regenerate pattern
        emit(state.copyWith(config: event.config, patternData: null));
      }
    });

    on<RegeneratePattern>((event, emit) async {
      // Prevent multiple simultaneous refreshes
      if (state.isRefreshing) return;
      
      // Set refreshing state
      emit(state.copyWith(isRefreshing: true));
      
      try {
        // Generate new random seed to create new pattern
        final newSeed = DateTime.now().millisecondsSinceEpoch % AppConstants.randomSeedRange;
        final newConfig = state.config.copyWith(randomSeed: newSeed);
        
        // Emit new config immediately to show the seed change
        emit(state.copyWith(config: newConfig));
        
        // Initialize isolate manager if not already done
        if (_isolateManager == null) {
          _isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
            backgroundPatternWorker,
            workerName: AppConstants.isolateWorkerName,
            concurrent: AppConstants.isolateConcurrency,
          );
        }
        
        // Generate pattern in isolate
        await _isolateManager!.compute(
          jsonEncode(BackgroundPatternInput(
            width: event.width,
            height: event.height,
            darkColorValue: newConfig.darkColor.value,
            lightColorValue: newConfig.lightColor.value,
            randomSeed: newConfig.randomSeed,
          ).toJson()),
          callback: (dynamic value) {
            final Map<String, dynamic> data = jsonDecode(value);
            
            if (data.containsKey('progress')) {
              // Progress update - could be used for progress indicators
              return false; // Not the final result
            }
            
            if (data.containsKey('result')) {
              // Final result received
              final result = BackgroundPatternOutput.fromJson(data['result']);
              // Update state with new pattern data
              emit(state.copyWith(patternData: result));
              return true; // This is the final result
            }
            
            return false; // Not the final result
          },
        );
        
      } catch (e) {
        // Handle errors gracefully
        print('${AppConstants.errorGeneratingPattern}$e');
      } finally {
        // Reset refreshing state
        emit(state.copyWith(isRefreshing: false));
      }
    });

    on<UpdateColors>((event, emit) {
      final newConfig = state.config.copyWith(
        darkColor: event.darkColor,
        lightColor: event.lightColor,
      );
      // Only update colors, don't regenerate pattern
      emit(state.copyWith(config: newConfig));
    });

    on<ResetToDefaults>((event, emit) {
      final defaultConfig = state.config.copyWith(
        darkColor: BackgroundConfig.initial().darkColor,
        lightColor: BackgroundConfig.initial().lightColor,
      );
      // Only reset colors, don't regenerate pattern
      emit(state.copyWith(config: defaultConfig));
    });
  }

  @override
  Future<void> close() async {
    await _isolateManager?.stop();
    return super.close();
  }
}