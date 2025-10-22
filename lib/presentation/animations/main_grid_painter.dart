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
  final BackgroundPatternOutput? patternData;
  late final RenderPainter _renderPainter;

  MainGridPainter({required this.config, this.patternData}) {
    _renderPainter = RenderPainter(config: config);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw dark background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = config.darkColor,
    );

    // Render the pattern if available
    if (patternData != null) {
      _renderPainter.renderGridToCanvas(
        canvas, 
        patternData!.gridFill, 
        size, 
        patternData!.gridWidth, 
        patternData!.gridHeight
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant MainGridPainter oldDelegate) {
    // Only repaint when colors change or pattern data changes
    return oldDelegate.config.darkColor != config.darkColor ||
           oldDelegate.config.lightColor != config.lightColor ||
           oldDelegate.patternData != patternData;
  }
}
