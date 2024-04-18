import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class QRCodeWidget extends StatefulWidget {
  final String id;

  const QRCodeWidget({Key? key, required this.id}) : super(key: key);

  @override
  _QRCodeWidgetState createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PrettyQr(
              typeNumber: 4,
              size: 200,
              data: widget.id,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _captureAndSharePng();
              },
              child: Text('Download QR Code'),
            ),
          ],
        ),
      ),
    );
  }

  _captureAndSharePng() async {
    try {
      final qrCode = PrettyQr(
        typeNumber: 4,
        size: 200,
        data: widget.id,
      );

      // final image = await qrCode.toUint8List(200);

      final directory = (await getExternalStorageDirectory())!.path;
      final file = File('$directory/qr_code.png');
      // await file.writeAsBytes(image);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('QR Code downloaded successfully'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}