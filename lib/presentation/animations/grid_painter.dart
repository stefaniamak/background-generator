import 'dart:math';
import 'package:flutter/material.dart';
import '../../data/models/background_config.dart';

class GridPainter extends CustomPainter {
  final BackgroundConfig config;

  GridPainter({required this.config});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw dark background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = config.darkColor,
    );

    // Create the pattern
    _drawPattern(canvas, size);
  }

  void _drawPattern(Canvas canvas, Size size) {
    final random = Random(config.randomSeed);
    
    // Calculate grid size based on screen size and cell size (7 pixels per cell)
    const cellSize = 7.0;
    final gridWidth = (size.width / cellSize).ceil();
    final gridHeight = (size.height / cellSize).ceil();
    
    // Create array to store fill percentages for each grid cell
    final gridFill = List.generate(gridWidth, (_) => List.generate(gridHeight, (_) => 0.0));
    
    // Generate random center points in clustered groups
    final centerPoints = <_CircleInfo>[];
    
        // Create fewer groups with varying sizes for more organic distribution
        final numGroups = 6 + random.nextInt(4); // 6-9 groups (fewer, but more varied)
        
        // Calculate grid layout for very vertical distribution
        // Very few columns (very narrow) and many rows (very tall)
        final cols = max(1, (sqrt(numGroups) * 0.25).ceil()); // 75% fewer columns - even more vertical
        final rows = (numGroups / cols).ceil();
    
    // Calculate cell size for grid distribution
    final cellWidth = gridWidth / cols;
    final cellHeight = gridHeight / rows;
    
    // Calculate screen diagonal for percentage-based distance
    final screenDiagonal = sqrt(gridWidth * gridWidth + gridHeight * gridHeight);
    
    for (int group = 0; group < numGroups; group++) {
      // Calculate grid position for this group
      final col = group % cols;
      final row = group ~/ cols;
      
      // Random position within this cell for even distribution
      final groupStartX = (col * cellWidth + random.nextDouble() * cellWidth).round().clamp(0, gridWidth - 1);
      final groupStartY = (row * cellHeight + random.nextDouble() * cellHeight).round().clamp(0, gridHeight - 1);
      
          // Random number of particles in this group (much more variation)
          final particlesInGroup = 4 + random.nextInt(20); // 4-24 particles per group (more varied sizes)
      
      // Calculate distance range: 5-20% of screen diagonal (even more vertical spread)
      final minDistance = screenDiagonal * 0.05; // 5% of diagonal
      final maxDistance = screenDiagonal * 0.20; // 20% of diagonal (increased for longer streaks)
      
      // First particle at the group starting position
      final firstRadius = 4 + random.nextInt(5); // Random radius 4-9 pixels
      centerPoints.add(_CircleInfo(
        centerX: groupStartX,
        centerY: groupStartY,
        radius: firstRadius,
      ));
      
      // Generate remaining particles around the first particle
      for (int i = 1; i < particlesInGroup; i++) {
        // Random distance from first particle (2-8% of screen diagonal)
        final distance = minDistance + random.nextDouble() * (maxDistance - minDistance);
        
        // Calculate horizontal constraint based on distance
        // The farther away, the less horizontal spread allowed
        // Normalize distance to 0-1 range
        final normalizedDistance = (distance - minDistance) / (maxDistance - minDistance);
        
            // Horizontal spread: starts at 0.06 (6% spread) and reduces to 0 as distance increases (even more vertical)
            final horizontalSpread = 0.06 * (1.0 - normalizedDistance); // 0.06 to 0.0 (reduced for more vertical bias)
        
        // Random angle, but mainly vertical
        // For far particles (high normalizedDistance), force almost perfectly vertical
        final baseAngle = (random.nextDouble() - 0.5) * pi; // -π/2 to π/2 (vertical bias)
        final horizontalVariation = (random.nextDouble() - 0.5) * pi * 0.05 * horizontalSpread; // ±2.5% of π, scaled by spread
        final angle = baseAngle + horizontalVariation;
        
        final centerX = (groupStartX + (cos(angle) * distance)).round().clamp(0, gridWidth - 1);
        final centerY = (groupStartY + (sin(angle) * distance)).round().clamp(0, gridHeight - 1);
        
        // Radius decreases with distance from first particle
        // Close particles: 4-9 pixels
        // Far particles: 2-4 pixels
        final minRadius = 2 + (2 * (1.0 - normalizedDistance)).round(); // 4 to 2
        final maxRadius = 4 + (5 * (1.0 - normalizedDistance)).round(); // 9 to 4
        final radius = minRadius + random.nextInt((maxRadius - minRadius + 1).clamp(1, 100));
        
        centerPoints.add(_CircleInfo(
          centerX: centerX,
          centerY: centerY,
          radius: radius,
        ));
      }
    }
    
        // Fill the grid with pattern
        for (final circle in centerPoints) {
          _fillCircleInGrid(gridFill, circle, gridWidth, gridHeight, random);
        }
        
        // Create liquid-like bridges between close particles
        _createLiquidBridges(gridFill, centerPoints, gridWidth, gridHeight, random);
    
    // Render the grid to canvas
    _renderGridToCanvas(canvas, gridFill, size, gridWidth, gridHeight);
  }

      void _fillCircleInGrid(List<List<double>> gridFill, _CircleInfo circle, int gridWidth, int gridHeight, Random random) {
        final centerX = circle.centerX;
        final centerY = circle.centerY;
        final radius = circle.radius;
        
        // Create oval shape by varying radius based on angle
        final ovalFactor = 0.7; // Make particles 70% as wide as they are tall (elongated vertically)
    
    // Fill the main white circle (100% fill)
    final expansionRadius = (radius * 2.0).round(); // 100% expansion
    
    for (int gx = (centerX - expansionRadius).clamp(0, gridWidth - 1); 
         gx <= (centerX + expansionRadius).clamp(0, gridWidth - 1); 
         gx++) {
      for (int gy = (centerY - expansionRadius).clamp(0, gridHeight - 1); 
           gy <= (centerY + expansionRadius).clamp(0, gridHeight - 1); 
           gy++) {
        
            final dx = gx - centerX;
            final dy = gy - centerY;
            
            // Calculate oval shape parameters
            final radiusX = radius * ovalFactor; // Horizontal radius (narrower)
            final radiusY = radius; // Vertical radius (full)
            
            // Elliptical distance calculation for oval shape
            final ellipticalDistanceSquared = (dx * dx) / (radiusX * radiusX) + (dy * dy) / (radiusY * radiusY);
            final ellipticalDistance = sqrt(ellipticalDistanceSquared);
            
            double fillPercentage = 0.0;
            
            if (ellipticalDistance <= 1.0) {
              // Inside the oval - 100% fill
              fillPercentage = 1.0;
            } else if (ellipticalDistance <= 2.0) {
              // In the expansion area - gradient from 60% to 15%
              final expansionDistance = ellipticalDistance - 1.0;
              final maxExpansion = 1.0; // From 1.0 to 2.0
              final normalizedDistance = expansionDistance / maxExpansion;
              
              // Linear gradient from 60% to 15%
              fillPercentage = 0.6 - (normalizedDistance * 0.45); // 0.6 to 0.15
            }
        
        // Keep the maximum percentage (for overlapping areas)
        if (fillPercentage > 0) {
          gridFill[gx][gy] = max(gridFill[gx][gy], fillPercentage);
        }
      }
    }
  }

  void _createLiquidBridges(List<List<double>> gridFill, List<_CircleInfo> centerPoints, int gridWidth, int gridHeight, Random random) {
    // Find close particles and create bridges between them
    for (int i = 0; i < centerPoints.length; i++) {
      for (int j = i + 1; j < centerPoints.length; j++) {
        final particle1 = centerPoints[i];
        final particle2 = centerPoints[j];
        
        // Calculate distance between particles
        final dx = particle1.centerX - particle2.centerX;
        final dy = particle1.centerY - particle2.centerY;
        final distance = sqrt(dx * dx + dy * dy);
        
        // Create bridge if particles are close enough (within 1.8x the combined radius)
        final combinedRadius = particle1.radius + particle2.radius;
        final bridgeThreshold = combinedRadius * 1.8;
        
        if (distance < bridgeThreshold && distance > 0) {
          // Create a liquid bridge between the particles
          _createBridgeBetweenParticles(gridFill, particle1, particle2, gridWidth, gridHeight, random);
        }
      }
    }
  }

  void _createBridgeBetweenParticles(List<List<double>> gridFill, _CircleInfo particle1, _CircleInfo particle2, int gridWidth, int gridHeight, Random random) {
    // Calculate bridge properties
    final dx = particle2.centerX - particle1.centerX;
    final dy = particle2.centerY - particle1.centerY;
    final distance = sqrt(dx * dx + dy * dy);
    
    // Bridge width varies with distance (closer = thicker bridge)
    final maxBridgeWidth = min(particle1.radius, particle2.radius) * 1.2;
    final distanceFactor = 1.0 - (distance / (particle1.radius + particle2.radius + 5));
    final bridgeWidth = maxBridgeWidth * distanceFactor.clamp(0.5, 1.0);
    
    // Create bridge path with smooth curve for organic look
    final steps = (distance * 4).round(); // More steps for smoother bridge
    for (int step = 0; step <= steps; step++) {
      final t = step / steps;
      
      // Very subtle curve using sine wave for smooth bridge shape
      final curveOffset = sin(t * pi) * 1.2; // Smaller curve for smoother look
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
              // Right next to 100% particles: 100% fill
              // At maximum bridge radius: 30% fill
              double bridgeFill;
              if (minDistToParticle <= min(particle1.radius, particle2.radius)) {
                // 100% fill right next to 100% particles
                bridgeFill = 1.0;
              } else {
                // Gradual transition from 100% to 30% based on distance
                final proximityTo100Percent = (1.0 - (minDistToParticle / (bridgeRadius + particle1.radius + particle2.radius))).clamp(0.0, 1.0);
                bridgeFill = (0.3 + proximityTo100Percent * 0.7).clamp(0.3, 1.0);
              }
              
              // Blend with existing fill (take maximum)
              gridFill[gx][gy] = max(gridFill[gx][gy], bridgeFill);
            }
          }
        }
      }
    }
  }

  void _renderGridToCanvas(Canvas canvas, List<List<double>> gridFill, Size size, int gridWidth, int gridHeight) {
    // Each grid cell = 7 pixels
    final cellWidth = 7.0;
    final cellHeight = 7.0;
    
    final whitePaint = Paint()..color = config.lightColor;
    
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final fillPercentage = gridFill[gx][gy];
        
        if (fillPercentage > 0) {
          final x = gx * cellWidth;
          final y = gy * cellHeight;
          
          // Calculate the size of the white shape based on percentage
          // The shape should take up fillPercentage of the cell area
          final shapeWidth = cellWidth * sqrt(fillPercentage);
          final shapeHeight = cellHeight * sqrt(fillPercentage);
          
          // Center the shape within the cell
          final shapeX = x + (cellWidth - shapeWidth) / 2;
          final shapeY = y + (cellHeight - shapeHeight) / 2;
          
          // Calculate corner radius based on fill percentage
          // 100% fill (1.0) = 0% radius (square)
          // 0% fill (0.0) = 100% radius (circle)
          // Inverted relationship: lower percentage = more circular
          final radiusPercentage = 1.0 - fillPercentage;
          var cornerRadius = min(shapeWidth, shapeHeight) / 2 * radiusPercentage;
          
          // Special handling for 100% fill particles (normally square)
          RRect shapeRRect;
          
          if (fillPercentage >= 0.99) {
            // Check neighboring particles
            final left = gx > 0 ? gridFill[gx - 1][gy] : 0.0;
            final right = gx < gridWidth - 1 ? gridFill[gx + 1][gy] : 0.0;
            final top = gy > 0 ? gridFill[gx][gy - 1] : 0.0;
            final bottom = gy < gridHeight - 1 ? gridFill[gx][gy + 1] : 0.0;
            
            // Check if neighbors are non-100%
            final hasLeftNon100 = left > 0 && left < 0.99;
            final hasRightNon100 = right > 0 && right < 0.99;
            final hasTopNon100 = top > 0 && top < 0.99;
            final hasBottomNon100 = bottom > 0 && bottom < 0.99;
            
            // Count non-100% neighbors
            final nonFullNeighbors = [hasLeftNon100, hasRightNon100, hasTopNon100, hasBottomNon100]
                .where((has) => has).length;
            
            if (nonFullNeighbors >= 2) {
              // Has 2+ non-100% neighbors: add corner radius only to corners touching them
              final maxRadius = min(shapeWidth, shapeHeight) / 2;
              final radiusAmount = maxRadius * 0.8; // 80% radius for affected corners (more round)
              
              // Check diagonal neighbors to determine if corner should be rounded
              final topLeft = (gx > 0 && gy > 0) ? gridFill[gx - 1][gy - 1] : 0.0;
              final topRight = (gx < gridWidth - 1 && gy > 0) ? gridFill[gx + 1][gy - 1] : 0.0;
              final bottomLeft = (gx > 0 && gy < gridHeight - 1) ? gridFill[gx - 1][gy + 1] : 0.0;
              final bottomRight = (gx < gridWidth - 1 && gy < gridHeight - 1) ? gridFill[gx + 1][gy + 1] : 0.0;
              
              // Check if diagonal neighbors are 100%
              final hasTopLeft100 = topLeft >= 0.99;
              final hasTopRight100 = topRight >= 0.99;
              final hasBottomLeft100 = bottomLeft >= 0.99;
              final hasBottomRight100 = bottomRight >= 0.99;
              
              // Determine which corners should be rounded based on neighboring non-100% particles
              // A corner should ONLY be rounded if BOTH of its adjacent sides have non-100% particles
              
              // Top-left corner: BOTH top AND left must be non-100%
              final topLeftRadius = (hasTopNon100 && hasLeftNon100) && !hasTopLeft100
                  ? Radius.circular(radiusAmount) : Radius.zero;
              
              // Top-right corner: BOTH top AND right must be non-100%
              final topRightRadius = (hasTopNon100 && hasRightNon100) && !hasTopRight100
                  ? Radius.circular(radiusAmount) : Radius.zero;
              
              // Bottom-left corner: BOTH bottom AND left must be non-100%
              final bottomLeftRadius = (hasBottomNon100 && hasLeftNon100) && !hasBottomLeft100
                  ? Radius.circular(radiusAmount) : Radius.zero;
              
              // Bottom-right corner: BOTH bottom AND right must be non-100%
              final bottomRightRadius = (hasBottomNon100 && hasRightNon100) && !hasBottomRight100
                  ? Radius.circular(radiusAmount) : Radius.zero;
              
              shapeRRect = RRect.fromLTRBAndCorners(
                shapeX, shapeY, shapeX + shapeWidth, shapeY + shapeHeight,
                topLeft: topLeftRadius,
                topRight: topRightRadius,
                bottomLeft: bottomLeftRadius,
                bottomRight: bottomRightRadius,
              );
            } else {
              // All neighbors are 100% or no neighbors: stay square
              shapeRRect = RRect.fromRectAndRadius(
                Rect.fromLTWH(shapeX, shapeY, shapeWidth, shapeHeight),
                Radius.zero,
              );
            }
          } else {
            // Add organic variation: for non-square shapes (radiusPercentage > 0),
            // randomly reduce corner radius for some shapes to create varied forms
            if (radiusPercentage > 0.05) {
              // Use deterministic randomness based on position
              final positionSeed = (gx * 1000 + gy).hashCode;
              final localRandom = Random(positionSeed);
              
              // 50% chance to reduce the corner radius
              if (localRandom.nextDouble() < 0.5) {
                // Reduce radius by 50-90% (much more dramatic)
                final reductionFactor = 0.1 + localRandom.nextDouble() * 0.4;
                cornerRadius *= reductionFactor;
              }
            }
            
            shapeRRect = RRect.fromRectAndRadius(
              Rect.fromLTWH(shapeX, shapeY, shapeWidth, shapeHeight),
              Radius.circular(cornerRadius),
            );
          }
          
          canvas.drawRRect(shapeRRect, whitePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.config != config;
  }
}

class _CircleInfo {
  final int centerX;
  final int centerY;
  final int radius;

  const _CircleInfo({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });
}
