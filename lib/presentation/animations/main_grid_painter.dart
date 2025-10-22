import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:isolate_manager/isolate_manager.dart';
import '../../data/models/background_config.dart';
import '../../utils/app_constants.dart';
import '../../logic/isolate/background_pattern_isolate.dart';
import 'render_painter.dart';

/// Main painter that orchestrates all specialized painters
class MainGridPainter extends CustomPainter {
  final BackgroundConfig config;
  late final RenderPainter _renderPainter;
  
  // Cache the generated pattern to avoid recalculating on every paint call
  List<List<double>>? _cachedGridFill;
  int? _cachedGridWidth;
  int? _cachedGridHeight;
  Size? _cachedSize;
  BackgroundConfig? _cachedConfig;
  
  // Isolate manager for pattern generation
  IsolateManager<dynamic, dynamic>? _isolateManager;
  bool _isGenerating = false;

  MainGridPainter({required this.config}) {
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
                               _cachedSize != size ||
                               _cachedConfig != config;
    
    if (needsRegeneration && !_isGenerating) {
      _generateAndCachePattern(size);
    }
    
    // Render the cached pattern
    if (_cachedGridFill != null && _cachedGridWidth != null && _cachedGridHeight != null) {
      _renderPainter.renderGridToCanvas(canvas, _cachedGridFill!, size, _cachedGridWidth!, _cachedGridHeight!);
    }
  }
  
  void _generateAndCachePattern(Size size) async {
    if (_isGenerating) return;
    
    _isGenerating = true;
    
    try {
      // Initialize isolate manager if not already done
      if (_isolateManager == null) {
        _isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
          backgroundPatternWorker,
          workerName: AppConstants.isolateWorkerName,
          concurrent: AppConstants.isolateConcurrency,
        );
      }
      
      // Generate pattern in isolate
      await _isolateManager!.compute(
        jsonEncode(BackgroundPatternInput(
          width: size.width,
          height: size.height,
          darkColorValue: config.darkColor.value,
          lightColorValue: config.lightColor.value,
          randomSeed: config.randomSeed,
        ).toJson()),
        callback: (dynamic value) {
          final Map<String, dynamic> data = jsonDecode(value);
          
          if (data.containsKey('result')) {
            // Final result received
            final result = BackgroundPatternOutput.fromJson(data['result']);
            
            // Cache the results
            _cachedGridFill = result.gridFill;
            _cachedGridWidth = result.gridWidth;
            _cachedGridHeight = result.gridHeight;
            _cachedSize = size;
            _cachedConfig = config;
            
            _isGenerating = false;
            return true; // This is the final result
          }
          
          return false; // Not the final result
        },
      );
    } catch (e) {
      print('${AppConstants.errorGeneratingPattern}$e');
      _isGenerating = false;
    }
  }

  // Pattern generation is now handled by the isolate

  @override
  bool shouldRepaint(covariant MainGridPainter oldDelegate) {
    // Only repaint when the config actually changes
    return oldDelegate.config != config;
  }
}
