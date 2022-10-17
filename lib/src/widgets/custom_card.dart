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

// functions that return the color based on the value

  Color getDarkColor() {
    if (title == "TEMPERATURE") {
      if ((double.parse(value) >= 15) && (double.parse(value) <= 25)) {
        return Colors.green;
      } else if ((double.parse(value) > 25) && (double.parse(value) <= 35)) {
        return Colors.orange;
      } else if (double.parse(value) > 35) {
        return Colors.red;
      } else {
        return Colors.blue;
      }
    } else {
      if (double.parse(value) >= 0 && double.parse(value) <= 10) {
        return Colors.green;
      } else if (double.parse(value) > 10 && double.parse(value) <= 20) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }
  }

  Color getLightColor() {
    if (title == "TEMPERATURE") {
      if ((double.parse(value) >= 15) && (double.parse(value) <= 25)) {
        return const Color(0xFFD4EDDA);
      } else if ((double.parse(value) > 25) && (double.parse(value) <= 35)) {
        return const Color(0xFFFFF3CD);
      } else if (double.parse(value) > 35) {
        return const Color(0xFFF8D7DA);
      } else {
        return const Color(0xFFCCE5FF);
      }
    } else {
      if (double.parse(value) >= 0 && double.parse(value) <= 10) {
        return const Color(0xFFD4EDDA);
      } else if (double.parse(value) > 10 && double.parse(value) <= 20) {
        return const Color(0xFFFFF3CD);
      } else {
        return const Color(0xFFF8D7DA);
      }
    }
  }

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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.033,
                        decoration: BoxDecoration(
                            color: getLightColor(),
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
                                color: getDarkColor(),
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
                  padding: const EdgeInsets.all(28),
                  child: CircularPercentIndicator(
                    radius: 65,
                    lineWidth: 12,
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: getLightColor(),
                    animation: true,
                    percent: (double.parse(value) / 100),
                    center: Text(
                        "${double.parse(value).toStringAsFixed(1)}" "$unit",
                        style: TextStyle(
                          color: getDarkColor(),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    progressColor: getDarkColor(),
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
