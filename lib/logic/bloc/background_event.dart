import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

class RegeneratePattern extends BackgroundEvent {
  final double width;
  final double height;
  
  const RegeneratePattern({
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [width, height];
}

class UpdateColors extends BackgroundEvent {
  final Color darkColor;
  final Color lightColor;
  
  const UpdateColors({
    required this.darkColor,
    required this.lightColor,
  });

  @override
  List<Object?> get props => [darkColor, lightColor];
}

class ResetToDefaults extends BackgroundEvent {}