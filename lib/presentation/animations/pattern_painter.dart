import 'base_painter.dart';
import 'painter_constants.dart';

/// Handles pattern rules like checkerboard, isolation, and gap filling
class PatternPainter extends BasePainter {
  PatternPainter({required super.config});

  /// Enforce isolation rule to remove adjacent outside particles
  void enforceIsolationRule(List<List<double>> gridFill, int gridWidth, int gridHeight) {
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
  void fillGapsBetweenParticles(List<List<double>> gridFill, int gridWidth, int gridHeight) {
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
          for (int dx = 1; dx <= PainterConstants.gapCheckDistance; dx++) { // Check up to gap check distance cells away
            if (gx - dx >= 0) {
              if (gridFill[gx - dx][gy] >= 0.99) {
                has100PercentLeft = true;
                gapSizeHorizontal = dx - 1; // Gap size is the distance minus 1
                break;
              }
            } else {
              break;
            }
          }

          // Look right
          for (int dx = 1; dx <= PainterConstants.gapCheckDistance; dx++) { // Check up to gap check distance cells away
            if (gx + dx < gridWidth) {
              if (gridFill[gx + dx][gy] >= 0.99) {
                has100PercentRight = true;
                gapSizeHorizontal += dx - 1; // Add to gap size
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
          for (int dy = 1; dy <= PainterConstants.gapCheckDistance; dy++) { // Check up to gap check distance cells away
            if (gy - dy >= 0) {
              if (gridFill[gx][gy - dy] >= 0.99) {
                has100PercentUp = true;
                gapSizeVertical = dy - 1; // Gap size is the distance minus 1
                break;
              }
            } else {
              break;
            }
          }

          // Look down
          for (int dy = 1; dy <= PainterConstants.gapCheckDistance; dy++) { // Check up to gap check distance cells away
            if (gy + dy < gridHeight) {
              if (gridFill[gx][gy + dy] >= 0.99) {
                has100PercentDown = true;
                gapSizeVertical += dy - 1; // Add to gap size
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
  void convertAdjacentOutsideTo100Percent(List<List<double>> gridFill, int gridWidth, int gridHeight) {
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
}
