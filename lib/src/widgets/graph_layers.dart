import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';

List<ChartLayer> layers(List data, String value) {
  final from = DateTime(2022, 1, 1, 0, 1, 0);
  final to = DateTime(2022, 1, 1, 1, 0, 0);
  final frequency =
      (to.millisecondsSinceEpoch - from.millisecondsSinceEpoch) / 6.0;
  return [
    ChartAxisLayer(
      settings: ChartAxisSettings(
        x: ChartAxisSettingsAxis(
          frequency: frequency,
          max: to.millisecondsSinceEpoch.toDouble(),
          min: from.millisecondsSinceEpoch.toDouble(),
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
        ),
        y: const ChartAxisSettingsAxis(
          frequency: 10,
          max: 100.0,
          min: 0.0,
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
        ),
      ),
      labelX: (value) => DateFormat('HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
      labelY: (value) => value.toInt().toString(),
    ),
    ChartBarLayer(
      items: [
        for (var i = 0; i < data.length; i++)
          ChartBarDataItem(
            color: value == "temperature"
                ? Colors.yellowAccent
                : value == "lpg"
                    ? Colors.orangeAccent
                    : value == "smoke"
                        ? Colors.green
                        : Colors.black,
            value: data[i]['value'],
            x: DateTime(2022, 1, 1, 0, data[i]['minutes'], 0)
                .millisecondsSinceEpoch
                .toDouble(),
          )
      ],
      settings: const ChartBarSettings(
        thickness: 8.0,
        radius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
  ];
}
