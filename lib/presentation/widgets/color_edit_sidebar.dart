import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../../logic/bloc/background_state.dart';
import 'expandable_color_picker.dart';

class ColorEditSidebar extends StatefulWidget {
  const ColorEditSidebar({super.key});

  @override
  State<ColorEditSidebar> createState() => _ColorEditSidebarState();
}

class _ColorEditSidebarState extends State<ColorEditSidebar> {
  bool _isDarkColorExpanded = false;
  bool _isLightColorExpanded = false;

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 12;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: BlocBuilder<BackgroundBloc, BackgroundState>(
          builder: (context, state) {
            final baseColor = Colors.black;
            return Container(
              width: max(MediaQuery.of(context).size.width * 0.3, 350),
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: 0.5),
                border: const Border(
                  right: BorderSide(color: Colors.white24, width: 1),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  // Prevent clicks inside sidebar from closing it
                },
                child: Column(
            children: [
              // Header with SafeArea to avoid status bar overlap
              SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white24, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.palette, color: Colors.white, size: 24),
                      const SizedBox(width: 12),
                      const Text(
                        'Color Editor',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Color pickers
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Dark Color Picker
                      ExpandableColorPicker(
                        title: 'Background Color',
                        color: state.config.darkColor,
                        isExpanded: _isDarkColorExpanded,
                        onToggle: () {
                          setState(() {
                            _isDarkColorExpanded = !_isDarkColorExpanded;
                            if (_isDarkColorExpanded) {
                              _isLightColorExpanded = false;
                            }
                          });
                        },
                        onColorChanged: (color) {
                          context.read<BackgroundBloc>().add(
                            UpdateColors(
                              darkColor: color,
                              lightColor: state.config.lightColor,
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Light Color Picker
                      ExpandableColorPicker(
                        title: 'Pattern Color',
                        color: state.config.lightColor,
                        isExpanded: _isLightColorExpanded,
                        onToggle: () {
                          setState(() {
                            _isLightColorExpanded = !_isLightColorExpanded;
                            if (_isLightColorExpanded) {
                              _isDarkColorExpanded = false;
                            }
                          });
                        },
                        onColorChanged: (color) {
                          context.read<BackgroundBloc>().add(
                            UpdateColors(
                              darkColor: state.config.darkColor,
                              lightColor: color,
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 24),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 16),
                      
                      // Reset to Defaults Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<BackgroundBloc>().add(ResetToDefaults());
                            setState(() {
                              _isDarkColorExpanded = false;
                              _isLightColorExpanded = false;
                            });
                          },
                          icon: const Icon(Icons.restore),
                          label: const Text("Reset to Defaults"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
