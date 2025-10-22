import 'dart:convert';
import 'dart:math';
import 'package:isolate_manager/isolate_manager.dart';

/// Input data structure for the isolate computation
class BackgroundPatternInput {
  final double width;
  final double height;
  final int darkColorValue;
  final int lightColorValue;
  final int randomSeed;

  BackgroundPatternInput({
    required this.width,
    required this.height,
    required this.darkColorValue,
    required this.lightColorValue,
    required this.randomSeed,
  });

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'darkColorValue': darkColorValue,
    'lightColorValue': lightColorValue,
    'randomSeed': randomSeed,
  };

  factory BackgroundPatternInput.fromJson(Map<String, dynamic> json) => BackgroundPatternInput(
    width: json['width']?.toDouble() ?? 0.0,
    height: json['height']?.toDouble() ?? 0.0,
    darkColorValue: json['darkColorValue'] ?? 0xFF000000,
    lightColorValue: json['lightColorValue'] ?? 0xFF242424,
    randomSeed: json['randomSeed'] ?? 43,
  );
}

/// Output data structure for the isolate computation
class BackgroundPatternOutput {
  final List<List<double>> gridFill;
  final int gridWidth;
  final int gridHeight;
  final bool isComplete;

  BackgroundPatternOutput({
    required this.gridFill,
    required this.gridWidth,
    required this.gridHeight,
    required this.isComplete,
  });

  Map<String, dynamic> toJson() => {
    'gridFill': gridFill,
    'gridWidth': gridWidth,
    'gridHeight': gridHeight,
    'isComplete': isComplete,
  };

  factory BackgroundPatternOutput.fromJson(Map<String, dynamic> json) => BackgroundPatternOutput(
    gridFill: List<List<double>>.from(
      (json['gridFill'] as List).map((row) => List<double>.from(row))
    ),
    gridWidth: json['gridWidth'] ?? 0,
    gridHeight: json['gridHeight'] ?? 0,
    isComplete: json['isComplete'] ?? false,
  );
}

/// Particle center data structure
class ParticleCenter {
  final int centerX;
  final int centerY;
  final int radius;

  ParticleCenter({
    required this.centerX,
    required this.centerY,
    required this.radius,
  });

  Map<String, dynamic> toJson() => {
    'centerX': centerX,
    'centerY': centerY,
    'radius': radius,
  };

  factory ParticleCenter.fromJson(Map<String, dynamic> json) => ParticleCenter(
    centerX: json['centerX'] ?? 0,
    centerY: json['centerY'] ?? 0,
    radius: json['radius'] ?? 0,
  );
}

/// Core constants for all painters (moved from painter_constants.dart)
class PainterConstants {
  // Grid and Cell Configuration
  static const double cellWidth = 5.0;
  static const double cellHeight = 3.0;
  static const double ovalFactor = 0.5;
  
  // Particle Generation
  static const int minGroups = 10;
  static const int maxGroups = 14;
  static const double groupColumnsReduction = 0.25;
  
  static const int minParticlesPerGroup = 4;
  static const int maxParticlesPerGroup = 10;
  
  static const int minParticleRadius = 5;
  static const int maxParticleRadius = 12;

  // Screen-scaling configuration
  static const int cellsPerGroupTarget = 2200;
  static const int particlesReferenceArea = 35000;
  static const double particlesScaleMin = 1.0;
  static const double particlesScaleMax = 2.5;
  
  // Distance and Spread Configuration
  static const double minDistancePercentage = 0.04;
  static const double maxDistancePercentage = 0.12;
  static const double horizontalSpreadBase = 0.08;
  static const double horizontalVariationFactor = 0.06;
  
  // Particle Expansion
  static const double expansionRadiusMultiplier = 1.9;
  static const double expansionDistanceMax = 1.9;
  static const double expansionGradientMax = 1.4;
  
  // Fill Percentages
  static const double baseFillPercentage = 0.85;
  static const double minFillPercentage = 0.25;
  static const double fillGradientRange = 0.6;
  
  // Distance-Based Sizing
  static const double veryCloseFill = 0.95;
  static const double closeFill = 0.8;
  static const double mediumFill = 0.6;
  static const double farFill = 0.3;
  static const double veryFarFill = 0.4;
  static const double extremelyFarFill = 0.25;
  
