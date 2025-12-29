import 'package:flutter/material.dart';

class CustomColorPicker extends StatefulWidget {
  const CustomColorPicker({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.selectedColor,
    required this.onColorChanged,
    this.textStyle,
    this.fillColor,
    this.foregroundColor,
  });

  final double width;
  final double height;
  final String label;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;
  final TextStyle? textStyle;
  final Color? fillColor;
  final Color? foregroundColor;

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  bool _isFocused = false;

  void _showColorPicker() {
    setState(() => _isFocused = true);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.label),
        content: SingleChildScrollView(
          child: ColorPickerGrid(
            selectedColor: widget.selectedColor,
            onColorSelected: (color) {
              widget.onColorChanged(color);
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    ).then((_) => setState(() => _isFocused = false));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        onTap: _showColorPicker,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: widget.fillColor ?? theme.colorScheme.primary.withAlpha(50),
            borderRadius: BorderRadius.circular(12),
            border: _isFocused
                ? Border.all(color: theme.colorScheme.primary, width: 2)
                : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style:
                          widget.textStyle ??
                          theme.textTheme.bodySmall?.copyWith(
                            color:
                                widget.foregroundColor ??
                                theme.textTheme.bodySmall?.color?.withAlpha(
                                  150,
                                ),
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _colorToHex(widget.selectedColor),
                      style:
                          widget.textStyle ??
                          theme.textTheme.bodyLarge?.copyWith(
                            color:
                                widget.foregroundColor ??
                                theme.textTheme.bodyLarge?.color,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: widget.selectedColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

class ColorPickerGrid extends StatelessWidget {
  const ColorPickerGrid({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  static final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _colors.map((color) {
          final isSelected = color.value == selectedColor.value;
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.black26,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withAlpha(150),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 30)
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
