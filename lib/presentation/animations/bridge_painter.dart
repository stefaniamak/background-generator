import 'dart:math';
import 'base_painter.dart';
import 'painter_constants.dart';

/// Handles liquid-like connections between particles
class BridgePainter extends BasePainter {
  BridgePainter({required super.config});

  /// Create liquid-like bridges between close particles
  void createLiquidBridges(
    List<List<double>> gridFill,
    List<ParticleCenter> centerPoints,
    int gridWidth,
    int gridHeight,
  ) {
    // Find close particles and create bridges between them
    for (int i = 0; i < centerPoints.length; i++) {
      for (int j = i + 1; j < centerPoints.length; j++) {
        final particle1 = centerPoints[i];
        final particle2 = centerPoints[j];

        // Calculate distance between particles
        final dx = particle1.centerX - particle2.centerX;
        final dy = particle1.centerY - particle2.centerY;
        final distance = sqrt(dx * dx + dy * dy);

        // Create bridge if particles are close enough
        final combinedRadius = particle1.radius + particle2.radius;
        final bridgeThreshold = combinedRadius * PainterConstants.bridgeThresholdMultiplier;

        // Only create bridges for vertical connections (similar Y coordinates)
        final yDifference = (particle1.centerY - particle2.centerY).abs();
        final xDifference = (particle1.centerX - particle2.centerX).abs();
        final isVerticalConnection = yDifference > xDifference * PainterConstants.bridgeVerticalBias; // Much more vertical than horizontal

        if (distance < bridgeThreshold && distance > 0 && isVerticalConnection) {
          // Create a liquid bridge between the particles
          _createBridgeBetweenParticles(gridFill, particle1, particle2, gridWidth, gridHeight);
        }
      }
    }
  }

  /// Create a bridge between two specific particles
  void _createBridgeBetweenParticles(
    List<List<double>> gridFill,
    ParticleCenter particle1,
    ParticleCenter particle2,
    int gridWidth,
    int gridHeight,
  ) {
    // Calculate bridge properties
    final dx = particle2.centerX - particle1.centerX;
    final dy = particle2.centerY - particle1.centerY;
    final distance = sqrt(dx * dx + dy * dy);

    // Bridge width varies with distance (closer = thicker bridge)
    final maxBridgeWidth = min(particle1.radius, particle2.radius) * PainterConstants.bridgeWidthMultiplier;
    final distanceFactor = 1.0 - (distance / (particle1.radius + particle2.radius + 5));
    final bridgeWidth = maxBridgeWidth * distanceFactor.clamp(0.5, 1.0);

    // Create bridge path with smooth curve for organic look
    final steps = (distance * PainterConstants.bridgeStepsMultiplier).round(); // More steps for smoother bridge
    for (int step = 0; step <= steps; step++) {
      final t = step / steps;

      // Very subtle curve using sine wave for smooth bridge shape
      final curveOffset = sin(t * pi) * PainterConstants.bridgeCurveOffset; // Smaller curve for smoother look
      final perpX = -dy / distance; // Perpendicular vector
      final perpY = dx / distance;

      // Bridge center point
      final bridgeX = (particle1.centerX + t * dx + perpX * curveOffset).round();
      final bridgeY = (particle1.centerY + t * dy + perpY * curveOffset).round();

      // Smooth bridge width: thick at particles, thin in middle
      final widthFactor = 1.0 - (t - 0.5).abs() * 2; // 1.0 at ends, 0.0 at middle
      final smoothWidthFactor = sin(widthFactor * pi / 2); // Smooth curve
      final bridgeRadius = (bridgeWidth * smoothWidthFactor).round();

      if (bridgeRadius > 0) {
        for (int gx = (bridgeX - bridgeRadius).clamp(0, gridWidth - 1);
             gx <= (bridgeX + bridgeRadius).clamp(0, gridWidth - 1);
             gx++) {
          for (int gy = (bridgeY - bridgeRadius).clamp(0, gridHeight - 1);
               gy <= (bridgeY + bridgeRadius).clamp(0, gridHeight - 1);
               gy++) {

            final distFromCenter = sqrt((gx - bridgeX) * (gx - bridgeX) + (gy - bridgeY) * (gy - bridgeY));

            if (distFromCenter <= bridgeRadius) {
              // Calculate distance to both particles to determine proximity to 100% fill
              final distToParticle1 = sqrt((gx - particle1.centerX) * (gx - particle1.centerX) + (gy - particle1.centerY) * (gy - particle1.centerY));
              final distToParticle2 = sqrt((gx - particle2.centerX) * (gx - particle2.centerX) + (gy - particle2.centerY) * (gy - particle2.centerY));

              // Find the closer particle
              final minDistToParticle = min(distToParticle1, distToParticle2);

              // The closer to a 100% particle, the higher the fill percentage
              double bridgeFill;
              final extendedRadius = min(particle1.radius, particle2.radius) * PainterConstants.bridgeExtendedRadiusMultiplier; // Extended area for 100% fill
              if (minDistToParticle <= extendedRadius) {
                // 100% fill in extended area around 100% particles
                bridgeFill = PainterConstants.bridgeProximityFill;
              } else {
                // Follow the same gradient as the outside expansion areas
                final proximityTo100Percent = (1.0 - (minDistToParticle / (bridgeRadius + particle1.radius + particle2.radius))).clamp(0.0, 1.0);
                bridgeFill = (PainterConstants.bridgeMaxFill - proximityTo100Percent * PainterConstants.bridgeFillRange).clamp(PainterConstants.bridgeMinFill, PainterConstants.bridgeMaxFill);
              }

              // Blend with existing fill (take maximum)
              gridFill[gx][gy] = max(gridFill[gx][gy], bridgeFill);
            }
          }
        }
      }
    }
  }

