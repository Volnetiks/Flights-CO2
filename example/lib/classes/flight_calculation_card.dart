import 'package:flights_co2_example/classes/flight_calculation_data_item.dart';
import 'package:flights_co2_example/classes/flight_data.dart';
import 'package:flutter/material.dart';

class FlightCalculationCard extends StatelessWidget {
  const FlightCalculationCard({super.key, required this.flightData});

  final FlightData flightData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        color: Color(0x4089ED91),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: FlightCalculationDataItem(
                title: "Distance",
                body: flightData.distanceFormatted
              ),
            ),
            Expanded(
              child: FlightCalculationDataItem(
                title: "Estimated CO2e",
                body: flightData.co2eFormmated
              )
            )
          ],
        )
      ),
    );
  }
}