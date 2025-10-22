import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'inline_color_picker.dart';

class ExpandableColorPicker extends StatefulWidget {
  final String title;
  final Color color;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Function(Color) onColorChanged;

  const ExpandableColorPicker({
    super.key,
    required this.title,
    required this.color,
    required this.isExpanded,
    required this.onToggle,
    required this.onColorChanged,
  });

  @override
  State<ExpandableColorPicker> createState() => _ExpandableColorPickerState();
}

class _ExpandableColorPickerState extends State<ExpandableColorPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(ExpandableColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getColorHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isExpanded ? Colors.white54 : Colors.white24,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header row
          InkWell(
            onTap: widget.onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Color preview
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Title and hex code
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getColorHex(widget.color),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Edit icon
                  Icon(
                    widget.isExpanded ? Icons.keyboard_arrow_up : Icons.edit,
                    color: Colors.white54, 
                  ),
                ],
              ),
            ),
          ),
          
          // Expandable content
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: InlineColorPicker(
                color: widget.color,
                onColorChanged: widget.onColorChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
