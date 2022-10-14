import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/graph_layers.dart';
import '../widgets/no_data.dart';
import '../widgets/server_error.dart';
import '../widgets/network_error.dart';

class GraphScreen extends StatefulWidget {
  final String locationID;
  final String title;
  final String value;
  const GraphScreen({
    Key? key,
    required this.locationID,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  late Stream<String> dataStream;

  @override
  void initState() {
    super.initState();
    dataStream = getData();
  }

  Stream<String> getData() async* {
    var url = Uri.parse(
        'https://home-safety-backend.herokuapp.com/sensor_data_trend/${widget.locationID}');
    var response = await http.get(url);
    yield "${response.statusCode}#${response.body}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: GestureDetector(
              onTap: () => setState(() {
                dataStream = getData();
              }),
              child: const Icon(
                Icons.refresh,
                size: 26.0,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Text(
              "Last 1hr ${widget.value} trend",
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 400.0,
                maxWidth: 600.0,
              ),
              padding: const EdgeInsets.all(24.0),
              child: StreamBuilder(
                stream: dataStream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    var statusCode = jsonDecode(snapshot.data!.split('#')[0]);
                    if (statusCode == 200) {
                      var values = jsonDecode(
                          snapshot.data!.split('#')[1])['sensorData'];
                      var minutes = 0;
                      List data = [];
                      for (var value in values) {
                        data.add(
                            {'minutes': minutes, 'value': value[widget.value]});
                        minutes += 10;
                      }
                      return Card(
                        color: Colors.white,
                        elevation: 6,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          height: 600,
                          width: 400,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Chart(
                            layers: layers(data = data, widget.value),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0)
                                    .copyWith(
                              bottom: 12.0,
                            ),
                          ),
                        ),
                      );
                    }
                    if (statusCode == 401) {
                      return const NoDataCard(
                        message:
                            "No data available for this location. Please add data to this location.",
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: ServerErrorCard(),
                        ),
                      );
                    }
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: NetworkErrorCard(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
