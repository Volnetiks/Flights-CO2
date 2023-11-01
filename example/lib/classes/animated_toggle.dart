import 'package:flutter/material.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final int index;

  const AnimatedToggle({
    super.key, 
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = Colors.white,
    this.buttonColor = Colors.black,
    this.textColor = Colors.black,
    this.index = 0
  });

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    initialPosition = index == 1 ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: SizedBox(
        width: 280,
        height: 250 * 0.13,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                initialPosition = !initialPosition;
                var index = 0;
                if (!initialPosition) {
                  index = 1;
                }
                widget.onToggleCallback(index);
                setState(() {});
              },
              child: Container(
                height: 250 * 0.13,
                decoration: ShapeDecoration(
                  color: widget.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    widget.values.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 250 * 0.05),
                      child: Text(
                        widget.values[index],
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              alignment:
                  initialPosition ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 280 * 0.5,
                height: 250 * 0.13,
                decoration: ShapeDecoration(
                  color: widget.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  initialPosition ? widget.values[0] : widget.values[1],
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}