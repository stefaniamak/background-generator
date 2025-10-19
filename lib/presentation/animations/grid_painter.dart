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
    
    // Create 1000x1000 grid
    const gridSize = 1000;
    
    // Create array to store fill percentages for each grid cell
    final gridFill = List.generate(gridSize, (_) => List.generate(gridSize, (_) => 0.0));
    
    // Generate random center points
    final centerPoints = <_CircleInfo>[];
    final numCenters = 300 + random.nextInt(300); // Random number of centers (300-600)
    
    for (int i = 0; i < numCenters; i++) {
      final centerX = random.nextInt(gridSize);
      final centerY = random.nextInt(gridSize);
      final radius = 5 + random.nextInt(15); // Random radius 5-20 pixels
      
      centerPoints.add(_CircleInfo(
        centerX: centerX,
        centerY: centerY,
        radius: radius,
      ));
    }
    
    // Fill the grid with pattern
    for (final circle in centerPoints) {
      _fillCircleInGrid(gridFill, circle, gridSize, random);
    }
    
    // Render the grid to canvas
    _renderGridToCanvas(canvas, gridFill, size, gridSize);
  }

  void _fillCircleInGrid(List<List<double>> gridFill, _CircleInfo circle, int gridSize, Random random) {
    final centerX = circle.centerX;
    final centerY = circle.centerY;
    final radius = circle.radius;
    
    // Fill the main white circle (100% fill)
    final expansionRadius = (radius * 1.5).round(); // 50% expansion
    
    for (int gx = (centerX - expansionRadius).clamp(0, gridSize - 1); 
         gx <= (centerX + expansionRadius).clamp(0, gridSize - 1); 
         gx++) {
      for (int gy = (centerY - expansionRadius).clamp(0, gridSize - 1); 
           gy <= (centerY + expansionRadius).clamp(0, gridSize - 1); 
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

  void _renderGridToCanvas(Canvas canvas, List<List<double>> gridFill, Size size, int gridSize) {
    // Each grid cell = 5 pixels
    final cellWidth = 5.0;
    final cellHeight = 5.0;
    
    // Calculate how many grid cells fit on screen
    final maxX = (size.width / cellWidth).round().clamp(0, gridSize - 1);
    final maxY = (size.height / cellHeight).round().clamp(0, gridSize - 1);
    
    final whitePaint = Paint()..color = config.lightColor;
    
    for (int gx = 0; gx < maxX; gx++) {
      for (int gy = 0; gy < maxY; gy++) {
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