  // Distance Thresholds for Sizing
  static const double veryCloseDistance = 1.0;
  static const double closeDistance = 2.0;
  static const double mediumDistance = 3.0;
  static const double farDistance = 4.0;
  static const double veryFarDistance = 6.0;
  
  // Bridge Configuration
  static const double bridgeThresholdMultiplier = 1.1;
  static const double bridgeVerticalBias = 2.4;
  static const double bridgeCurveOffset = 1.4;
  static const double bridgeStepsMultiplier = 4.0;
  static const double bridgeWidthMultiplier = 1.9;
  static const double bridgeExtendedRadiusMultiplier = 2.6;
  
  // Bridge Fill Configuration
  static const double bridgeProximityFill = 0.97;
  static const double bridgeMinFill = 0.30;
  static const double bridgeMaxFill = 0.92;
  static const double bridgeFillRange = 0.70;
  
  // Bridge Randomness
  static const double bridgeRandomnessFactor = 0.35;
  static const double bridgeDistanceVariation = 0.35;
  
  // Diagonal Bridge Configuration
  static const double diagonalBridgeThreshold = 3.5;
  static const double diagonalBridgeStepsMultiplier = 2.0;
  static const double diagonalBridgeFillReduction = 0.6;
  
  // Pattern Rules
  static const int gapCheckDistance = 4;
  static const int maxGapSize = 2;
  
  // Rendering Configuration
  static const double organicVariationChance = 0.5;
  static const double organicVariationMin = 0.1;
  static const double organicVariationMax = 0.5;
  static const double organicVariationThreshold = 0.05;
}

/// Custom isolate worker for background pattern generation
@pragma('vm:entry-point')
@isolateManagerCustomWorker
void backgroundPatternWorker(dynamic params) {
  IsolateManagerFunction.customFunction<String, String>(
    params,
    onEvent: (controller, message) {
      try {
        final inputData = jsonDecode(message);
        final input = BackgroundPatternInput.fromJson(inputData);
        
        // Send progress update
        controller.sendResult(jsonEncode({
          'progress': 10,
          'message': 'Starting pattern generation...'
        }));
        
        // Calculate grid dimensions
        final (gridWidth, gridHeight) = _calculateGridDimensions(input.width, input.height);
        
        // Send progress update
        controller.sendResult(jsonEncode({
          'progress': 20,
          'message': 'Grid dimensions calculated: ${gridWidth}x${gridHeight}'
        }));
        
        // Create array to store fill percentages for each grid cell
        final gridFill = List.generate(gridWidth, (_) => List.generate(gridHeight, (_) => 0.0));
        
        // Send progress update
        controller.sendResult(jsonEncode({
          'progress': 30,
          'message': 'Grid initialized, generating particle groups...'
        }));
        
        // Generate the pattern using all the steps
        _drawPatternToGrid(gridFill, input, gridWidth, gridHeight, controller);
        
        // Send final result
        final output = BackgroundPatternOutput(
          gridFill: gridFill,
          gridWidth: gridWidth,
          gridHeight: gridHeight,
          isComplete: true,
        );
        
        controller.sendResult(jsonEncode({
          'result': output.toJson(),
          'message': 'Pattern generation complete!'
        }));
        
        return 'completed'; // Indicates completion
      } catch (err, stack) {
        controller.sendResultError(IsolateException(err.toString(), stack));
        return 'error';
      }
    },
    onInit: (controller) {
      // Initialize random seed if needed
    },
    onDispose: (controller) {
      // Cleanup if needed
    },
    autoHandleException: false,
    autoHandleResult: false,
  );
}

/// Calculate grid dimensions based on screen size
(int, int) _calculateGridDimensions(double width, double height) {
  final gridWidth = (width / PainterConstants.cellWidth).ceil();
  final gridHeight = (height / PainterConstants.cellHeight).ceil();
  return (gridWidth, gridHeight);
}

