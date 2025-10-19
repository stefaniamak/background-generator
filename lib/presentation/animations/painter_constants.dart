/// Core constants for all painters
class PainterConstants {
  // Grid and Cell Configuration
  static const double cellSize = 5.0;
  static const double ovalFactor = 0.7; // Make particles 70% as wide as they are tall
  
  // Particle Generation
  static const int minGroups = 6;
  static const int maxGroups = 9;
  static const double groupColumnsReduction = 0.25; // 75% fewer columns for vertical distribution
  
  static const int minParticlesPerGroup = 8;
  static const int maxParticlesPerGroup = 28;
  
  static const int minParticleRadius = 4;
  static const int maxParticleRadius = 9;
  
  // Distance and Spread Configuration
  static const double minDistancePercentage = 0.05; // 5% of screen diagonal
  static const double maxDistancePercentage = 0.20; // 20% of screen diagonal
  static const double horizontalSpreadBase = 0.06; // Base horizontal spread
  static const double horizontalVariationFactor = 0.05; // Horizontal variation factor
  
  // Particle Expansion
  static const double expansionRadiusMultiplier = 2.5; // 150% expansion
  static const double expansionDistanceMax = 2.5; // Maximum expansion distance
  static const double expansionGradientMax = 1.5; // Maximum expansion gradient
  
  // Fill Percentages
  static const double baseFillPercentage = 0.9; // Base fill for expansion areas
  static const double minFillPercentage = 0.2; // Minimum fill for expansion areas
  static const double fillGradientRange = 0.7; // Fill gradient range (0.9 - 0.2)
  
  // Distance-Based Sizing
  static const double veryCloseFill = 0.95; // 95% size - very close to 100% particle
  static const double closeFill = 0.8; // 80% size - close to 100% particle
  static const double mediumFill = 0.6; // 60% size - medium distance
  static const double farFill = 0.3; // 30% size - far distance
  static const double veryFarFill = 0.4; // 40% size - very far distance
  static const double extremelyFarFill = 0.25; // 25% size - extremely far distance
  
  // Distance Thresholds for Sizing
  static const double veryCloseDistance = 1.0;
  static const double closeDistance = 2.0;
  static const double mediumDistance = 3.0;
  static const double farDistance = 4.0;
  static const double veryFarDistance = 6.0;
  
  // Bridge Configuration
  static const double bridgeThresholdMultiplier = 1.8; // 1.8x combined radius
  static const double bridgeVerticalBias = 2.0; // Vertical connection bias
  static const double bridgeCurveOffset = 1.2; // Curve offset for smooth bridges
  static const double bridgeStepsMultiplier = 4.0; // Steps multiplier for smoothness
  static const double bridgeWidthMultiplier = 1.2; // Bridge width multiplier
  static const double bridgeExtendedRadiusMultiplier = 1.5; // Extended radius for 100% fill
  
  // Bridge Fill Configuration
  static const double bridgeProximityFill = 1.0; // 100% fill near particles
  static const double bridgeMinFill = 0.2; // Minimum bridge fill
  static const double bridgeMaxFill = 0.9; // Maximum bridge fill
  static const double bridgeFillRange = 0.7; // Bridge fill range
  
  // Diagonal Bridge Configuration
  static const double diagonalBridgeThreshold = 5.0; // Grid cells for diagonal bridges
  static const double diagonalBridgeStepsMultiplier = 2.0; // Steps for diagonal bridges
  static const double diagonalBridgeFillReduction = 0.9; // 90% of average fill
  
  // Pattern Rules
  static const int gapCheckDistance = 4; // Check up to 4 cells for gaps
  static const int maxGapSize = 2; // Maximum gap size to fill
  
  // Rendering Configuration
  static const double organicVariationChance = 0.5; // 50% chance for organic variation
  static const double organicVariationMin = 0.1; // Minimum reduction factor
  static const double organicVariationMax = 0.5; // Maximum reduction factor
  static const double organicVariationThreshold = 0.05; // Threshold for organic variation
  
  // Color Configuration (from BackgroundConfig)
  static const int darkColorValue = 0xFF000000; // Black background
  static const int lightColorValue = 0xFF282828; // Very dark grey pattern
  static const int defaultRandomSeed = 42; // Fixed seed for consistent pattern
}
