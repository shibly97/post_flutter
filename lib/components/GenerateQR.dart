
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';


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

  Future<void> captuAndSave() async{
    final Uint8List? uint8list = await screenshoController.capture();
    if(uint8list != null){
      final result =
          await ImageGallerySaver.saveImage(uint8list);
        // final result = await ImageGallerySaver.saveImage(uint8list);
        print('download');
        if(result['isSuccess']){
          print('QR Code Saved Successfully');
           final snackBar = Message(message: 'QR Code Saved Successfully', type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }else{
          print('QR Code Saved Faild');
           print('QR Code Saved Faild');
           final snackBar = Message(message: 'QR Code Saved Successfully', type: "success");

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
          ElevatedButton(onPressed: ()  {
            print('clicked');
             captuAndSave();
          }, child: Text('Capture and Download')),
          ElevatedButton(onPressed: ()  {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return CustomerDashboard(userId: widget.userId);
              }));
          }, child: Text('To Dashboard'))
          
        ],
      ),
    );
  }
}
