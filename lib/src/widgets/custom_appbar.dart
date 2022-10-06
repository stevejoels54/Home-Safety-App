import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(90);
  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 6,
      shape: ShapeBorder.lerp(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        0,
      ),
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Text(title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),

      //title: Text(title),
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
      ],
      backgroundColor: Colors.black,
    );
  }
}
