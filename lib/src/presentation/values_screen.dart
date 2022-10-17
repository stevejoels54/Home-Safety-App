import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_appbar.dart';
import '../widgets/drawer.dart';
import '../widgets/bottom_appbar.dart';
import '../widgets/values_cards.dart';
import '../widgets/no_data.dart';
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
        //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            setState(() {
              dataStream = getData();
            });
          },
          child: const Icon(Icons.refresh),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
              stream: dataStream,
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
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
                      temperature: "${setData['temperature']}",
                      lpg: "${setData['lpg']}",
                      smoke: "${setData['smoke']}",
                      placename: widget.placename,
                      networkError: "false",
                    );
                  }
                  if (status == 401) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: const NoDataCard(
                          message:
                              "No data available, please install sensor at this location."),
                    );
                  } else {
                    return ValuesCards(
                      temperature: "${setData['temperature']}",
                      lpg: "${setData['lpg']}",
                      smoke: "${setData['smoke']}",
                      placename: widget.placename,
                      networkError: "true",
                    );
                  }
                } else {
                  return ValuesCards(
                    temperature: "${setData['temperature']}",
                    lpg: "${setData['lpg']}",
                    smoke: "${setData['smoke']}",
                    placename: widget.placename,
                    networkError: "true",
                  );
                }
              },
            ),
          ),
        ));
  }
}
