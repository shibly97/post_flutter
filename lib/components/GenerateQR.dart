import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:share/share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class QRCodeWidget extends StatefulWidget {
  final String id;
  final String userId;

  const QRCodeWidget({Key? key, required this.id, required this.userId})
      : super(key: key);

  @override
  _QRCodeWidgetState createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  final ScreenshotController screenshoController = ScreenshotController();

  Future<void> captuAndSave() async {
    final Uint8List? imageFile = await screenshoController.capture();

    if (imageFile != null) {
      // final temp = await getTemporaryDirectory();
      
      // final path = '${temp.path}/image.jpg';
      // File(path).writeAsBytesSync(imageFile);
      // final XFile file = XFile(path);

      final result = await ImageGallerySaver.saveImage(imageFile);
      // final result = await ImageGallerySaver.saveImage(uint8list);
      print('download');
      if (result['isSuccess']) {
        print('QR Code Saved Successfully');
        final snackBar =
            Message(message: 'QR Code Saved Successfully', type: "success");

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        print('QR Code Saved Faild');
        print('QR Code Saved Faild');
        final snackBar =
            Message(message: 'QR Code Saved Successfully', type: "success");

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      // final PermissionStatus status = await Permission.storage.request();
      // if(status.isGranted){
      // }else{
      //   print('Permission to access storage denied');
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Screenshot(
              controller: screenshoController,
              child: QrImageView(
                data: widget.id,
                size: 250,
              ),
            ),
          ),
          const SizedBox(height: 20), // Add some space between QR code and text
          const Text('Download for Future References'),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                print('clicked');
                captuAndSave();
              },
              child: Text('Capture and Download')),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CustomerDashboard(userId: widget.userId);
                }));
              },
              child: Text('To Dashboard')),
          ElevatedButton(
            onPressed: () async {
              // Call the function to share the image with WhatsApp
              // shareImageWithWhatsApp(); // Assuming _image is your File object

              // final id = widget.id;
              // await Share.share('The Job ID : $id');

              // const uilImage = 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png';
              // final url = Uri.parse(uilImage);
              // final response = await http.get(url);
              // final bytes = response.bodyBytes;

              // final temp = await getTemporaryDirectory();
              // final path = '${temp.path}/image.jpg';
              // File(path).writeAsBytesSync(bytes);

              // // await Share.shareFiles([path]);
              // final XFile file = XFile(path);
              // await Share.shareXFiles([file], text: 'Sharing QR Code');

              final Uint8List? imageFile = await screenshoController.capture();

              if (imageFile != null) {
                // Convert the image file to a Uint8List
                // Share the image with WhatsApp using the share plugin
                // Share.shareXFiles(['$imageFile'], text: 'Shared from my app');
                // final bytes = response.bodyBytes;
                final temp = await getTemporaryDirectory();
                final path = '${temp.path}/image.jpg';
                File(path).writeAsBytesSync(imageFile);

                // await Share.shareFiles([path]);
                final XFile file = XFile(path);
                await Share.shareXFiles([file], text: 'Sharing QR Code');
              } else {
                // Handle the case where imageFile is null
                print('Failed to capture screenshot.');
              }
            },
            child: Text('Share'),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNaviatiobBar(type: 'customer', userId: widget.userId),
    );
  }
}
