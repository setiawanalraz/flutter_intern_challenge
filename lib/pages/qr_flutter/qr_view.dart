import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRView extends StatelessWidget {
  final String textQR;
  const QRView({
    Key? key,
    required this.textQR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: const Text("QR View", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: textQR,
              version: QrVersions.auto,
              size: 200,
            ),
            Text(
              textQR,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
