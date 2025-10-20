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
            // Check directional constraints for expansion
            final horizontalDistance = dx.abs();
            final verticalDistance = dy.abs();
            
            // Gradient from base to minimum fill
            final expansionDistance = ellipticalDistance - 1.0;
            final maxExpansion = PainterConstants.expansionGradientMax;
            final normalizedDistance = expansionDistance / maxExpansion;
            final baseFill = PainterConstants.baseFillPercentage - (normalizedDistance * PainterConstants.fillGradientRange);
            
            // Reduce horizontal expansion intensity
            if (verticalDistance > horizontalDistance) {
              // Vertical expansion - full intensity
              fillPercentage = baseFill;
            } else if (horizontalDistance <= 3) {
              // Close horizontal expansion - reduced intensity (50% of normal)
              fillPercentage = baseFill * 0.5;
            } else {
              // Far horizontal expansion - very reduced intensity (25% of normal)
              fillPercentage = baseFill * 0.25;
            }
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
          // Check if this position should have an outside particle according to checkerboard pattern
          final shouldKeep = (gx % 2 == gy % 2);
          
          if (!shouldKeep) {
            // Remove particles that don't follow the checkerboard pattern
            gridFill[gx][gy] = 0.0;
            continue;
          }
          
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

            // Apply the smoothly interpolated size (only for checkerboard positions)
            gridFill[gx][gy] = newFillPercentage;
          }
        }
      }
    }
  }

  /// Smoothly interpolate particle size based on distance to nearest 100% particle
  double _interpolateSize(double distance) {
    // Outside particles get SMALLER as they get farther from 100% particles
    // Start at 95% when close and decrease to 15% at the edge
    // Using a gentler curve for more natural, organic transitions
    
    if (distance <= 0.5) {
      // Very close: 95% - largest outside particles
      return 0.95;
    } else if (distance <= 8.0) {
      // Smooth decay from 95% to 15% over distance 0.5-8
      // Particles get progressively SMALLER as they reach the edge
      final t = (distance - 0.5) / 7.5; // Normalize to 0-1
      
      // Use a gentler curve: sqrt creates a more gradual falloff
      // At t=0 (distance=0.5): returns 0.95 (large)
      // At t=1 (distance=8): returns 0.15 (small, at the edge)
      final smoothFactor = 1.0 - sqrt(t); // Gentler falloff curve
      return 0.15 + (0.80 * smoothFactor); // 0.80 = 0.95 - 0.15
    } else {
      // Very far (edge of spread): minimum size of 15%
      return 0.15;
    }
  }
}
