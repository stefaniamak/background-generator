import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_state.dart';
import '../animations/grid_painter.dart';

class GridBackground extends StatelessWidget {
  const GridBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundBloc, BackgroundState>(
      builder: (context, state) {
        return CustomPaint(
          painter: GridPainter(config: state.config),
          size: Size.infinite,
          child: Container(),
        );
      },
    );
  }
}
