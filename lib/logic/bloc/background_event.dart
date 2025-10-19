import 'package:equatable/equatable.dart';
import '../../data/models/background_config.dart';

abstract class BackgroundEvent extends Equatable {
  const BackgroundEvent();

  @override
  List<Object?> get props => [];
}

class UpdateBackgroundConfig extends BackgroundEvent {
  final BackgroundConfig config;
  const UpdateBackgroundConfig(this.config);

  @override
  List<Object?> get props => [config];
}

class RegeneratePattern extends BackgroundEvent {}