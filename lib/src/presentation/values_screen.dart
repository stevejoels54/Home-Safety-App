import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_appbar.dart';
import '../widgets/drawer.dart';
import '../widgets/bottom_appbar.dart';
import '../widgets/values_cards.dart';
import '../widgets/no_data.dart';
import '../widgets/server_error.dart';
import 'dart:io';

class ValuesScreen extends StatefulWidget {
  final String locationID;
  final String placename;
  const ValuesScreen({
    Key? key,
    required this.locationID,
    required this.placename,
  }) : super(key: key);

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  late Stream<String> dataStream;
  final bool _running = true;
  var setData = {'temperature': 0.0, 'lpg': 0.0, 'smoke': 0.0};

  @override
  void initState() {
    super.initState();
    dataStream = getData();
  }

  Stream<String> getData() async* {
    var url = Uri.parse(
        'https://home-safety-backend.herokuapp.com/sensor_data/${widget.locationID}');
    while (_running) {
      try {
        var response = await http.get(url);
        await Future<void>.delayed(const Duration(seconds: 1));
        yield "${response.statusCode}#${response.body}";
      } on SocketException catch (_) {
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
            dataStream = getData();
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
      bottomNavigationBar: BottomAppbar(
        locationID: widget.locationID,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            dataStream = getData();
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: StreamBuilder(
          stream: dataStream,
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
                return ValuesCards(
                  temperature: "${data['temperature']}",
                  lpg: "${data['lpg']}",
                  smoke: "${data['smoke']}",
                  placename: widget.placename,
                );
              }
              if (status == 401) {
                return const NoDataCard(
                  message:
                      "No data available for this location. Please add data to this location.",
                );
              } else {
                return const ServerErrorCard();
              }
            } else {
              return Column(
                children: [
                  Container(
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
                  const SizedBox(
                    height: 20,
                  ),
                  ValuesCards(
                    temperature: "${setData['temperature']}",
                    lpg: "${setData['lpg']}",
                    smoke: "${setData['smoke']}",
                    placename: widget.placename,
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
