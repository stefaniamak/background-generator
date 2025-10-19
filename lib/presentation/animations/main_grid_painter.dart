import 'package:flutter/material.dart';
import '../../data/models/background_config.dart';
import 'particle_painter.dart';
import 'grouping_painter.dart';
import 'bridge_painter.dart';
import 'pattern_painter.dart';
import 'render_painter.dart';

/// Main painter that orchestrates all specialized painters
class MainGridPainter extends CustomPainter {
  final BackgroundConfig config;
  late final ParticlePainter _particlePainter;
  late final GroupingPainter _groupingPainter;
  late final BridgePainter _bridgePainter;
  late final PatternPainter _patternPainter;
  late final RenderPainter _renderPainter;
  
  // Cache the generated pattern to avoid recalculating on every paint call
  List<List<double>>? _cachedGridFill;
  int? _cachedGridWidth;
  int? _cachedGridHeight;
  Size? _cachedSize;

  MainGridPainter({required this.config}) {
    _particlePainter = ParticlePainter(config: config);
    _groupingPainter = GroupingPainter(config: config);
    _bridgePainter = BridgePainter(config: config);
    _patternPainter = PatternPainter(config: config);
    _renderPainter = RenderPainter(config: config);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw dark background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = config.darkColor,
    );

    // Check if we need to regenerate the pattern
    final needsRegeneration = _cachedGridFill == null || 
                               _cachedSize != size;
    
    if (needsRegeneration) {
      _generateAndCachePattern(size);
    }
    
    // Render the cached pattern
    if (_cachedGridFill != null && _cachedGridWidth != null && _cachedGridHeight != null) {
      _renderPainter.renderGridToCanvas(canvas, _cachedGridFill!, size, _cachedGridWidth!, _cachedGridHeight!);
    }
  }
  
  void _generateAndCachePattern(Size size) {
    final (gridWidth, gridHeight) = _particlePainter.calculateGridDimensions(size);

    // Create array to store fill percentages for each grid cell
    final gridFill = List.generate(gridWidth, (_) => List.generate(gridHeight, (_) => 0.0));

    // Generate the pattern using all the steps
    _drawPatternToGrid(gridFill, size, gridWidth, gridHeight);
    
    // Cache the results
    _cachedGridFill = gridFill;
    _cachedGridWidth = gridWidth;
    _cachedGridHeight = gridHeight;
    _cachedSize = size;
  }

  void _drawPatternToGrid(List<List<double>> gridFill, Size size, int gridWidth, int gridHeight) {
    // Step 1: Generate particle groups
    final centerPoints = _groupingPainter.generateParticleGroups(size);

    // Step 2: Fill the grid with particles
    for (final circle in centerPoints) {
      _particlePainter.fillParticleInGrid(gridFill, circle, centerPoints, gridWidth, gridHeight);
    }

    // Step 3: Create liquid-like bridges between close particles
    _bridgePainter.createLiquidBridges(gridFill, centerPoints, gridWidth, gridHeight);

    // Step 4: Apply isolation rule to remove adjacent outside particles
    _patternPainter.enforceIsolationRule(gridFill, gridWidth, gridHeight);

    // Step 5: Fill gaps between close 100% particles
    _patternPainter.fillGapsBetweenParticles(gridFill, gridWidth, gridHeight);

    // Step 6: Convert outside particles adjacent to 100% particles to 100% particles
    _patternPainter.convertAdjacentOutsideTo100Percent(gridFill, gridWidth, gridHeight);

    // Step 7: Create diagonal bridges between close outside particles
    _bridgePainter.createDiagonalOutsideBridges(gridFill, gridWidth, gridHeight);

    // Step 8: Apply dramatic size differences to outside particles (LAST STEP)
    _particlePainter.applyDistanceBasedSizing(gridFill, gridWidth, gridHeight);
  }

  @override
  bool shouldRepaint(covariant MainGridPainter oldDelegate) {
    // Only repaint when the config actually changes
    return oldDelegate.config != config;
  }
}
