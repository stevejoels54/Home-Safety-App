import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import '../presentation/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Steve Jobs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text("stevejobs@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile-pic.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            title: Row(children: <Widget>[
              const Icon(
                Icons.person_rounded,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Profile",
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ]),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(children: <Widget>[
              const Icon(
                Icons.settings_rounded,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Settings",
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ]),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Row(children: <Widget>[
              const Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                "Logout",
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ]),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
