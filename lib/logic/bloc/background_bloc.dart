import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_manager/isolate_manager.dart';
import '../../data/models/background_config.dart';
import '../isolate/background_pattern_isolate.dart';
import 'background_event.dart';
import 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  IsolateManager<dynamic, dynamic>? _isolateManager;

  BackgroundBloc() : super(BackgroundState.initial()) {
    on<UpdateBackgroundConfig>((event, emit) {
      emit(state.copyWith(config: event.config));
    });

    on<RegeneratePattern>((event, emit) async {
      // Prevent multiple simultaneous refreshes
      if (state.isRefreshing) return;
      
      // Set refreshing state
      emit(state.copyWith(isRefreshing: true));
      
      try {
        // Generate new random seed to create new pattern
        final newSeed = DateTime.now().millisecondsSinceEpoch % 1000000;
        final newConfig = state.config.copyWith(randomSeed: newSeed);
        
        // Emit new config immediately to show the seed change
        emit(state.copyWith(config: newConfig));
        
        // Initialize isolate manager if not already done
        if (_isolateManager == null) {
          _isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
            backgroundPatternWorker,
            workerName: 'backgroundPatternWorker',
            concurrent: 1, // Only one pattern generation at a time
          );
        }
        
        // Generate pattern in isolate
        await _isolateManager!.compute(
          jsonEncode(BackgroundPatternInput(
            width: 800.0, // Default size, will be updated by the painter
            height: 600.0,
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
              // The pattern is now ready for rendering
              return true; // This is the final result
            }
            
            return false; // Not the final result
          },
        );
        
      } catch (e) {
        // Handle errors gracefully
        print('Error generating pattern: $e');
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
      emit(state.copyWith(config: newConfig));
    });

    on<ResetToDefaults>((event, emit) {
      final defaultConfig = state.config.copyWith(
        darkColor: BackgroundConfig.initial().darkColor,
        lightColor: BackgroundConfig.initial().lightColor,
      );
      emit(state.copyWith(config: defaultConfig));
    });
  }

  @override
  Future<void> close() async {
    await _isolateManager?.stop();
    return super.close();
  }
}