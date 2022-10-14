import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../widgets/location_card.dart';
import '../widgets/no_data.dart';
import '../widgets/server_error.dart';
import '../widgets/network_error.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<String> dataStream;

  @override
  void initState() {
    super.initState();
    dataStream = getData();
  }

  Stream<String> getData() async* {
    var url =
        Uri.parse('https://home-safety-backend.herokuapp.com/get_locations');
    try {
      var response = await http.get(url);
      await Future<void>.delayed(const Duration(seconds: 1));
      yield "${response.statusCode}#${response.body}";
    } on SocketException catch (_) {
      showSnackBar();
      yield "404#No Internet Connection";
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Hey, Steve!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
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
                  var data = jsonDecode(snapshot.data!.split('#')[1])['places']
                      as List;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return LocationCard(
                            locationID: data[index]['id'].toString(),
                            locationName: data[index]['place_name'],
                            longitude:
                                double.parse(data[index]['x_coordinate']),
                            latitude: double.parse(data[index]['y_coordinate']),
                            locationImage: 'assets/images/location-pic1.jpeg',
                          );
                        },
                      ),
                    ],
                  );
                }
                if (status == 401) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: NoDataCard(
                        message: 'No locations added yet!',
                      ),
                    ),
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
        )));
  }
}
