import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intern_flutter_challenge/widgets/my_appbar.dart';

class QRView extends StatelessWidget {
  final String textQR;
  const QRView({
    Key? key,
    required this.textQR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: "QR View"),
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
