import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../../logic/bloc/background_state.dart';
import '../widgets/grid_background.dart';
import '../widgets/color_edit_sidebar.dart';
import '../widgets/app_footer_bar.dart';

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  bool _isSidebarVisible = false;
  final GlobalKey _footerKey = GlobalKey();
  double _footerHeight = 50; // Default fallback

  @override
  void initState() {
    super.initState();
    // Measure footer height after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureFooterHeight();
    });
  }

  void _measureFooterHeight() {
    final RenderBox? renderBox = _footerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      if (height != _footerHeight) {
        setState(() {
          _footerHeight = height;
        });
      }
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Measure footer height after each build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureFooterHeight();
    });
    
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: AppFooterBar(key: _footerKey),
          extendBody: true,
          body: Stack(
            children: [
              const GridBackground(),
              
              // Edit button - always visible
              Positioned(
                top: 16,
                right: 16,
                child: SafeArea(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _toggleSidebar,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _isSidebarVisible ? Icons.close : Icons.edit,
                            color: Colors.black,
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Refresh button - always visible
              Positioned(
                bottom: 16,
                right: 16,
                child: SafeArea(
                  child: BlocBuilder<BackgroundBloc, BackgroundState>(
                    buildWhen: (previous, current) => previous.isRefreshing != current.isRefreshing,
                    builder: (context, state) {
                      return CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: state.isRefreshing ? null : () {
                          final screenSize = MediaQuery.of(context).size;
                          context.read<BackgroundBloc>().add(RegeneratePattern(
                            width: screenSize.width,
                            height: screenSize.height,
                          ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: (state.isRefreshing ? Colors.grey : Colors.white).withValues(alpha: 0.75),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: state.isRefreshing 
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                    ),
                                  )
                                : const Icon(Icons.refresh, color: Colors.black, size: 26),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
            ],
          ),
        ),
        
        // Sidebar with fade animation - positioned as overlay above everything
        Positioned(
          top: 16 + MediaQuery.of(context).padding.top,
          left: 16, // Same padding as buttons (16px from right)
          bottom: 16 + _footerHeight, // Automatically detected footer height + 16px padding
          child: Material(
            color: Colors.transparent,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _isSidebarVisible
                  ? const ColorEditSidebar(key: ValueKey('sidebar'))
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ),
        ),
      ],
    );
  }
}