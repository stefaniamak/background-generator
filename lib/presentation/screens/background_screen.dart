import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../../logic/bloc/background_state.dart';
import '../widgets/grid_background.dart';
import '../widgets/settings_dialog.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const GridBackground(),
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SettingsDialog(),
                  );
                },
                backgroundColor: Colors.white,
                mini: true,
                child: const Icon(Icons.settings, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<BackgroundBloc, BackgroundState>(
        buildWhen: (previous, current) => previous.isRefreshing != current.isRefreshing,
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: state.isRefreshing ? null : () {
              context.read<BackgroundBloc>().add(RegeneratePattern());
            },
            backgroundColor: state.isRefreshing ? Colors.grey : Colors.white,
            child: state.isRefreshing 
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : const Icon(Icons.refresh, color: Colors.black),
          );
        },
      ),
    );
  }
}