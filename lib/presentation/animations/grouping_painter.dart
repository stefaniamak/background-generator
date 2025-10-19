import 'dart:math';
import 'package:flutter/material.dart';
import 'base_painter.dart';
import 'painter_constants.dart';

/// Handles particle cluster generation and placement
class GroupingPainter extends BasePainter {
  GroupingPainter({required super.config});

  /// Generate clustered particle groups across the screen
  List<ParticleCenter> generateParticleGroups(Size screenSize) {
    final (gridWidth, gridHeight) = calculateGridDimensions(screenSize);
    final centerPoints = <ParticleCenter>[];

    // Create fewer groups with varying sizes for organic distribution
    final numGroups = PainterConstants.minGroups + random.nextInt(PainterConstants.maxGroups - PainterConstants.minGroups + 1);

    // Calculate grid layout for very vertical distribution
    final cols = max(1, (sqrt(numGroups) * PainterConstants.groupColumnsReduction).ceil()); // Reduced columns
    final rows = (numGroups / cols).ceil();

    // Calculate screen diagonal for percentage-based distance
    final screenDiagonal = sqrt(gridWidth * gridWidth + gridHeight * gridHeight);

    for (int group = 0; group < numGroups; group++) {
      // Calculate grid position for this group
      final col = group % cols;
      final row = group ~/ cols;

      // Random position within this cell for even distribution
      final cellWidth = gridWidth / cols;
      final cellHeight = gridHeight / rows;
      final groupStartX = (col * cellWidth + random.nextDouble() * cellWidth).round().clamp(0, gridWidth - 1);
      final groupStartY = (row * cellHeight + random.nextDouble() * cellHeight).round().clamp(0, gridHeight - 1);

      // Random number of particles in this group (increased density)
      final particlesInGroup = PainterConstants.minParticlesPerGroup + random.nextInt(PainterConstants.maxParticlesPerGroup - PainterConstants.minParticlesPerGroup + 1);

      // Calculate distance range based on screen diagonal
      final minDistance = screenDiagonal * PainterConstants.minDistancePercentage;
      final maxDistance = screenDiagonal * PainterConstants.maxDistancePercentage;

      // First particle at the group starting position
      final firstRadius = PainterConstants.minParticleRadius + random.nextInt(PainterConstants.maxParticleRadius - PainterConstants.minParticleRadius + 1);
      centerPoints.add(ParticleCenter(
        centerX: groupStartX,
        centerY: groupStartY,
        radius: firstRadius,
      ));

      // Generate remaining particles around the first particle
      for (int i = 1; i < particlesInGroup; i++) {
        // Random distance from first particle
        final distance = minDistance + random.nextDouble() * (maxDistance - minDistance);

        // Calculate horizontal constraint based on distance
        final normalizedDistance = (distance - minDistance) / (maxDistance - minDistance);

        // Horizontal spread: starts at base value and reduces to 0 as distance increases
        final horizontalSpread = PainterConstants.horizontalSpreadBase * (1.0 - normalizedDistance);

        // Random angle, but mainly vertical
        final baseAngle = (random.nextDouble() - 0.5) * pi; // -π/2 to π/2
        final horizontalVariation = (random.nextDouble() - 0.5) * pi * PainterConstants.horizontalVariationFactor * horizontalSpread;
        final angle = baseAngle + horizontalVariation;

        final centerX = (groupStartX + (cos(angle) * distance)).round().clamp(0, gridWidth - 1);
        final centerY = (groupStartY + (sin(angle) * distance)).round().clamp(0, gridHeight - 1);

        // Radius decreases with distance from first particle
        final minRadius = 2 + ((PainterConstants.minParticleRadius - 2) * (1.0 - normalizedDistance)).round(); // 4 to 2
        final maxRadius = PainterConstants.minParticleRadius + ((PainterConstants.maxParticleRadius - PainterConstants.minParticleRadius) * (1.0 - normalizedDistance)).round(); // 9 to 4
        final radius = minRadius + random.nextInt((maxRadius - minRadius + 1).clamp(1, 100));

        centerPoints.add(ParticleCenter(
          centerX: centerX,
          centerY: centerY,
          radius: radius,
        ));
      }
    }

    return centerPoints;
  }
}
