import 'package:flights_co2_example/utils/hex_color.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key, required this.selectedItems, required this.widgets, required this.onChange});

  final List<bool> selectedItems;
  final List<Widget> widgets;
  final Function(int index) onChange;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        for (int i = 0; i < widget.selectedItems.length; i++) {
          widget.selectedItems[i] = i == index;
        }

        widget.onChange(index);
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedColor: Colors.black,
      fillColor: HexColor.fromHex("#f2e98e"),
      color: Colors.black,
      
      constraints: const BoxConstraints(
        minHeight: 40,
        minWidth: 80,
      ),
      isSelected: widget.selectedItems,
      children: widget.widgets,
    );
  }
}