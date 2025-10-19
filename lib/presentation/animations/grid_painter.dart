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
    
    // Create multiple groups spread around the screen
    final numGroups = 1 + random.nextInt(2); // Random number of groups (1-2)
    
    // Define opposing region pairs (far from each other)
    final opposingRegionPairs = [
      [
        {'minX': 0, 'maxX': gridWidth ~/ 3, 'minY': 0, 'maxY': gridHeight ~/ 3}, // Top-left
        {'minX': gridWidth * 2 ~/ 3, 'maxX': gridWidth, 'minY': gridHeight * 2 ~/ 3, 'maxY': gridHeight}, // Bottom-right
      ],
      [
        {'minX': gridWidth * 2 ~/ 3, 'maxX': gridWidth, 'minY': 0, 'maxY': gridHeight ~/ 3}, // Top-right
        {'minX': 0, 'maxX': gridWidth ~/ 3, 'minY': gridHeight * 2 ~/ 3, 'maxY': gridHeight}, // Bottom-left
      ],
      [
        {'minX': gridWidth ~/ 3, 'maxX': gridWidth * 2 ~/ 3, 'minY': 0, 'maxY': gridHeight ~/ 4}, // Top-center
        {'minX': gridWidth ~/ 3, 'maxX': gridWidth * 2 ~/ 3, 'minY': gridHeight * 3 ~/ 4, 'maxY': gridHeight}, // Bottom-center
      ],
      [
        {'minX': 0, 'maxX': gridWidth ~/ 4, 'minY': gridHeight ~/ 3, 'maxY': gridHeight * 2 ~/ 3}, // Left-center
        {'minX': gridWidth * 3 ~/ 4, 'maxX': gridWidth, 'minY': gridHeight ~/ 3, 'maxY': gridHeight * 2 ~/ 3}, // Right-center
      ],
    ];
    
    // Pick a random pair of opposing regions
    final selectedPair = opposingRegionPairs[random.nextInt(opposingRegionPairs.length)];
    
    for (int group = 0; group < numGroups; group++) {
      // Get opposing region for this group (first group gets first region, second gets opposite)
      final region = selectedPair[group % selectedPair.length];
      
      // Random position within this region
      final groupCenterX = region['minX']! + random.nextInt(region['maxX']! - region['minX']!);
      final groupCenterY = region['minY']! + random.nextInt(region['maxY']! - region['minY']!);
      
      // Random number of points in this group (varying sizes)
      final pointsInGroup = 15 + random.nextInt(60); // 15-75 points per group
      
      // Random cluster radius for this group
      final clusterRadius = 30 + random.nextInt(70); // 30-100 pixels cluster radius
      
      // Generate points clustered around this group's center
      for (int i = 0; i < pointsInGroup; i++) {
        // Random angle and distance from group center
        final angle = random.nextDouble() * 2 * pi;
        final distance = random.nextDouble() * clusterRadius;
        
        final centerX = (groupCenterX + (cos(angle) * distance)).round().clamp(0, gridWidth - 1);
        final centerY = (groupCenterY + (sin(angle) * distance)).round().clamp(0, gridHeight - 1);
        final radius = 5 + random.nextInt(15); // Random radius 5-20 pixels
        
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
    final expansionRadius = (radius * 1.5).round(); // 50% expansion
    
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
          
          canvas.drawRect(
            Rect.fromLTWH(shapeX, shapeY, shapeWidth, shapeHeight),
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
