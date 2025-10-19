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
      buildWhen: (previous, current) {
        print('GridBackground buildWhen called: ${previous.config.randomSeed} -> ${current.config.randomSeed}');
        return previous.config != current.config;
      },
      builder: (context, state) {
        print('GridBackground builder called with seed: ${state.config.randomSeed}');
        return SizedBox.expand(
          child: CustomPaint(
            painter: MainGridPainter(config: state.config),
          ),
        );
      },
    );
  }
}
