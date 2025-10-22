import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:isolate_manager/isolate_manager.dart';
import '../lib/logic/isolate/background_pattern_isolate.dart';

void main() {
  group('Background Pattern Isolate Tests', () {
    test('should generate pattern successfully', () async {
      final isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
        backgroundPatternWorker,
        workerName: 'backgroundPatternWorker',
        concurrent: 1,
      );

      try {
        final result = await isolateManager.compute(
          jsonEncode(BackgroundPatternInput(
            width: 400.0,
            height: 300.0,
            darkColorValue: 0xFF000000,
            lightColorValue: 0xFF242424,
            randomSeed: 123,
          ).toJson()),
          callback: (dynamic value) {
            final Map<String, dynamic> data = jsonDecode(value);
            
            if (data.containsKey('result')) {
              final result = BackgroundPatternOutput.fromJson(data['result']);
              expect(result.gridWidth, greaterThan(0));
              expect(result.gridHeight, greaterThan(0));
              expect(result.gridFill, isNotEmpty);
              expect(result.isComplete, isTrue);
              return true; // This is the final result
            }
            
            return false; // Not the final result
          },
        );
        
        expect(result, isNotNull);
      } finally {
        await isolateManager.stop();
      }
    });

    test('should handle different input sizes', () async {
      final isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
        backgroundPatternWorker,
        workerName: 'backgroundPatternWorker',
        concurrent: 1,
      );

      try {
        final sizes = [
          (100.0, 100.0),
          (200.0, 150.0),
          (400.0, 300.0),
          (800.0, 600.0),
        ];

        for (final (width, height) in sizes) {
          final result = await isolateManager.compute(
            jsonEncode(BackgroundPatternInput(
              width: width,
              height: height,
              darkColorValue: 0xFF000000,
              lightColorValue: 0xFF242424,
              randomSeed: 456,
            ).toJson()),
            callback: (dynamic value) {
              final Map<String, dynamic> data = jsonDecode(value);
              
              if (data.containsKey('result')) {
                final result = BackgroundPatternOutput.fromJson(data['result']);
                expect(result.gridWidth, greaterThan(0));
                expect(result.gridHeight, greaterThan(0));
                expect(result.gridFill, isNotEmpty);
                expect(result.isComplete, isTrue);
                return true;
              }
              
              return false;
            },
          );
          
          expect(result, isNotNull);
        }
      } finally {
        await isolateManager.stop();
      }
    });
  });
}
