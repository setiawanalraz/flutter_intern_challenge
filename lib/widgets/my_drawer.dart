import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/main_page.dart';
import '../pages/second_page.dart';
import '../pages/gps_maps/map_location_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                'Synapsis.id',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                '@synapsis.id',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_icon.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.phone_android, color: Colors.indigo),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Halaman A",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainPage();
                    },
                  ),
                );
              },
            ),
            const Divider(height: 2.0),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.qr_code,
                    color: Colors.deepOrange,
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Halaman B",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SecondPage();
                    },
                  ),
                );
              },
            ),
            const Divider(height: 2.0),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.map, color: Colors.green),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Halaman C",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MapLocationPage()));
              },
            ),
            const Divider(height: 2.0),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.camera_enhance,
                    color: Colors.teal,
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Halaman Bonus",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () {},
            ),
            const Divider(height: 2.0),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.amber,
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () => showAlertDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  //set up button
  Widget cancelButton() {
    return TextButton(
      onPressed: () => Navigator.of(context, rootNavigator: true).pop("dialog"),
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget confirmButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop("dialog");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
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
