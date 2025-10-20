import 'dart:math';
import 'package:flutter/material.dart';
import 'base_painter.dart';
import 'painter_constants.dart';

/// Handles the final rendering of the grid to canvas
class RenderPainter extends BasePainter {
  RenderPainter({required super.config});

  /// Render the final grid to canvas with proper shapes and corner rounding
  void renderGridToCanvas(
    Canvas canvas,
    List<List<double>> gridFill,
    Size size,
    int gridWidth,
    int gridHeight,
  ) {
    final cellWidth = this.cellWidth;
    final cellHeight = this.cellHeight;
    final whitePaint = Paint()..color = config.lightColor;

    for (int gx = 0; gx < gridWidth; gx++) {
      for (int gy = 0; gy < gridHeight; gy++) {
        final fillPercentage = gridFill[gx][gy];

        if (fillPercentage > 0) {
          final x = gx * cellWidth;
          final y = gy * cellHeight;

          // Calculate the size of the shape based on percentage
          final shapeWidth = cellWidth * sqrt(fillPercentage);
          final shapeHeight = cellHeight * sqrt(fillPercentage);

          // Center the shape within the cell
          final shapeX = x + (cellWidth - shapeWidth) / 2;
          final shapeY = y + (cellHeight - shapeHeight) / 2;

          // Calculate corner radius based on fill percentage
          final radiusPercentage = 1.0 - fillPercentage;
          var cornerRadius = min(shapeWidth, shapeHeight) / 2 * radiusPercentage;

          // Special handling for 100% fill particles (normally square)
          RRect shapeRRect;

          if (fillPercentage >= 0.99) {
            // Check neighboring particles for context-aware corner rounding
            final left = gx > 0 ? gridFill[gx - 1][gy] : 0.0;
            final right = gx < gridWidth - 1 ? gridFill[gx + 1][gy] : 0.0;
            final top = gy > 0 ? gridFill[gx][gy - 1] : 0.0;
            final bottom = gy < gridHeight - 1 ? gridFill[gx][gy + 1] : 0.0;

            // Check diagonal neighbors
            final topLeft = (gx > 0 && gy > 0) ? gridFill[gx - 1][gy - 1] : 0.0;
            final topRight = (gx < gridWidth - 1 && gy > 0) ? gridFill[gx + 1][gy - 1] : 0.0;
            final bottomLeft = (gx > 0 && gy < gridHeight - 1) ? gridFill[gx - 1][gy + 1] : 0.0;
            final bottomRight = (gx < gridWidth - 1 && gy < gridHeight - 1) ? gridFill[gx + 1][gy + 1] : 0.0;

            // Check if neighbors are non-100%
            final hasLeftNon100 = left > 0 && left < 0.99;
            final hasRightNon100 = right > 0 && right < 0.99;
            final hasTopNon100 = top > 0 && top < 0.99;
            final hasBottomNon100 = bottom > 0 && bottom < 0.99;

            // Check if diagonals are 100%
            final hasTopLeft100 = topLeft >= 0.99;
            final hasTopRight100 = topRight >= 0.99;
            final hasBottomLeft100 = bottomLeft >= 0.99;
            final hasBottomRight100 = bottomRight >= 0.99;

            // Determine which corners should be rounded based on neighboring non-100% particles
            // A corner should ONLY be rounded if BOTH of its adjacent sides have non-100% particles

            // Top-left corner: BOTH top AND left must be non-100%
            final topLeftRadius = (hasTopNon100 && hasLeftNon100) && !hasTopLeft100
                ? Radius.circular(cornerRadius) : Radius.zero;

            // Top-right corner: BOTH top AND right must be non-100%
            final topRightRadius = (hasTopNon100 && hasRightNon100) && !hasTopRight100
                ? Radius.circular(cornerRadius) : Radius.zero;

            // Bottom-left corner: BOTH bottom AND left must be non-100%
            final bottomLeftRadius = (hasBottomNon100 && hasLeftNon100) && !hasBottomLeft100
                ? Radius.circular(cornerRadius) : Radius.zero;

            // Bottom-right corner: BOTH bottom AND right must be non-100%
            final bottomRightRadius = (hasBottomNon100 && hasRightNon100) && !hasBottomRight100
                ? Radius.circular(cornerRadius) : Radius.zero;

            shapeRRect = RRect.fromLTRBAndCorners(
              shapeX, shapeY, shapeX + shapeWidth, shapeY + shapeHeight,
              topLeft: topLeftRadius,
              topRight: topRightRadius,
              bottomLeft: bottomLeftRadius,
              bottomRight: bottomRightRadius,
            );
          } else {
            // Add organic variation for non-square shapes
            if (radiusPercentage > PainterConstants.organicVariationThreshold) {
              // Use deterministic randomness based on position
              final positionSeed = (gx * 1000 + gy).hashCode;
              final localRandom = Random(positionSeed);

              // Chance to reduce the corner radius
              if (localRandom.nextDouble() < PainterConstants.organicVariationChance) {
                // Reduce radius for more dramatic variation
                final reductionFactor = PainterConstants.organicVariationMin + localRandom.nextDouble() * (PainterConstants.organicVariationMax - PainterConstants.organicVariationMin);
                cornerRadius *= reductionFactor;
              }
            }

            shapeRRect = RRect.fromRectAndRadius(
              Rect.fromLTWH(shapeX, shapeY, shapeWidth, shapeHeight),
              Radius.circular(cornerRadius),
            );
          }

          canvas.drawRRect(shapeRRect, whitePaint);
        }
      }
    }
  }
}
