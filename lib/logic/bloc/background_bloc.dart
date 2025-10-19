import 'package:flutter_bloc/flutter_bloc.dart';
import 'background_event.dart';
import 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  BackgroundBloc() : super(BackgroundState.initial()) {
    on<UpdateBackgroundConfig>((event, emit) {
      emit(state.copyWith(config: event.config));
    });

    on<RegeneratePattern>((event, emit) async {
      // Prevent multiple simultaneous refreshes
      if (state.isRefreshing) return;
      
      // Set refreshing state
      emit(state.copyWith(isRefreshing: true));
      
      // Small delay to show the loading state
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Generate new random seed to create new pattern
      final newSeed = DateTime.now().millisecondsSinceEpoch % 1000000;
      final newConfig = state.config.copyWith(randomSeed: newSeed);
      
      // Emit new config and reset refreshing state
      emit(state.copyWith(config: newConfig, isRefreshing: false));
    });
  }
}