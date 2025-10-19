import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../widgets/grid_background.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const GridBackground(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Regenerate pattern with new random seed
          context.read<BackgroundBloc>().add(RegeneratePattern());
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}