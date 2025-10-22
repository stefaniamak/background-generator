import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_state.dart';
import '../animations/main_grid_painter.dart';

class GridBackground extends StatelessWidget {
  const GridBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundBloc, BackgroundState>(
      buildWhen: (previous, current) => 
        previous.config.darkColor != current.config.darkColor ||
        previous.config.lightColor != current.config.lightColor ||
        previous.patternData != current.patternData,
      builder: (context, state) {
        return SizedBox.expand(
          child: CustomPaint(
            painter: MainGridPainter(
              config: state.config,
              patternData: state.patternData,
            ),
          ),
        );
      },
    );
  }
}
