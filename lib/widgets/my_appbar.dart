import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(
        Icons.list,
        color: Colors.white,
      ),
      title: const Text(
        "Droid Device",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationIcon: const MyAppIcon(),
              applicationName: "Droid Device",
              applicationVersion: "1.0.0",
              applicationLegalese:
                  "Mobile Developer (Flutter) Challenge for Intern at Synapsis.id. Developed by Alaraz Wari Setiawan, 2023",
            );
          },
          tooltip: "About",
        ),
      ],
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 75, 176, 248),
              Color.fromARGB(255, 101, 20, 231)
            ],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
          ),
        ),
      ),
    );
  }
}

class MyAppIcon extends StatelessWidget {
  const MyAppIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/images/app_icon.png"),
      width: 64,
      height: 64,
    );
  }
}
