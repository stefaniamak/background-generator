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
    
        // Calculate grid size based on screen size and cell size (5 pixels per cell)
        const cellSize = 5.0;
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
      
          // Random number of particles in this group (reduced density)
          final particlesInGroup = 3 + random.nextInt(12); // 3-15 particles per group (reduced from 4-24)
      
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
        
        // Apply isolation rule to remove adjacent outside particles
        _enforceIsolationRule(gridFill, gridWidth, gridHeight);
        
        // Fill gaps between close 100% particles
        _fillGapsBetweenParticles(gridFill, gridWidth, gridHeight);
        
        // Convert outside particles adjacent to 100% particles to 100% particles
        _convertAdjacentOutsideTo100Percent(gridFill, gridWidth, gridHeight);
        
        // Create diagonal bridges between close outside particles
        _createDiagonalOutsideBridges(gridFill, gridWidth, gridHeight);
        
        // Apply dramatic size differences to outside particles (LAST STEP)
        _applyDramaticSizeDifferences(gridFill, gridWidth, gridHeight);
        
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
          // In the expansion area - only keep diagonal particles in checkerboard pattern
          // Check if this grid position should have an outside particle (diagonal pattern)
          final shouldKeep = (gx % 2 == gy % 2); // Diagonal checkerboard pattern
          
          if (shouldKeep) {
            // Gradient from 90% to 20% for kept particles
            final expansionDistance = ellipticalDistance - 1.0;
            final maxExpansion = 1.0; // From 1.0 to 2.0
            final normalizedDistance = expansionDistance / maxExpansion;
            
            // Linear gradient from 90% to 20% (higher close, lower far)
            fillPercentage = 0.9 - (normalizedDistance * 0.7); // 0.9 to 0.2
          } else {
            // Skip this particle - no outside expansion here
            fillPercentage = 0.0;
          }
        }
        
        // Keep the maximum percentage (for overlapping areas)
        if (fillPercentage > 0) {
          gridFill[gx][gy] = max(gridFill[gx][gy], fillPercentage);
        }
      }
    }
  }

  void _applyDramaticSizeDifferences(List<List<double>> gridFill, int gridWidth, int gridHeight) {
    // Find all 100% particles
    final hundredPercentParticles = <(int, int)>[];
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        if (gridFill[gx][gy] >= 0.99) {
          hundredPercentParticles.add((gx, gy));
        }
      }
    }
    
    // Apply very dramatic size differences to outside particles based on distance to closest 100% particle
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = gridFill[gx][gy];
        
        // Only process outside particles (non-100% fill but > 0)
        if (currentFill > 0 && currentFill < 0.99) {
          // Find the closest 100% particle to this outside particle
          double minDistanceToClosest = double.infinity;
          for (final (px, py) in hundredPercentParticles) {
            final dx = gx - px;
            final dy = gy - py;
            final distanceToThis100Percent = sqrt(dx * dx + dy * dy);
            minDistanceToClosest = min(minDistanceToClosest, distanceToThis100Percent);
          }
          
          if (minDistanceToClosest < double.infinity) {
            // Calculate fill percentage based on distance to the closest 100% particle
            double newFillPercentage;
            
            if (minDistanceToClosest <= 1.0) {
              // Very close to closest 100% particle
              newFillPercentage = 0.95; // 95% size - much larger
            } else if (minDistanceToClosest <= 2.0) {
              // Close to closest 100% particle
              newFillPercentage = 0.8; // 80% size - much larger
            } else if (minDistanceToClosest <= 3.0) {
              // Medium distance from closest 100% particle
              newFillPercentage = 0.6; // 60% size - much larger
            } else if (minDistanceToClosest <= 4.0) {
              // Far distance from closest 100% particle
              newFillPercentage = 0.3; // 30% size - much larger
            } else if (minDistanceToClosest <= 6.0) {
              // Very far distance from closest 100% particle
              newFillPercentage = 0.4; // 40% size - much larger
            } else {
              // Extremely far distance from closest 100% particle
              newFillPercentage = 0.25; // 25% size - much larger
            }
            
            // Force the dramatic size difference based on distance to closest 100% particle
            gridFill[gx][gy] = newFillPercentage;
          }
        }
      }
    }
  }

  void _enforceIsolationRule(List<List<double>> gridFill, int gridWidth, int gridHeight) {
    // Create a copy to avoid modifying while iterating
    final originalFill = List.generate(gridWidth, (i) => List.generate(gridHeight, (j) => gridFill[i][j]));
    
    // Apply isolation rule: enforce diagonal checkerboard pattern for outside particles
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = originalFill[gx][gy];
        
        // Only process outside particles (non-100% fill)
        if (currentFill > 0 && currentFill < 0.99) {
          // Check if this position should have an outside particle according to checkerboard pattern
          final shouldKeep = (gx % 2 == gy % 2); // Diagonal checkerboard pattern
          
          if (!shouldKeep) {
            // Remove outside particles that don't follow the checkerboard pattern
            gridFill[gx][gy] = 0.0;
          }
          // If shouldKeep is true, keep the outside particle (it's in correct checkerboard position)
        }
        // Always keep 100% fill particles regardless of position
      }
    }
  }


  void _fillGapsBetweenParticles(List<List<double>> gridFill, int gridWidth, int gridHeight) {
    // Find gaps between 100% particles and fill them if they're small enough
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = gridFill[gx][gy];
        
        // Only process empty or low-fill positions
        if (currentFill < 0.99) {
          
          // Check horizontal direction (left and right)
          bool has100PercentLeft = false;
          bool has100PercentRight = false;
          int gapSizeHorizontal = 0;
          
          // Look left
          for (int dx = 1; dx <= 4; dx++) { // Check up to 4 cells away
            if (gx - dx >= 0) {
              if (gridFill[gx - dx][gy] >= 0.99) {
                has100PercentLeft = true;
                gapSizeHorizontal = dx - 1; // Gap size is the distance minus 1
                break;
              }
            } else {
              break;
            }
          }
          
          // Look right
          for (int dx = 1; dx <= 4; dx++) { // Check up to 4 cells away
            if (gx + dx < gridWidth) {
              if (gridFill[gx + dx][gy] >= 0.99) {
                has100PercentRight = true;
                gapSizeHorizontal += dx - 1; // Add to gap size
                break;
              }
            } else {
              break;
            }
          }
          
          // Check vertical direction (up and down)
          bool has100PercentUp = false;
          bool has100PercentDown = false;
          int gapSizeVertical = 0;
          
          // Look up
          for (int dy = 1; dy <= 4; dy++) { // Check up to 4 cells away
            if (gy - dy >= 0) {
              if (gridFill[gx][gy - dy] >= 0.99) {
                has100PercentUp = true;
                gapSizeVertical = dy - 1; // Gap size is the distance minus 1
                break;
              }
            } else {
              break;
            }
          }
          
          // Look down
          for (int dy = 1; dy <= 4; dy++) { // Check up to 4 cells away
            if (gy + dy < gridHeight) {
              if (gridFill[gx][gy + dy] >= 0.99) {
                has100PercentDown = true;
                gapSizeVertical += dy - 1; // Add to gap size
                break;
              }
            } else {
              break;
            }
          }
          
          // Fill the gap if it's small enough (1-3 cells between 100% particles)
          if ((has100PercentLeft && has100PercentRight && gapSizeHorizontal <= 2) ||
              (has100PercentUp && has100PercentDown && gapSizeVertical <= 2)) {
            // Fill gaps with 100% fill to create solid connections
            gridFill[gx][gy] = 1.0;
          }
        }
      }
    }
  }

  void _convertAdjacentOutsideTo100Percent(List<List<double>> gridFill, int gridWidth, int gridHeight) {
    // Create a copy to avoid modifying while iterating
    final originalFill = List.generate(gridWidth, (i) => List.generate(gridHeight, (j) => gridFill[i][j]));
    
    // Convert outside particles that are adjacent to 100% particles to 100% particles
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = originalFill[gx][gy];
        
        // Only process outside particles (non-100% fill but > 0)
        if (currentFill > 0 && currentFill < 0.99) {
          bool hasAdjacent100Percent = false;
          
          // Check all 4 adjacent positions (up, down, left, right)
          final adjacentPositions = [
            (gx - 1, gy), (gx + 1, gy), (gx, gy - 1), (gx, gy + 1)
          ];
          
          for (final (adjGx, adjGy) in adjacentPositions) {
            if (adjGx >= 0 && adjGx < gridWidth && adjGy >= 0 && adjGy < gridHeight) {
              final adjacentFill = originalFill[adjGx][adjGy];
              if (adjacentFill >= 0.99) { // Adjacent 100% particle exists
                hasAdjacent100Percent = true;
                break;
              }
            }
          }
          
          // Convert this outside particle to 100% if it has adjacent 100% particles
          if (hasAdjacent100Percent) {
            gridFill[gx][gy] = 1.0; // Convert to 100% particle
          }
        }
      }
    }
  }

  void _createDiagonalOutsideBridges(List<List<double>> gridFill, int gridWidth, int gridHeight) {
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
        
        // Create bridge if particles are close enough (within 5 grid cells for longer reach)
        const bridgeThreshold = 5.0;
        
        if (distance < bridgeThreshold && distance > 0) {
          // Create a diagonal bridge between the outside particles
          _createDiagonalBridgeBetweenOutsideParticles(gridFill, x1, y1, x2, y2, gridWidth, gridHeight);
        }
      }
    }
  }

  void _createDiagonalBridgeBetweenOutsideParticles(List<List<double>> gridFill, int x1, int y1, int x2, int y2, int gridWidth, int gridHeight) {
    // Calculate bridge properties
    final dx = x2 - x1;
    final dy = y2 - y1;
    final distance = sqrt(dx * dx + dy * dy);
    
    // Create diagonal bridge path - only fill diagonal positions
    final steps = (distance * 2).round();
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
          
          // Apply bridge fill with slight reduction for bridge effect
          final bridgeFill = averageFill * 0.9; // 90% of average outside particle fill
          
          // Only apply if it increases the fill percentage
          final existingFill = gridFill[bridgeX][bridgeY];
          if (bridgeFill > existingFill) {
            gridFill[bridgeX][bridgeY] = bridgeFill;
          }
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
        
        // Only create bridges for vertical connections (similar Y coordinates)
        final yDifference = (particle1.centerY - particle2.centerY).abs();
        final xDifference = (particle1.centerX - particle2.centerX).abs();
        final isVerticalConnection = yDifference > xDifference * 2; // Much more vertical than horizontal
        
        if (distance < bridgeThreshold && distance > 0 && isVerticalConnection) {
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
              // Extended area around 100% particles: 100% fill
              // At maximum bridge radius: 30% fill
              double bridgeFill;
              final extendedRadius = min(particle1.radius, particle2.radius) * 1.5; // 50% larger area for 100% fill
              if (minDistToParticle <= extendedRadius) {
                // 100% fill in extended area around 100% particles
                bridgeFill = 1.0;
              } else {
                // Follow the same gradient as the outside expansion areas (90% to 20%)
                final proximityTo100Percent = (1.0 - (minDistToParticle / (bridgeRadius + particle1.radius + particle2.radius))).clamp(0.0, 1.0);
                bridgeFill = (0.9 - proximityTo100Percent * 0.7).clamp(0.2, 0.9); // 90% to 20% fill
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
    // Each grid cell = 5 pixels
    final cellWidth = 5.0;
    final cellHeight = 5.0;
    
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
