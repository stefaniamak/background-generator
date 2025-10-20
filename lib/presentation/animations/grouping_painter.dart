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

    // Scale the number of groups by screen grid area
    final totalArea = gridWidth * gridHeight;
    final targetGroups = (totalArea / PainterConstants.cellsPerGroupTarget).clamp(
      PainterConstants.minGroups.toDouble(),
      PainterConstants.maxGroups.toDouble(),
    );
    final baseGroups = targetGroups.round();
    // Add small randomness (+/- 10%) for variation
    final jitter = (baseGroups * 0.1).round().clamp(0, 3);
    final numGroups = max(PainterConstants.minGroups, min(PainterConstants.maxGroups, baseGroups + (random.nextBool() ? jitter : -jitter)));

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

      // Stronger scaling: use power factor for larger growth on big screens
      final rawScale = sqrt(totalArea / PainterConstants.particlesReferenceArea);
      final areaScale = pow(rawScale, 1.25).toDouble()
          .clamp(PainterConstants.particlesScaleMin, PainterConstants.particlesScaleMax);
      final minParticlesScaled = (PainterConstants.minParticlesPerGroup * areaScale).clamp(2.0, 999.0).round();
      final maxParticlesScaled = (PainterConstants.maxParticlesPerGroup * areaScale).clamp(minParticlesScaled.toDouble(), 999.0).round();

      final particlesInGroup = minParticlesScaled +
          random.nextInt(max(1, maxParticlesScaled - minParticlesScaled + 1));

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
