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
    
    // Create fewer groups evenly distributed
    final numGroups = 8 + random.nextInt(5); // 8-12 groups
    
    // Calculate grid layout for very vertical distribution
    // Very few columns (very narrow) and many rows (very tall)
    final cols = max(1, (sqrt(numGroups) * 0.3).ceil()); // 70% fewer columns - mainly vertical
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
      
      // Random number of particles in this group (varying sizes)
      final particlesInGroup = 6 + random.nextInt(12); // 6-18 particles per group
      
      // Calculate distance range: 3-15% of screen diagonal (increased for more vertical spread)
      final minDistance = screenDiagonal * 0.03; // 3% of diagonal
      final maxDistance = screenDiagonal * 0.15; // 15% of diagonal
      
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
        
        // Horizontal spread: starts at 0.08 (8% spread) and reduces to 0 as distance increases
        final horizontalSpread = 0.08 * (1.0 - normalizedDistance); // 0.08 to 0.0
        
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
    
    // Render the grid to canvas
    _renderGridToCanvas(canvas, gridFill, size, gridWidth, gridHeight);
  }

  void _fillCircleInGrid(List<List<double>> gridFill, _CircleInfo circle, int gridWidth, int gridHeight, Random random) {
    final centerX = circle.centerX;
    final centerY = circle.centerY;
    final radius = circle.radius;
    
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
        final distanceSquared = dx * dx + dy * dy;
        final distance = sqrt(distanceSquared);
        
        double fillPercentage = 0.0;
        
        if (distance <= radius) {
          // Inside the white circle - 100% fill
          fillPercentage = 1.0;
        } else if (distance <= expansionRadius) {
          // In the expansion area - gradient from 60% to 15%
          final expansionDistance = distance - radius;
          final maxExpansion = expansionRadius - radius;
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
          final cornerRadius = min(shapeWidth, shapeHeight) / 2 * radiusPercentage;
          
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(shapeX, shapeY, shapeWidth, shapeHeight),
              Radius.circular(cornerRadius),
            ),
            whitePaint,
          );
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
