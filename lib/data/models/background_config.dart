import 'package:flutter/material.dart';

class BackgroundConfig {
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
    return const BackgroundConfig(
      darkColor: Color(0xFF000000),     // Black background
      lightColor: Color(0xFF404040),    // Dark grey pattern
      randomSeed: 42,                   // Fixed seed for consistent pattern
    );
  }
}