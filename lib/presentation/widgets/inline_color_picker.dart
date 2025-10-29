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
  @override
  Widget build(BuildContext context) {
    return ColorPicker(
      pickerColor: widget.color,
      onColorChanged: widget.onColorChanged,
      pickerAreaHeightPercent: 0.8,
      enableAlpha: false,
      displayThumbColor: true,
      paletteType: PaletteType.hsv,
      labelTypes: const [],
      pickerAreaBorderRadius: BorderRadius.circular(8),
      portraitOnly: true,
    );
  }
}
