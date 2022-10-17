import 'package:flutter/material.dart';
import '../widgets/custom_card.dart';

class ValuesCards extends StatefulWidget {
  final String temperature;
  final String lpg;
  final String smoke;
  final String placename;
  final String networkError;
  const ValuesCards({
    Key? key,
    required this.temperature,
    required this.lpg,
    required this.smoke,
    required this.placename,
    required this.networkError,
  }) : super(key: key);

  @override
  State<ValuesCards> createState() => _ValuesCardsState();
}

class _ValuesCardsState extends State<ValuesCards> {
  var display = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        widget.networkError == "true"
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 10),
                child: Container(
                  width: 280,
                  height: 25,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8D7DA),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Network Error, try refreshing!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(top: 50, left: 10),
                child: Text(
                  'Real-time Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomCard(
            title: "TEMPERATURE",
            icon: Icons.thermostat_rounded,
            value: widget.temperature,
            unit: "°C",
            placename: widget.placename,
          ),
        ),
        // temperature card
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomCard(
            title: "LPG",
            icon: Icons.gas_meter_rounded,
            value: widget.lpg,
            unit: "%",
            placename: widget.placename,
          ),
        ),
        // lpg card
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomCard(
            title: "SMOKE",
            icon: Icons.air_rounded,
            value: widget.smoke,
            unit: "%",
            placename: widget.placename,
          ),
        ),
        // smoke card
      ],
    );
  }
}
