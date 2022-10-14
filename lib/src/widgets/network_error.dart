import 'package:flutter/material.dart';

class NetworkErrorCard extends StatelessWidget {
  const NetworkErrorCard({
    Key? key,
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
            children: const [
              // image here
              Image(
                image: AssetImage('assets/images/network-pic1.png'),
                height: 100,
                width: 100,
              ),
              Center(
                child: Text(
                  "Network Error!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "Try refreshing the page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