/// Main pattern generation logic
void _drawPatternToGrid(
  List<List<double>> gridFill,
  BackgroundPatternInput input,
  int gridWidth,
  int gridHeight,
  IsolateManagerController<String, String> controller,
) {
  // Step 1: Generate particle groups
  controller.sendResult(jsonEncode({
    'progress': 40,
    'message': 'Generating particle groups...'
  }));
  
  final centerPoints = _generateParticleGroups(input, gridWidth, gridHeight);
  
  // Step 2: Fill the grid with particles
  controller.sendResult(jsonEncode({
    'progress': 50,
    'message': 'Filling particles in grid...'
  }));
  
  for (final circle in centerPoints) {
    _fillParticleInGrid(gridFill, circle, centerPoints, gridWidth, gridHeight);
  }

  // Step 3: Create liquid-like bridges between close particles
  controller.sendResult(jsonEncode({
    'progress': 60,
    'message': 'Creating liquid bridges...'
  }));
  
  _createLiquidBridges(gridFill, centerPoints, gridWidth, gridHeight);

  // Step 4: Apply isolation rule to remove adjacent outside particles
  controller.sendResult(jsonEncode({
    'progress': 70,
    'message': 'Applying isolation rules...'
  }));
  
  _enforceIsolationRule(gridFill, gridWidth, gridHeight);

  // Step 5: Fill gaps between close 100% particles
  controller.sendResult(jsonEncode({
    'progress': 75,
    'message': 'Filling gaps between particles...'
  }));
  
  _fillGapsBetweenParticles(gridFill, gridWidth, gridHeight);

  // Step 6: Convert outside particles adjacent to 100% particles to 100% particles
  controller.sendResult(jsonEncode({
    'progress': 80,
    'message': 'Converting adjacent particles...'
  }));
  
  _convertAdjacentOutsideTo100Percent(gridFill, gridWidth, gridHeight);

  // Step 7: Upgrade particles that are completely surrounded by 100% particles
  controller.sendResult(jsonEncode({
    'progress': 85,
    'message': 'Upgrading surrounded particles...'
  }));
  
  _upgradeSurroundedParticles(gridFill, gridWidth, gridHeight);

  // Step 8: Create diagonal bridges between close outside particles
  controller.sendResult(jsonEncode({
    'progress': 90,
    'message': 'Creating diagonal bridges...'
  }));
  
  _createDiagonalOutsideBridges(gridFill, gridWidth, gridHeight);

  // Step 9: Apply dramatic size differences to outside particles (LAST STEP)
  controller.sendResult(jsonEncode({
    'progress': 95,
    'message': 'Applying distance-based sizing...'
  }));
  
  _applyDistanceBasedSizing(gridFill, gridWidth, gridHeight);
}

/// Generate clustered particle groups across the screen
List<ParticleCenter> _generateParticleGroups(BackgroundPatternInput input, int gridWidth, int gridHeight) {
  final centerPoints = <ParticleCenter>[];
  final random = Random(input.randomSeed);

  // Scale the number of groups by screen grid area
  final totalArea = gridWidth * gridHeight;
  final targetGroups = (totalArea / PainterConstants.cellsPerGroupTarget).clamp(
    PainterConstants.minGroups.toDouble(),
    PainterConstants.maxGroups.toDouble(),
  );
  final baseGroups = targetGroups.round();
  final jitter = (baseGroups * 0.1).round().clamp(0, 3);
  final numGroups = max(PainterConstants.minGroups, min(PainterConstants.maxGroups, baseGroups + (random.nextBool() ? jitter : -jitter)));

  // Calculate grid layout for very vertical distribution
  final cols = max(1, (sqrt(numGroups) * PainterConstants.groupColumnsReduction).ceil());
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
      final minRadius = 2 + ((PainterConstants.minParticleRadius - 2) * (1.0 - normalizedDistance)).round();
      final maxRadius = PainterConstants.minParticleRadius + ((PainterConstants.maxParticleRadius - PainterConstants.minParticleRadius) * (1.0 - normalizedDistance)).round();
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

/// Fill a single particle in the grid with distance-based sizing
void _fillParticleInGrid(
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

/// Create liquid-like bridges between close particles
void _createLiquidBridges(
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
      final isVerticalConnection = yDifference > xDifference * PainterConstants.bridgeVerticalBias;

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
  final steps = (distance * PainterConstants.bridgeStepsMultiplier).round();
  for (int step = 0; step <= steps; step++) {
    final t = step / steps;

    // Very subtle curve using sine wave for smooth bridge shape
    final curveOffset = sin(t * pi) * PainterConstants.bridgeCurveOffset;
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
            if (minDistToParticle <= 1.0) {
              bridgeFill = PainterConstants.bridgeProximityFill;
            } else {
              // Gradient from proximity to minimum fill
              final normalizedDistance = (minDistToParticle - 1.0) / PainterConstants.bridgeExtendedRadiusMultiplier;
              bridgeFill = PainterConstants.bridgeProximityFill - (normalizedDistance * PainterConstants.bridgeFillRange);
              bridgeFill = bridgeFill.clamp(PainterConstants.bridgeMinFill, PainterConstants.bridgeMaxFill);
            }

            // Keep the maximum percentage for overlapping areas
            gridFill[gx][gy] = max(gridFill[gx][gy], bridgeFill);
          }
        }
      }
    }
  }
}

