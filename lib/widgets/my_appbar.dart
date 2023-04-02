import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intern_flutter_challenge/data/menu_items.dart';
import 'package:intern_flutter_challenge/models/menu_item.dart';
import 'package:intern_flutter_challenge/pages/login_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  const MyAppBar({
    Key? key,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(appBarTitle),
      actions: [
        PopupMenuButton<MenuItem>(
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            ...MenuItems.itemsFirst.map(buildItem).toList(),
            const PopupMenuDivider(),
            ...MenuItems.itemsSecond.map(buildItem).toList(),
          ],
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

  PopupMenuItem<MenuItem> buildItem(MenuItem item) {
    return PopupMenuItem<MenuItem>(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Text(item.text, style: const TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemAbout:
        showAboutDialog(
          context: context,
          applicationIcon: const MyAppIcon(),
          applicationName: "Droid Device",
          applicationVersion: "1.0.0",
          applicationLegalese:
              "Mobile Developer (Flutter) Challenge for Intern at Synapsis.id. Developed by Alaraz Wari Setiawan, 2023",
        );
        break;

      case MenuItems.itemLogout:
        showAlertDialog(context);
        break;

      default:
    }
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

showAlertDialog(BuildContext context) {
  //set up button
  Widget cancelButton() {
    return TextButton(
      onPressed: () => Navigator.of(context, rootNavigator: true).pop("dialog"),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        overlayColor: MaterialStateProperty.all(Colors.blue.shade200),
      ),
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget confirmButton() {
    return TextButton(
      onPressed: () async {
        final pref = await SharedPreferences.getInstance();
        pref.setBool("showMainPage", false);

        if (context.mounted) {
          Navigator.of(context, rootNavigator: true).pop("dialog");
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
        overlayColor: MaterialStateProperty.all(Colors.red.shade200),
      ),
      child: const Text(
        "Confirm",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //set up alert dialog
  AlertDialog alertDialog = AlertDialog(
    title: const Text("Logout"),
    content: const Text("Are you sure you want to logout?"),
    actions: [
      confirmButton(),
      cancelButton(),
    ],
  );

  //show dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}
