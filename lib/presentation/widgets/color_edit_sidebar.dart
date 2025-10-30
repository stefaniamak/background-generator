import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
            final screenWidth = MediaQuery.of(context).size.width;
            final buttonWidth = 56.0; // Button width
            final buttonPadding = 16.0; // Button right padding
            final sidebarLeftPadding = 16.0; // Sidebar left padding
            final extraPadding = 16.0; // Extra padding for spacing
            final maxAvailableWidth = screenWidth - sidebarLeftPadding - buttonWidth - buttonPadding - extraPadding;
            final sidebarWidth = min(max(screenWidth * 0.3, 350.0), maxAvailableWidth);
            
            return Container(
              width: sidebarWidth.toDouble(),
              decoration: BoxDecoration(
                color: baseColor.withValues(alpha: 0.5),
                border: const Border(
                  right: BorderSide(color: Colors.white24, width: 1),
                ),
              ),
              clipBehavior: Clip.hardEdge,
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
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Edit',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Colors subtitle
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          'Colors',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
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
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            context.read<BackgroundBloc>().add(ResetToDefaults());
                            setState(() {
                              _isDarkColorExpanded = false;
                              _isLightColorExpanded = false;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  "↺ ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Reset to Defaults",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                              ),
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
