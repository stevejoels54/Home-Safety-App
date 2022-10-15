import 'package:flutter/material.dart';
import '../presentation/graph_screen.dart';

class BottomAppbar extends StatelessWidget {
  final String locationID;
  const BottomAppbar({
    Key? key,
    required this.locationID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //color: const Color(0xFF000080),
      color: Colors.black,
      elevation: 5,
      //notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white, size: 36),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GraphScreen(
                                locationID: locationID,
                                title: "TEMPERATURE (°C)",
                                value: "temperature",
                              )),
                    );
                  },
                  icon: const Icon(Icons.thermostat_rounded)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GraphScreen(
                                locationID: locationID,
                                title: "LPG (ppm)",
                                value: "lpg",
                              )),
                    );
                  },
                  icon: const Icon(Icons.gas_meter_rounded)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GraphScreen(
                                locationID: locationID,
                                title: "SMOKE (ppm)",
                                value: "smoke",
                              )),
                    );
                  },
                  icon: const Icon(Icons.air_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}
