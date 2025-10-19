import 'package:flutter_bloc/flutter_bloc.dart';
import 'background_event.dart';
import 'background_state.dart';

class BackgroundBloc extends Bloc<BackgroundEvent, BackgroundState> {
  BackgroundBloc() : super(BackgroundState.initial()) {
    on<UpdateBackgroundConfig>((event, emit) {
      emit(state.copyWith(config: event.config));
    });

    on<RegeneratePattern>((event, emit) {
      // Generate new random seed to create new pattern
      final newConfig = state.config.copyWith(
        randomSeed: DateTime.now().millisecondsSinceEpoch % 1000000,
      );
      emit(state.copyWith(config: newConfig));
    });
  }
}