import 'package:auto_size_text/auto_size_text.dart';
import 'package:flights_co2/airport.dart';
import 'package:flutter/material.dart';

class AirportWidget extends StatelessWidget {
  const AirportWidget({super.key, required this.iconData, required this.title, this.airport, required this.onPressed});

  final IconData iconData;
  final Text title;
  final Airport? airport;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final airportDisplayName = airport != null ? '${airport!.name} (${airport!.iata})' : 'Select...';

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
                  AutoSizeText(
                    airportDisplayName,
                    style: const TextStyle(fontSize: 16.0),
                    minFontSize: 13.0,
                    maxLines: 2,
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