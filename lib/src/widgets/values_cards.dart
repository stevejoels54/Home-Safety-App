import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class ValuesCards extends StatefulWidget {
  final String temperature;
  final String lpg;
  final String smoke;
  final String placename;
  const ValuesCards({
    Key? key,
    required this.temperature,
    required this.lpg,
    required this.smoke,
    required this.placename,
  }) : super(key: key);

  @override
  State<ValuesCards> createState() => _ValuesCardsState();
}

class _ValuesCardsState extends State<ValuesCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: "TEMPERATURE",
          icon: Icons.thermostat_rounded,
          value: widget.temperature,
          unit: "°C",
          color: Colors.yellow,
          placename: widget.placename,
        ),
        // lpg card
        CustomCard(
          title: "LPG",
          icon: Icons.gas_meter_rounded,
          value: widget.lpg,
          unit: "%",
          color: Colors.orange,
          placename: widget.placename,
        ),
        // smoke card
        CustomCard(
          title: "SMOKE",
          icon: Icons.air_rounded,
          value: widget.smoke,
          unit: "%",
          color: Colors.green,
          placename: widget.placename,
        ),
      ],
    );
  }
}
