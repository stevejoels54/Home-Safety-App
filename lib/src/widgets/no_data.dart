import 'package:flutter/material.dart';

class NoDataCard extends StatelessWidget {
  final String message;
  const NoDataCard({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image here
              const Image(
                image: AssetImage('assets/images/database-pic1.png'),
                height: 100,
                width: 100,
              ),
              const Center(
                child: Text(
                  "No Data!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
