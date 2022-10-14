import 'package:flutter/material.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      elevation: 6,
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white, size: 36),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.gas_meter_rounded)),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.thermostat_rounded)),
              const SizedBox(
                width: 10,
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.air_rounded)),
            ],
          ),
        ),
      ),
    );
  }
}