import 'dart:math';
import 'base_painter.dart';
import 'painter_constants.dart';

/// Handles individual particle creation and distance-based sizing
class ParticlePainter extends BasePainter {
  ParticlePainter({required super.config});

  /// Fill a single particle in the grid with distance-based sizing
  void fillParticleInGrid(
    List<List<double>> gridFill,
    ParticleCenter particle,
    List<ParticleCenter> allParticles,
    int gridWidth,
    int gridHeight,
  ) {
    final centerX = particle.centerX;
    final centerY = particle.centerY;
    final radius = particle.radius;

    // Create oval shape
    const ovalFactor = PainterConstants.ovalFactor;
    
    // Fill area extends based on expansion multiplier
    final expansionRadius = (radius * PainterConstants.expansionRadiusMultiplier).round();

    for (int gx = (centerX - expansionRadius).clamp(0, gridWidth - 1);
         gx <= (centerX + expansionRadius).clamp(0, gridWidth - 1);
         gx++) {
      for (int gy = (centerY - expansionRadius).clamp(0, gridHeight - 1);
           gy <= (centerY + expansionRadius).clamp(0, gridHeight - 1);
           gy++) {

        final dx = gx - centerX;
        final dy = gy - centerY;

        // Calculate elliptical distance for oval shape
        final radiusX = radius * ovalFactor;
        final radiusY = radius;
        final ellipticalDistanceSquared = (dx * dx) / (radiusX * radiusX) + (dy * dy) / (radiusY * radiusY);
        final ellipticalDistance = sqrt(ellipticalDistanceSquared);

        double fillPercentage = 0.0;

        if (ellipticalDistance <= 1.0) {
          // Inside the oval - 100% fill
          fillPercentage = 1.0;
        } else if (ellipticalDistance <= PainterConstants.expansionDistanceMax) {
          // In the expansion area - checkerboard pattern
          final shouldKeep = (gx % 2 == gy % 2);
          
          if (shouldKeep) {
            // Gradient from base to minimum fill
            final expansionDistance = ellipticalDistance - 1.0;
            final maxExpansion = PainterConstants.expansionGradientMax;
            final normalizedDistance = expansionDistance / maxExpansion;
            fillPercentage = PainterConstants.baseFillPercentage - (normalizedDistance * PainterConstants.fillGradientRange);
          }
        }

        // Keep the maximum percentage for overlapping areas
        if (fillPercentage > 0) {
          gridFill[gx][gy] = max(gridFill[gx][gy], fillPercentage);
        }
      }
    }
  }

  /// Apply dramatic size differences based on distance to closest 100% particle
  void applyDistanceBasedSizing(List<List<double>> gridFill, int gridWidth, int gridHeight) {
    // Find all 100% particles
    final hundredPercentParticles = <(int, int)>[];
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        if (gridFill[gx][gy] >= 0.99) {
          hundredPercentParticles.add((gx, gy));
        }
      }
    }

    // Apply dramatic size differences to outside particles
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = gridFill[gx][gy];

        // Only process outside particles (non-100% fill but > 0)
        if (currentFill > 0 && currentFill < 0.99) {
          // Find the closest 100% particle
          double minDistanceToClosest = double.infinity;
          for (final (px, py) in hundredPercentParticles) {
            final dx = gx - px;
            final dy = gy - py;
            final distanceToThis100Percent = sqrt(dx * dx + dy * dy);
            minDistanceToClosest = min(minDistanceToClosest, distanceToThis100Percent);
          }

          if (minDistanceToClosest < double.infinity) {
            // Calculate fill percentage based on distance to closest 100% particle
            double newFillPercentage;

            if (minDistanceToClosest <= PainterConstants.veryCloseDistance) {
              newFillPercentage = PainterConstants.veryCloseFill; // 95% size - very large
            } else if (minDistanceToClosest <= PainterConstants.closeDistance) {
              newFillPercentage = PainterConstants.closeFill; // 80% size - large
            } else if (minDistanceToClosest <= PainterConstants.mediumDistance) {
              newFillPercentage = PainterConstants.mediumFill; // 60% size - medium
            } else if (minDistanceToClosest <= PainterConstants.farDistance) {
              newFillPercentage = PainterConstants.farFill; // 30% size - small
            } else if (minDistanceToClosest <= PainterConstants.veryFarDistance) {
              newFillPercentage = PainterConstants.veryFarFill; // 40% size - very far
            } else {
              newFillPercentage = PainterConstants.extremelyFarFill; // 25% size - extremely far
            }

            // Force the dramatic size difference
            gridFill[gx][gy] = newFillPercentage;
          }
        }
      }
    }
  }
}
