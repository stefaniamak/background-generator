import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class InlineColorPicker extends StatefulWidget {
  final Color color;
  final Function(Color) onColorChanged;

  const InlineColorPicker({
    super.key,
    required this.color,
    required this.onColorChanged,
  });

  @override
  State<InlineColorPicker> createState() => _InlineColorPickerState();
}

class _InlineColorPickerState extends State<InlineColorPicker> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.color;
  }

  @override
  void didUpdateWidget(InlineColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color) {
      _currentColor = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Color picker with sliders and hex input (like original popup)
        ColorPicker(
          pickerColor: _currentColor,
          onColorChanged: (Color color) {
            setState(() {
              _currentColor = color;
            });
            widget.onColorChanged(color);
          },
          pickerAreaHeightPercent: 0.8,
          enableAlpha: false,
          displayThumbColor: true,
          paletteType: PaletteType.hsv,
          labelTypes: const [],
          pickerAreaBorderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }
}
