import 'package:flutter/material.dart';
import 'inline_color_picker.dart';

class ExpandableColorPicker extends StatelessWidget {
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
          color: isExpanded ? Colors.white54 : Colors.white24,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header row
          InkWell(
            onTap: onToggle,
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
                      color: color,
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
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getColorHex(color),
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
                    isExpanded ? Icons.keyboard_arrow_up : Icons.edit,
                    color: Colors.white54, 
                  ),
                ],
              ),
            ),
          ),
          
          // Expandable content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isExpanded ? 300 : 0,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: InlineColorPicker(
                      color: color,
                      onColorChanged: onColorChanged,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
