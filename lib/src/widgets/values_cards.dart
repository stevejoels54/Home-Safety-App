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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.networkError == "true"
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 10),
                child: Container(
                  width: 280,
                  height: 30,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8D7DA),
                      borderRadius: BorderRadius.circular(20)),
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
          padding:
              const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return CustomCard(
                title: index == 0
                    ? "TEMPERATURE"
                    : index == 1
                        ? "LPG"
                        : "SMOKE",
                icon: index == 0
                    ? Icons.thermostat_rounded
                    : index == 1
                        ? Icons.gas_meter_rounded
                        : Icons.air_rounded,
                value: index == 0
                    ? widget.temperature
                    : index == 1
                        ? widget.lpg
                        : widget.smoke,
                unit: index == 0
                    ? "°C"
                    : index == 1
                        ? "%"
                        : "%",
                placename: widget.placename,
              );
            },
          ),
        ),
        // smoke card
      ],
    );
  }
}
