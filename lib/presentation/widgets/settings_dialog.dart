import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../../logic/bloc/background_state.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  void _showColorPicker({
    required BuildContext context,
    required Color currentColor,
    required Function(Color) onColorChanged,
    required String title,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        Color pickerColor = currentColor;
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BackgroundBloc, BackgroundState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: const Color(0xFF1A1A1A),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
              minWidth: 400,
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Dark Color Picker
                _buildColorRow(
                  context: context,
                  label: 'Background Color',
                  color: state.config.darkColor,
                  onTap: () {
                    _showColorPicker(
                      context: context,
                      currentColor: state.config.darkColor,
                      onColorChanged: (color) {
                        context.read<BackgroundBloc>().add(
                          UpdateColors(
                            darkColor: color,
                            lightColor: state.config.lightColor,
                          ),
                        );
                      },
                      title: 'Select Background Color',
                    );
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Light Color Picker
                _buildColorRow(
                  context: context,
                  label: 'Pattern Color',
                  color: state.config.lightColor,
                  onTap: () {
                    _showColorPicker(
                      context: context,
                      currentColor: state.config.lightColor,
                      onColorChanged: (color) {
                        context.read<BackgroundBloc>().add(
                          UpdateColors(
                            darkColor: state.config.darkColor,
                            lightColor: color,
                          ),
                        );
                      },
                      title: 'Select Pattern Color',
                    );
                  },
                ),
                
                const SizedBox(height: 24),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),
                
                // Reset to Stef's Preferences Button
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<BackgroundBloc>().add(ResetToDefaults());
                  },
                  icon: const Icon(Icons.restore),
                  label: const Text("Reset to Stef's Preferences"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }

  Widget _buildColorRow({
    required BuildContext context,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.edit, color: Colors.white54, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

