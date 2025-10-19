/// Core constants for all painters
class PainterConstants {
  // Grid and Cell Configuration
  static const double cellSize = 4.0;
  static const double ovalFactor = 0.7; // Make particles 70% as wide as they are tall
  
  // Particle Generation
  static const int minGroups = 12;
  static const int maxGroups = 18;
  static const double groupColumnsReduction = 0.15; // Even fewer columns for more vertical spread
  
  static const int minParticlesPerGroup = 4;
  static const int maxParticlesPerGroup = 10;
  
  static const int minParticleRadius = 5; // Increased from 4
  static const int maxParticleRadius = 12; // Increased from 9
  
  // Distance and Spread Configuration - More compact and vertical
  static const double minDistancePercentage = 0.03; // Reduced from 0.05 - closer particles
  static const double maxDistancePercentage = 0.12; // Reduced from 0.20 - more compact groups
  static const double horizontalSpreadBase = 0.03; // Reduced from 0.06 - less horizontal spread
  static const double horizontalVariationFactor = 0.02; // Reduced from 0.05 - more vertical
  
  // Particle Expansion - Reduced outside radius
  static const double expansionRadiusMultiplier = 1.9; // Reduced from 2.2 - smaller outside radius
  static const double expansionDistanceMax = 1.9; // Reduced from 2.2 - shorter expansion
  static const double expansionGradientMax = 1.4; // Reduced from 1.6 - less gradient
  
  // Fill Percentages - Increased for larger particles
  static const double baseFillPercentage = 0.85; // Increased from 0.7 - more solid fill
  static const double minFillPercentage = 0.25; // Increased from 0.15 - larger minimum
  static const double fillGradientRange = 0.6; // Increased from 0.55 - larger range
  
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
  
  // Bridge Configuration - Selective connectivity
  static const double bridgeThresholdMultiplier = 2.1; // Increased - more selective bridging
  static const double bridgeVerticalBias = 2.8; // Increased - stronger vertical preference
  static const double bridgeCurveOffset = 1.4; // Increased - more curved connections
  static const double bridgeStepsMultiplier = 4.0; // Increased - smoother connections
  static const double bridgeWidthMultiplier = 1.4; // Increased - wider bridges when they connect
  static const double bridgeExtendedRadiusMultiplier = 1.6; // Increased - stronger connections
  
  // Bridge Fill Configuration - Varied connectivity
  static const double bridgeProximityFill = 0.95; // Very solid when close
  static const double bridgeMinFill = 0.15; // Lower minimum for weak connections
  static const double bridgeMaxFill = 0.85; // Higher maximum for strong connections
  static const double bridgeFillRange = 0.7; // Larger range for more variation
  
  // Bridge Randomness - For selective connectivity
  static const double bridgeRandomnessFactor = 0.3; // 30% randomness in bridge creation
  static const double bridgeDistanceVariation = 0.2; // 20% variation in distance thresholds
  
  // Diagonal Bridge Configuration - More selective
  static const double diagonalBridgeThreshold = 8.0; // Increased - more selective diagonal bridging
  static const double diagonalBridgeStepsMultiplier = 2.0; // Increased - smoother when they connect
  static const double diagonalBridgeFillReduction = 0.6; // Reduced - weaker diagonal connections
  
  // Pattern Rules - Increased for more connections
  static const int gapCheckDistance = 4; // Increased from 3 - check more cells for gaps
  static const int maxGapSize = 2; // Increased from 1 - fill larger gaps
  
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
