import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../presentation/animations/painter_constants.dart';

class BackgroundConfig extends Equatable {
  final Color darkColor;
  final Color lightColor;
  final int randomSeed;

  const BackgroundConfig({
    required this.darkColor,
    required this.lightColor,
    required this.randomSeed,
  });

  BackgroundConfig copyWith({
    Color? darkColor,
    Color? lightColor,
    int? randomSeed,
  }) {
    return BackgroundConfig(
      darkColor: darkColor ?? this.darkColor,
      lightColor: lightColor ?? this.lightColor,
      randomSeed: randomSeed ?? this.randomSeed,
    );
  }

  static BackgroundConfig initial() {
    return BackgroundConfig(
      darkColor: const Color(PainterConstants.darkColorValue),     // Black background
      lightColor: const Color(PainterConstants.lightColorValue),   // Very dark grey pattern
      randomSeed: PainterConstants.defaultRandomSeed,              // Fixed seed for consistent pattern
    );
  }

  @override
  List<Object?> get props => [darkColor, lightColor, randomSeed];
}