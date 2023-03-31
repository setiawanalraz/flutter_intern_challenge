import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intern_flutter_challenge/style/style.dart';
import 'package:intern_flutter_challenge/widgets/my_appbar.dart';
import 'package:intern_flutter_challenge/pages/qr_flutter/qr_view.dart';

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

  final textQRController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    textQRController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        appBarTitle: "QR Code Generator",
      ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Generate QR Code",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextField(
                        controller: textQRController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Text("Input Text QR Code"),
                          errorText: _validate ? "Can't be empty" : null,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (textQRController.value.text.isEmpty) {
                                _validate = !_validate;
                              }
                            });
                            bool value = textQRController.text.isNotEmpty;
                            if (value == true) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => QRView(
                                    textQR: textQRController.text,
                                  ),
                                  transitionDuration:
                                      const Duration(seconds: 0),
                                ),
                              );
                            }
                          },
                          child: const Text("Generate QR Code"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).toList(),
          );
        },
      ),
    );
  }
}
