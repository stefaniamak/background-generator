import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/models/background_config.dart';
import 'painter_constants.dart';

/// Base class for all particle-related painters
abstract class BasePainter {
  final BackgroundConfig config;
  final Random random;

  BasePainter({required this.config}) : random = Random(config.randomSeed);

  /// Get the current cell size for the grid
  double get cellWidth => PainterConstants.cellWidth;
  double get cellHeight => PainterConstants.cellHeight;

  /// Calculate grid dimensions based on screen size
  (int width, int height) calculateGridDimensions(Size screenSize) {
    final gridWidth = (screenSize.width / cellWidth).ceil();
    final gridHeight = (screenSize.height / cellHeight).ceil();
    return (gridWidth, gridHeight);
  }
}

/// Information about a particle center
class ParticleCenter {
  final int centerX;
  final int centerY;
  final int radius;

  const ParticleCenter({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });
}
