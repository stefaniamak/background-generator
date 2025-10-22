import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/bloc/background_bloc.dart';
import '../../logic/bloc/background_event.dart';
import '../../logic/bloc/background_state.dart';
import '../widgets/grid_background.dart';
import '../widgets/color_edit_sidebar.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool _isSidebarVisible = true;

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  void _hideSidebar() {
    if (_isSidebarVisible) {
      setState(() {
        _isSidebarVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content area with background
          const GridBackground(),
          
          // Back button - always visible and clickable
          Positioned(
            top: 16,
            left: 16,
            child: SafeArea(
              child: FloatingActionButton(
                heroTag: "edit_back_button",
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Colors.white,
                mini: true,
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
          ),
          
          // Refresh button - always visible
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 16,
            right: _isSidebarVisible ? 430 : 16, // Move right when sidebar is visible
            child: SafeArea(
              child: BlocBuilder<BackgroundBloc, BackgroundState>(
                buildWhen: (previous, current) => previous.isRefreshing != current.isRefreshing,
                builder: (context, state) {
                  return FloatingActionButton(
                    heroTag: "edit_refresh_button",
                    onPressed: state.isRefreshing ? null : () {
                      final screenSize = MediaQuery.of(context).size;
                      context.read<BackgroundBloc>().add(RegeneratePattern(
                        width: screenSize.width,
                        height: screenSize.height,
                      ));
                    },
                    backgroundColor: state.isRefreshing ? Colors.grey : Colors.white,
                    mini: true,
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
            ),
          ),
          
          // Toggle sidebar button - always visible
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 16,
            right: _isSidebarVisible ? 480 : 80, // Move right when sidebar is visible
            child: SafeArea(
              child: FloatingActionButton(
                heroTag: "toggle_sidebar_button",
                onPressed: _toggleSidebar,
                backgroundColor: Colors.white,
                mini: true,
                child: Icon(
                  _isSidebarVisible ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          // Sidebar with animation - positioned as overlay
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _isSidebarVisible ? 350 : 0,
              child: _isSidebarVisible
                  ? const ColorEditSidebar()
                  : const SizedBox.shrink(),
            ),
          ),
          
          // Tap detector for hiding sidebar - only when sidebar is visible
          if (_isSidebarVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 350, // Cover area not covered by sidebar
              bottom: 0,
              child: GestureDetector(
                onTap: _hideSidebar,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
