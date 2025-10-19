import 'package:equatable/equatable.dart';
import '../../data/models/background_config.dart';

class BackgroundState extends Equatable {
  final BackgroundConfig config;

  const BackgroundState({
    required this.config,
  });

  BackgroundState copyWith({
    BackgroundConfig? config,
  }) {
    return BackgroundState(
      config: config ?? this.config,
    );
  }

  static BackgroundState initial() =>
      BackgroundState(config: BackgroundConfig.initial());

  @override
  List<Object?> get props => [config];
}