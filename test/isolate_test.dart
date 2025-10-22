import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:isolate_manager/isolate_manager.dart';
import '../lib/logic/isolate/background_pattern_isolate.dart';
import '../lib/utils/app_constants.dart';

void main() {
  group('Background Pattern Isolate Tests', () {
    test('should generate pattern successfully', () async {
      final isolateManager = IsolateManager<dynamic, dynamic>.createCustom(
        backgroundPatternWorker,
        workerName: AppConstants.isolateWorkerName,
        concurrent: AppConstants.isolateConcurrency,
      );

      try {
          final result = await isolateManager.compute(
            jsonEncode(BackgroundPatternInput(
              width: AppConstants.testWidth,
              height: AppConstants.testHeight,
              darkColorValue: AppConstants.testDarkColorValue,
              lightColorValue: AppConstants.testLightColorValue,
              randomSeed: AppConstants.testRandomSeed1,
            ).toJson()),
          callback: (dynamic value) {
            final Map<String, dynamic> data = jsonDecode(value);
            
              if (data.containsKey('result')) {
                final result = BackgroundPatternOutput.fromJson(data['result']);
                expect(result.gridWidth, greaterThan(AppConstants.expectedMinGridWidth));
                expect(result.gridHeight, greaterThan(AppConstants.expectedMinGridHeight));
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
        workerName: AppConstants.isolateWorkerName,
        concurrent: AppConstants.isolateConcurrency,
      );

      try {
        final sizes = AppConstants.testSizes;

        for (final (width, height) in sizes) {
          final result = await isolateManager.compute(
            jsonEncode(BackgroundPatternInput(
              width: width,
              height: height,
              darkColorValue: AppConstants.testDarkColorValue,
              lightColorValue: AppConstants.testLightColorValue,
              randomSeed: AppConstants.testRandomSeed2,
            ).toJson()),
            callback: (dynamic value) {
              final Map<String, dynamic> data = jsonDecode(value);
              
              if (data.containsKey('result')) {
                final result = BackgroundPatternOutput.fromJson(data['result']);
                expect(result.gridWidth, greaterThan(AppConstants.expectedMinGridWidth));
                expect(result.gridHeight, greaterThan(AppConstants.expectedMinGridHeight));
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
