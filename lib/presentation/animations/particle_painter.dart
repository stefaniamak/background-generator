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
            // Smooth interpolation based on distance
            // Start at 95% for very close (distance 0-1) and gradually decrease
            final double newFillPercentage = _interpolateSize(minDistanceToClosest);

            // Apply the smoothly interpolated size
            gridFill[gx][gy] = newFillPercentage;
          }
        }
      }
    }
  }

  /// Smoothly interpolate particle size based on distance to nearest 100% particle
  double _interpolateSize(double distance) {
    // Larger outside particles: start at 95% and decrease to 40%
    // Using a gentler curve for more natural, organic transitions
    
    if (distance <= 0.5) {
      // Very close: 95%
      return 0.95;
    } else if (distance <= 8.0) {
      // Smooth exponential decay from 95% to 40% over distance 0.5-8
      // Using a gentler curve for smoother transitions
      final t = (distance - 0.5) / 7.5; // Normalize to 0-1
      
      // Use a gentler curve: sqrt creates a more gradual falloff
      // At t=0 (distance=0.5): returns 0.95
      // At t=1 (distance=8): returns 0.40
      final smoothFactor = 1.0 - sqrt(t); // Gentler than pow(t, 1.5)
      return 0.40 + (0.55 * smoothFactor); // 0.55 = 0.95 - 0.40
    } else {
      // Very far: minimum size increased to 40%
      return 0.40;
    }
  }
}