  /// Create diagonal bridges between close outside particles
  void createDiagonalOutsideBridges(
    List<List<double>> gridFill,
    int gridWidth,
    int gridHeight,
  ) {
    // Find outside particles and create diagonal bridges between close ones
    final outsideParticles = <(int, int)>[];

    // Collect all outside particles
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final fill = gridFill[gx][gy];
        if (fill > 0 && fill < 0.99) { // Outside particle
          outsideParticles.add((gx, gy));
        }
      }
    }

    // Create diagonal bridges between close outside particles
    for (int i = 0; i < outsideParticles.length; i++) {
      for (int j = i + 1; j < outsideParticles.length; j++) {
        final (x1, y1) = outsideParticles[i];
        final (x2, y2) = outsideParticles[j];

        // Calculate distance between outside particles
        final dx = x1 - x2;
        final dy = y1 - y2;
        final distance = sqrt(dx * dx + dy * dy);

        // Create bridge if particles are close enough with selective connectivity
        final baseThreshold = PainterConstants.diagonalBridgeThreshold;
        final distanceVariation = baseThreshold * PainterConstants.bridgeDistanceVariation;
        final bridgeThreshold = baseThreshold + (random.nextDouble() - 0.5) * distanceVariation;

        // Add randomness to bridge creation for selective connectivity
        final shouldCreateBridge = random.nextDouble() < (1.0 - PainterConstants.bridgeRandomnessFactor);

        if (distance < bridgeThreshold && distance > 0 && shouldCreateBridge) {
          // Create a diagonal bridge between the outside particles
          _createDiagonalBridgeBetweenOutsideParticles(gridFill, x1, y1, x2, y2, gridWidth, gridHeight);
        }
      }
    }
  }

  /// Create a diagonal bridge between two outside particles
  void _createDiagonalBridgeBetweenOutsideParticles(
    List<List<double>> gridFill,
    int x1,
    int y1,
    int x2,
    int y2,
    int gridWidth,
    int gridHeight,
  ) {
    // Calculate bridge properties
    final dx = x2 - x1;
    final dy = y2 - y1;
    final distance = sqrt(dx * dx + dy * dy);

    // Create diagonal bridge path - only fill diagonal positions
    final steps = (distance * PainterConstants.diagonalBridgeStepsMultiplier).round();
    for (int step = 0; step <= steps; step++) {
      final t = step / steps;

      // Bridge center point
      final bridgeX = (x1 + t * dx).round();
      final bridgeY = (y1 + t * dy).round();

      // Only fill if the position is within bounds and follows diagonal pattern
      if (bridgeX >= 0 && bridgeX < gridWidth && bridgeY >= 0 && bridgeY < gridHeight) {
        // Check if this position should be filled according to diagonal pattern
        final shouldFill = (bridgeX % 2 == bridgeY % 2); // Diagonal checkerboard pattern

        if (shouldFill) {
          // Use the average fill of the two connected outside particles
          final particle1Fill = gridFill[x1][y1];
          final particle2Fill = gridFill[x2][y2];
          final averageFill = (particle1Fill + particle2Fill) / 2;

          // Apply bridge fill with variation for selective connectivity
          final baseReduction = PainterConstants.diagonalBridgeFillReduction;
          final fillVariation = random.nextDouble() * 0.3; // 30% variation
          final bridgeFill = averageFill * (baseReduction + fillVariation);

          // Only apply if it increases the fill percentage
          final existingFill = gridFill[bridgeX][bridgeY];
          if (bridgeFill > existingFill) {
            gridFill[bridgeX][bridgeY] = bridgeFill;
          }
        }
      }
    }
  }
}
