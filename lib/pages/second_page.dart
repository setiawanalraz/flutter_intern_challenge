import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';
import '../widgets/my_appbar.dart';
import '../widgets/my_drawer.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceInfo.androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder<AndroidDeviceInfo>(
        future: getInfo(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  leading: const Icon(
                    Icons.whatshot,
                    color: Colors.indigo,
                  ),
                  title: Text(
                    "Data SoC",
                    style: indigo,
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Manufacturer",
                            style: indigo,
                          ),
                          Text(
                            "${data?.manufacturer}",
                            style: indigo,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Model",
                            style: indigo,
                          ),
                          Text(
                            "${data?.model}",
                            style: indigo,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Build",
                            style: indigo,
                          ),
                          Text(
                            "${data?.device}",
                            style: indigo,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SDK",
                            style: indigo,
                          ),
                          Text(
                            "${data?.version.sdkInt}",
                            style: indigo,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Version Code",
                            style: indigo,
                          ),
                          Text(
                            "${data?.version.release.toString()}",
                            style: indigo,
                          ),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ).toList(),
          );
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}