/// Enforce isolation rule to remove adjacent outside particles
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

/// Fill gaps between close 100% particles
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
        for (int dx = 1; dx <= PainterConstants.gapCheckDistance; dx++) {
          if (gx - dx >= 0) {
            if (gridFill[gx - dx][gy] >= 0.99) {
              has100PercentLeft = true;
              gapSizeHorizontal = dx - 1;
              break;
            }
          } else {
            break;
          }
        }

        // Look right
        for (int dx = 1; dx <= PainterConstants.gapCheckDistance; dx++) {
          if (gx + dx < gridWidth) {
            if (gridFill[gx + dx][gy] >= 0.99) {
              has100PercentRight = true;
              gapSizeHorizontal += dx - 1;
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
        for (int dy = 1; dy <= PainterConstants.gapCheckDistance; dy++) {
          if (gy - dy >= 0) {
            if (gridFill[gx][gy - dy] >= 0.99) {
              has100PercentUp = true;
              gapSizeVertical = dy - 1;
              break;
            }
          } else {
            break;
          }
        }

        // Look down
        for (int dy = 1; dy <= PainterConstants.gapCheckDistance; dy++) {
          if (gy + dy < gridHeight) {
            if (gridFill[gx][gy + dy] >= 0.99) {
              has100PercentDown = true;
              gapSizeVertical += dy - 1;
              break;
            }
          } else {
            break;
          }
        }

        // Fill the gap if it's small enough
        if ((has100PercentLeft && has100PercentRight && gapSizeHorizontal <= PainterConstants.maxGapSize) ||
            (has100PercentUp && has100PercentDown && gapSizeVertical <= PainterConstants.maxGapSize)) {
          // Fill gaps with 100% fill to create solid connections
          gridFill[gx][gy] = 1.0;
        }
      }
    }
  }
}

/// Convert outside particles adjacent to 100% particles to 100% particles
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

/// Upgrade particles that are completely surrounded by 100% particles
void _upgradeSurroundedParticles(List<List<double>> gridFill, int gridWidth, int gridHeight) {
  bool hasChanges = true;
  int iterations = 0;
  const maxIterations = 10; // Prevent infinite loops

  // Keep upgrading until no more changes can be made
  while (hasChanges && iterations < maxIterations) {
    hasChanges = false;
    iterations++;

    // Create a copy to avoid modifying while iterating
    final originalFill = List.generate(gridWidth, (i) => List.generate(gridHeight, (j) => gridFill[i][j]));

    // Upgrade particles that are completely surrounded by 100% particles
    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final currentFill = originalFill[gx][gy];

        // Only process non-100% particles (including empty cells)
        if (currentFill < 0.99) {
          int surroundedCount = 0;
          int totalNeighbors = 0;

          // Check all 8 surrounding positions (including diagonals)
          final surroundingPositions = [
            (gx - 1, gy - 1), (gx, gy - 1), (gx + 1, gy - 1), // Top row
            (gx - 1, gy),                   (gx + 1, gy),     // Middle row (skip center)
            (gx - 1, gy + 1), (gx, gy + 1), (gx + 1, gy + 1)  // Bottom row
          ];

          for (final (surGx, surGy) in surroundingPositions) {
            if (surGx >= 0 && surGx < gridWidth && surGy >= 0 && surGy < gridHeight) {
              totalNeighbors++;
              final surroundingFill = originalFill[surGx][surGy];
              if (surroundingFill >= 0.99) { // Surrounded by 100% particle
                surroundedCount++;
              }
            }
          }

          // Upgrade to 100% if completely surrounded (all neighbors are 100%)
          if (totalNeighbors > 0 && surroundedCount == totalNeighbors) {
            gridFill[gx][gy] = 1.0; // Upgrade to 100% particle
            hasChanges = true; // Mark that we made a change
          }
        }
      }
    }
  }
}

