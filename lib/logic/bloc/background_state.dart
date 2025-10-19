import 'package:equatable/equatable.dart';
import '../../data/models/background_config.dart';

class BackgroundState extends Equatable {
  final BackgroundConfig config;
  final bool isRefreshing;

  const BackgroundState({
    required this.config,
    this.isRefreshing = false,
  });

  BackgroundState copyWith({
    BackgroundConfig? config,
    bool? isRefreshing,
  }) {
    return BackgroundState(
      config: config ?? this.config,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  static BackgroundState initial() =>
      BackgroundState(config: BackgroundConfig.initial(), isRefreshing: false);

  @override
  List<Object?> get props => [config, isRefreshing];
}