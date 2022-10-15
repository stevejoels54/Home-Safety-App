import 'package:flutter/material.dart';
import '../presentation/home_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      // shape: ShapeBorder.lerp(
      //   const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(30),
      //     ),
      //   ),
      //   const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(30),
      //     ),
      //   ),
      //   0,
      // ),
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.home)),
      ],
      backgroundColor: Colors.black,
    );
  }
}
