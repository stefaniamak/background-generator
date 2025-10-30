import 'package:flutter/material.dart';
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

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          bottomNavigationBar: const AppFooterBar(),
          extendBody: true,
          body: Stack(
            children: [
              const GridBackground(),
              
              // Edit button - always visible
              Positioned(
                top: 16,
                right: 16,
                child: SafeArea(
                  child: FloatingActionButton(
                    heroTag: "edit_button",
                    onPressed: _toggleSidebar,
                    backgroundColor: Colors.white,
                    child: Icon(
                      _isSidebarVisible ? Icons.close : Icons.edit,
                      color: Colors.black,
                      size: 26,
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
                      return FloatingActionButton(
                        heroTag: "refresh_button",
                        onPressed: state.isRefreshing ? null : () {
                          final screenSize = MediaQuery.of(context).size;
                          context.read<BackgroundBloc>().add(RegeneratePattern(
                            width: screenSize.width,
                            height: screenSize.height,
                          ));
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
                          : const Icon(Icons.refresh, color: Colors.black, size: 26),
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
          bottom: 16 + 60, // Above bottom nav bar (60px estimated height) + 16px padding
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