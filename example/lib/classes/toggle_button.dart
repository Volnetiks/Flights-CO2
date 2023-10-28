import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key, required this.selectedItems, required this.widgets});

  final List<bool> selectedItems;
  final List<Widget> widgets;

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

                setState(() {
                  widget.flightDetailsBlock.updateWith(flightType: index == 0 ? FlightType.oneWay : FlightType.twoWays);
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
              isSelected: selectedFlightType,
              children: flightTypes
            );
  }
}