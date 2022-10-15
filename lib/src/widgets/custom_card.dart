import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final String placename;
  const CustomCard(
      {Key? key,
      required this.icon,
      required this.title,
      required this.value,
      required this.unit,
      required this.placename})
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
      color: Colors.white,
      child: Container(
        height: 180,
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
              leading: Icon(icon, color: Colors.black, size: 30),
              title: Text(title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 100,
                        height: 25,
                        decoration: BoxDecoration(
                            color: title == "TEMPERATURE"
                                ? (((double.parse(value) >= 15) &&
                                        (double.parse(value) <= 25))
                                    ? const Color(0xFFD4EDDA)
                                    : (((double.parse(value) > 25) &&
                                            (double.parse(value) <= 35))
                                        ? const Color(0xFFFFF3CD)
                                        : ((double.parse(value) > 35)
                                            ? const Color(0xFFF8D7DA)
                                            : const Color(0xFFCCE5FF))))
                                : title == "LPG"
                                    ? (((double.parse(value) >= 0) &&
                                            (double.parse(value) <= 10))
                                        ? const Color(0xFFD4EDDA)
                                        : ((double.parse(value) >= 11) &&
                                                (double.parse(value) <= 20))
                                            ? const Color(0xFFFFF3CD)
                                            : const Color(0xFFF8D7DA))
                                    : title == "SMOKE"
                                        ? (((double.parse(value) >= 0) &&
                                                (double.parse(value) <= 10))
                                            ? const Color(0xFFD4EDDA)
                                            : ((double.parse(value) >= 11) &&
                                                    (double.parse(value) <= 20))
                                                ? const Color(0xFFFFF3CD)
                                                : const Color(0xFFF8D7DA))
                                        : const Color(0xFFCCE5FF),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            title == "TEMPERATURE"
                                ? (((double.parse(value) >= 15) &&
                                        (double.parse(value) <= 25))
                                    ? "Normal"
                                    : (((double.parse(value) > 25) &&
                                            (double.parse(value) <= 35))
                                        ? "High"
                                        : ((double.parse(value) > 35)
                                            ? "Very High"
                                            : "Low")))
                                : title == "LPG"
                                    ? (((double.parse(value) >= 0) &&
                                            (double.parse(value) <= 10))
                                        ? "Normal"
                                        : ((double.parse(value) >= 11) &&
                                                (double.parse(value) <= 20))
                                            ? "High"
                                            : "Very High")
                                    : title == "SMOKE"
                                        ? (((double.parse(value) >= 0) &&
                                                (double.parse(value) <= 10))
                                            ? "Normal"
                                            : ((double.parse(value) >= 11) &&
                                                    (double.parse(value) <= 20))
                                                ? "High"
                                                : "Very High")
                                        : "No Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: title == "TEMPERATURE"
                                    ? (((double.parse(value) >= 15) &&
                                            (double.parse(value) <= 25))
                                        ? Colors.green
                                        : (((double.parse(value) > 25) &&
                                                (double.parse(value) <= 35))
                                            ? Colors.orange
                                            : ((double.parse(value) > 35)
                                                ? Colors.redAccent
                                                : Colors.blueAccent)))
                                    : title == "LPG"
                                        ? (((double.parse(value) >= 0) &&
                                                (double.parse(value) <= 10))
                                            ? Colors.green
                                            : ((double.parse(value) >= 11) &&
                                                    (double.parse(value) <= 20))
                                                ? Colors.orange
                                                : Colors.redAccent)
                                        : title == "SMOKE"
                                            ? (((double.parse(value) >= 0) &&
                                                    (double.parse(value) <= 10))
                                                ? Colors.green
                                                : ((double.parse(value) >=
                                                            11) &&
                                                        (double.parse(value) <=
                                                            20))
                                                    ? Colors.orange
                                                    : Colors.redAccent)
                                            : Colors
                                                .blueAccent, //Colors.green[700],
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        placename,
                        style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircularPercentIndicator(
                    radius: 60,
                    lineWidth: 11,
                    percent: (double.parse(value) / 100),
                    center: Text(
                        "${double.parse(value).toStringAsFixed(1)}" "$unit",
                        style: const TextStyle(
                          color: Color(0xFF007BFF),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    progressColor: title == "TEMPERATURE"
                        ? (((double.parse(value) >= 15) &&
                                (double.parse(value) <= 25))
                            ? Colors.green
                            : (((double.parse(value) > 25) &&
                                    (double.parse(value) <= 35))
                                ? Colors.orange
                                : ((double.parse(value) > 35)
                                    ? Colors.redAccent
                                    : Colors.blueAccent)))
                        : title == "LPG"
                            ? (((double.parse(value) >= 0) &&
                                    (double.parse(value) <= 10))
                                ? Colors.green
                                : ((double.parse(value) >= 11) &&
                                        (double.parse(value) <= 20))
                                    ? Colors.orange
                                    : Colors.redAccent)
                            : title == "SMOKE"
                                ? (((double.parse(value) >= 0) &&
                                        (double.parse(value) <= 10))
                                    ? Colors.green
                                    : ((double.parse(value) >= 11) &&
                                            (double.parse(value) <= 20))
                                        ? Colors.orange
                                        : Colors.redAccent)
                                : Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
