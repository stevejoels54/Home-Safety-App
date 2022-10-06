import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_appbar.dart';
import '../widgets/drawer.dart';
import '../widgets/bottom_appbar.dart';
import '../widgets/custom_card.dart';
import 'dart:io';

class ValuesScreen extends StatefulWidget {
  const ValuesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ValuesWidgetState createState() => _ValuesWidgetState();
}

class _ValuesWidgetState extends State<ValuesScreen> {
  bool _running = true;
  var setData = {'temperature': 0.0, 'lpg': 0.0, 'smoke': 0.0};

  Stream<String> getData() async* {
    var url =
        Uri.parse('https://home-safety-backend.herokuapp.com/sensorData/');
    while (_running) {
      try {
        var response = await http.get(url);
        await Future<void>.delayed(const Duration(seconds: 1));
        yield "${response.statusCode}#${response.body}";
      } on SocketException catch (_) {
        showSnackBar();
        yield "404#No Internet Connection";
      }
    }
  }

  void showSnackBar() {
    final snackBar = SnackBar(
      content: const Text('Network error!'),
      action: SnackBarAction(
        label: 'Refresh',
        onPressed: () {
          setState(() {
            _running = !_running;
          });
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Welcome home, Steve!"),
      drawer: const AppDrawer(),
      bottomNavigationBar: const BottomAppbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            _running = !_running;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: StreamBuilder(
          stream: getData(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              var status = jsonDecode(snapshot.data!.split('#')[0]);
              if (status == 200) {
                var data =
                    jsonDecode(snapshot.data!.split('#')[1])['sensorData'];

                setData = {
                  'temperature': data['temperature'],
                  'lpg': data['lpg'],
                  'smoke': data['smoke']
                };
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomCard(
                      title: "TEMPERATURE",
                      icon: Icons.thermostat_rounded,
                      value: "${data['temperature']}",
                      unit: "°C",
                      color: Colors.yellow,
                    ),
                    // lpg card
                    CustomCard(
                      title: "LPG",
                      icon: Icons.gas_meter_rounded,
                      value: "${data['lpg']}",
                      unit: "%",
                      color: Colors.red,
                    ),
                    // smoke card
                    CustomCard(
                      title: "SMOKE",
                      icon: Icons.air_rounded,
                      value: "${data['smoke']}",
                      unit: "%",
                      color: Colors.orange,
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCard(
                      title: "TEMPERATURE",
                      icon: Icons.thermostat_rounded,
                      value: "${setData['temperature']}",
                      unit: "°C",
                      color: Colors.yellow,
                    ),
                    // lpg card
                    CustomCard(
                      title: "LPG",
                      icon: Icons.gas_meter_rounded,
                      value: "${setData['lpg']}",
                      unit: "%",
                      color: Colors.red,
                    ),
                    // smoke card
                    CustomCard(
                      title: "SMOKE",
                      icon: Icons.air_rounded,
                      value: "${setData['smoke']}",
                      unit: "%",
                      color: Colors.orange,
                    ),
                  ],
                );
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomCard(
                    title: "TEMPERATURE",
                    icon: Icons.thermostat_rounded,
                    value: "${setData['temperature']}",
                    unit: "°C",
                    color: Colors.yellow,
                  ),
                  // lpg card
                  CustomCard(
                    title: "LPG",
                    icon: Icons.gas_meter_rounded,
                    value: "${setData['lpg']}",
                    unit: "%",
                    color: Colors.red,
                  ),
                  // smoke card
                  CustomCard(
                    title: "SMOKE",
                    icon: Icons.air_rounded,
                    value: "${setData['smoke']}",
                    unit: "%",
                    color: Colors.orange,
                  ),
                ],
              );
            }
          },
        ),
      )),
    );
  }
}
