import 'package:flutter/material.dart';

import '../widgets/my_appbar.dart';
import 'gps_maps/map_location_page.dart';


class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MapLocationPage(),
              ),
            );
          },
          child: const Text("GPS Maps"),
        ),
      ),
    );
  }
}
