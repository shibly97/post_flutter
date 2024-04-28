import 'package:flutter/material.dart';
import 'package:flutter_p/components/QRGenarate.dart';
import 'package:flutter_p/components/ScanQR.dart';

class QRScanner extends StatefulWidget {
  final String userId;
  const QRScanner({super.key, required this.userId});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                //   Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   // return ScanQRCode(userId: widget.userId,);
                // }));
                });
              },
              child: Text('Scan QR Code'),
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return GenerateQR();
                }));
              },
              child: Text('Generate QR Code'),
            )
          ],
        ),
      ),
    );
  }
}
