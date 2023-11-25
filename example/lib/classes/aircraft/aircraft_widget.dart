import 'package:flights_co2/aircraft.dart';
import 'package:flutter/material.dart';

class AircraftWidget extends StatelessWidget {
  const AircraftWidget({super.key, required this.iconData, required this.title, this.aircraft, required this.onPressed});

  final IconData iconData;
  final Text title;
  final Aircraft? aircraft;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData),
            const SizedBox(width: 16.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(height: 4.0),
                  Text(
                    aircraft == null ? "Select..." : aircraft!.name,
                    style: const TextStyle(fontSize: 16.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Divider(height: 1.0, color: Colors.black87)
                ],
              )
            )
          ],
        )
      ),
    );
  }
}