/// Create diagonal bridges between close outside particles
void _createDiagonalOutsideBridges(List<List<double>> gridFill, int gridWidth, int gridHeight) {
  // Find close outside particles and create diagonal bridges between them
  for (int gx = 0; gx < gridWidth; gx++) {
    for (int gy = 0; gy < gridHeight; gy++) {
      final currentFill = gridFill[gx][gy];

      // Only process outside particles (non-100% fill but > 0)
      if (currentFill > 0 && currentFill < 0.99) {
        // Check diagonal positions for close outside particles
        final diagonalPositions = [
          (gx - 1, gy - 1), (gx + 1, gy - 1), (gx - 1, gy + 1), (gx + 1, gy + 1)
        ];

        for (final (diagGx, diagGy) in diagonalPositions) {
          if (diagGx >= 0 && diagGx < gridWidth && diagGy >= 0 && diagGy < gridHeight) {
            final diagonalFill = gridFill[diagGx][diagGy];
            
            // Create diagonal bridge if both are outside particles
            if (diagonalFill > 0 && diagonalFill < 0.99) {
              // Calculate distance between diagonal particles
              final dx = diagGx - gx;
              final dy = diagGy - gy;
              final distance = sqrt(dx * dx + dy * dy);

              // Create bridge if particles are close enough
              if (distance <= PainterConstants.diagonalBridgeThreshold) {
                // Create a simple diagonal bridge
                final steps = (distance * PainterConstants.diagonalBridgeStepsMultiplier).round();
                for (int step = 0; step <= steps; step++) {
                  final t = step / steps;
                  final bridgeX = (gx + t * dx).round();
                  final bridgeY = (gy + t * dy).round();

                  if (bridgeX >= 0 && bridgeX < gridWidth && bridgeY >= 0 && bridgeY < gridHeight) {
                    // Apply reduced fill for diagonal bridges
                    final bridgeFill = PainterConstants.baseFillPercentage * PainterConstants.diagonalBridgeFillReduction;
                    gridFill[bridgeX][bridgeY] = max(gridFill[bridgeX][bridgeY], bridgeFill);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

/// Apply dramatic size differences based on distance to closest 100% particle
void _applyDistanceBasedSizing(List<List<double>> gridFill, int gridWidth, int gridHeight) {
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
        double minDistance = double.infinity;
        for (final (hundredGx, hundredGy) in hundredPercentParticles) {
          final dx = gx - hundredGx;
          final dy = gy - hundredGy;
          final distance = sqrt(dx * dx + dy * dy);
          minDistance = min(minDistance, distance);
        }

        // Apply size based on distance
        double newFill;
        if (minDistance <= PainterConstants.veryCloseDistance) {
          newFill = PainterConstants.veryCloseFill;
        } else if (minDistance <= PainterConstants.closeDistance) {
          newFill = PainterConstants.closeFill;
        } else if (minDistance <= PainterConstants.mediumDistance) {
          newFill = PainterConstants.mediumFill;
        } else if (minDistance <= PainterConstants.farDistance) {
          newFill = PainterConstants.farFill;
        } else if (minDistance <= PainterConstants.veryFarDistance) {
          newFill = PainterConstants.veryFarFill;
        } else {
          newFill = PainterConstants.extremelyFarFill;
        }

        // Apply organic variation
        if (Random().nextDouble() < PainterConstants.organicVariationChance) {
          final variation = PainterConstants.organicVariationMin + 
              Random().nextDouble() * (PainterConstants.organicVariationMax - PainterConstants.organicVariationMin);
          newFill *= (1.0 - variation);
        }

        // Ensure minimum fill
        newFill = max(newFill, PainterConstants.minFillPercentage);

        gridFill[gx][gy] = newFill;
      }
    }
  }
}
