import 'package:flutter_bloc/flutter_bloc.dart';
import 'background_event.dart';
import 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  BackgroundBloc() : super(BackgroundState.initial()) {
    print('BackgroundBloc created with seed: ${state.config.randomSeed}');
    
    on<UpdateBackgroundConfig>((event, emit) {
      print('UpdateBackgroundConfig event received');
      emit(state.copyWith(config: event.config));
    });

    on<RegeneratePattern>((event, emit) async {
      print('RegeneratePattern event received, isRefreshing: ${state.isRefreshing}');
      
      // Prevent multiple simultaneous refreshes
      if (state.isRefreshing) {
        print('Already refreshing, ignoring event');
        return;
      }
      
      // Set refreshing state
      print('Emitting isRefreshing: true');
      emit(state.copyWith(isRefreshing: true));
      
      // Small delay to show the loading state
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Generate new random seed to create new pattern
      final newSeed = DateTime.now().millisecondsSinceEpoch % 1000000;
      final newConfig = state.config.copyWith(randomSeed: newSeed);
      
      print('Emitting new config with seed: $newSeed');
      // Emit new config and reset refreshing state
      emit(state.copyWith(config: newConfig, isRefreshing: false));
    });
  }
}