import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;
  const CustomCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.value,
      required this.unit,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        height: 200,
        width: 300,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              //leading: Icon(Icons.thermostat_rounded),
              leading: Icon(icon),
              title: Text(title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            CircularPercentIndicator(
              radius: 70,
              lineWidth: 15,
              percent: (double.parse(value) / 100),
              center: Text("${double.parse(value).toStringAsFixed(1)}" "$unit",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              progressColor: color,
            )
          ],
        ),
      ),
    );
  }
}
