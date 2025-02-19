import 'package:flutter/material.dart';

import '../style/dimensions.dart';

class CustomDropdown<T extends Enum> extends StatefulWidget {
  final Map<T, Map<String, dynamic>> values;
  final T initialValue;
  final TextEditingController controller;
  final Function(T) onChanged;

  const CustomDropdown({
    super.key,
    required this.values,
    required this.initialValue,
    required this.controller,
    required this.onChanged,
  });

  @override
  CustomDropdownState<T> createState() => CustomDropdownState<T>();
}

class CustomDropdownState<T extends Enum> extends State<CustomDropdown<T>> {
  late T selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
    widget.controller.text = _extractValue(selectedValue);
  }

  String _extractLabel(T value) {
    return widget.values[value]?["label"] ?? value.name;
  }

  String _extractValue(T value) {
    return widget.values[value]?["value"] ?? value.name;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final kSurface = colorScheme.surface;
    final kOutline = colorScheme.outline;
    final kOnSurface = colorScheme.onSurface;
    final kOnSurfaceVariant = colorScheme.onSurfaceVariant;

    final kLayoutRadius = Dimensions.radius.small;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: kSurface,
        borderRadius: BorderRadius.circular(kLayoutRadius),
        border: Border.all(
          color: kOutline,
          width: 1.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: kOnSurfaceVariant),
          isExpanded: true,
          style: TextStyle(color: kOnSurface),
          dropdownColor: kSurface,
          items: widget.values.keys.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                _extractLabel(value),
                style: TextStyle(color: kOnSurface),
              ),
            );
          }).toList(),
          onChanged: (T? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
                widget.controller.text = _extractValue(newValue);
              });
              widget.onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
