/// Application constants for background pattern generation
class AppConstants {
  // Isolate Configuration
  static const String isolateWorkerName = 'backgroundPatternWorker';
  static const int isolateConcurrency = 1;
  
  // Default Dimensions
  static const double defaultWidth = 800.0;
  static const double defaultHeight = 600.0;
  
  // Random Seed Configuration
  static const int randomSeedRange = 1000000;
  
  // Progress Tracking
  static const int progressStart = 10;
  static const int progressGridCalculated = 20;
  static const int progressGridInitialized = 30;
  static const int progressGeneratingGroups = 40;
  static const int progressFillingParticles = 50;
  static const int progressCreatingBridges = 60;
  static const int progressApplyingIsolation = 70;
  static const int progressFillingGaps = 75;
  static const int progressConvertingAdjacent = 80;
  static const int progressUpgradingSurrounded = 85;
  static const int progressCreatingDiagonal = 90;
  static const int progressApplyingSizing = 95;
  
  // Progress Messages
  static const String messageStartingGeneration = 'Starting pattern generation...';
  static const String messageGridDimensionsCalculated = 'Grid dimensions calculated';
  static const String messageGridInitialized = 'Grid initialized, generating particle groups...';
  static const String messageGeneratingGroups = 'Generating particle groups...';
  static const String messageFillingParticles = 'Filling particles in grid...';
  static const String messageCreatingBridges = 'Creating liquid bridges...';
  static const String messageApplyingIsolation = 'Applying isolation rules...';
  static const String messageFillingGaps = 'Filling gaps between particles...';
  static const String messageConvertingAdjacent = 'Converting adjacent particles...';
  static const String messageUpgradingSurrounded = 'Upgrading surrounded particles...';
  static const String messageCreatingDiagonal = 'Creating diagonal bridges...';
  static const String messageApplyingSizing = 'Applying distance-based sizing...';
  static const String successPatternComplete = 'Pattern generation complete!';
  
  // Error Messages
  static const String errorGeneratingPattern = 'Error generating pattern: ';
  
  // Test Configuration
  static const double testWidth = 400.0;
  static const double testHeight = 300.0;
  static const int testDarkColorValue = 0xFF000000;
  static const int testLightColorValue = 0xFF242424;
  static const int testRandomSeed1 = 123;
  static const int testRandomSeed2 = 456;
  
  // Test Expectations
  static const int expectedMinGridWidth = 0;
  static const int expectedMinGridHeight = 0;
  static const int expectedFloatingActionButtonCount = 2;
  static const Duration testPumpDuration = Duration(milliseconds: 100);
  
  // Test Sizes
  static const List<(double, double)> testSizes = [
    (100.0, 100.0),
    (200.0, 150.0),
    (400.0, 300.0),
    (800.0, 600.0),
  ];
  
  // Pattern Generation Constants
  static const int maxIterations = 10;
  static const int minRadius = 2;
  static const int maxRadius = 100;
}
