import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/JobDetails.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:http/http.dart' as http;

class ScanQRCode extends StatefulWidget {

  final String type;
  final String userId;
  const ScanQRCode({super.key, required this.userId, required this.type});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  late final String userId;
  String qrResult = "Looking for JOB Id : ";
  String id = "";

  Future<void> scanQr() async{
    try {
      // FlutterBarcodeScanner.getBarcodeStreamReceiver("#ff6666", "Cancel", false, ScanMode.DEFAULT)
      //    .listen((barcode) { 
      //    /// barcode to be used
      //    });
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', false, ScanMode.QR);
      if(!mounted)return;
      setState(() {
        id = barcodeScanRes;
      });
      print("******** out");
      print(barcodeScanRes);
      print(mounted);
      // setState(() {
      //   qrResult = barcodeScanRes;
      // });
    } on PlatformException {
      qrResult = 'Failed to Read QR Code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              '$qrResult $id',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: TextField(
                  onChanged: (value) => {
                    setState(() {
                      id = value;
                    })
                  },
                  // selectionHeightStyle: BoxHeightStyle.,
                  // controller: urlController,
                  decoration: InputDecoration(
                    hintText: 'Enter The Value',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    labelText: 'Enter Your Data'
                  ),
                ),
              ),
               SizedBox(
              height: 30,
            ),
              ElevatedButton(onPressed: scanQr, child: Text('Get By Scan')),
              SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: (){
               _fetchUsers(id);
            }, child: Text('Countinue')),
          ],
        ),
      ),
       bottomNavigationBar:
          BottomNaviatiobBar(type: widget.type == 'post-officer' ? 'post-officer' : 'postman', userId: widget.userId),
      // body: MobileScanner(
      //   onDetect: (capture) {},
      // ),
    );
  }

    void _fetchUsers(id) async {
    try {
      // setState(() {
      //   isLoading = true;
      // });
      print('fetching users');

      // Create a Map to hold the username and password
      // Map<String, String> data = {
      //   "id": id
      //   };

      // // Encode the data as JSON
      // String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.get(
        Uri.parse('$getJobById/$id'),
        headers: {
          "Content-Type": "application/json"
        },
      );

      print(response.body);

      final responseBody = response.body;

      // Check if the response status code is successful
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        Map<String, dynamic> responseBody = json.decode(response.body);

        // Access the 'success' variable from the parsed JSON
        bool success = responseBody['success'];
        String message = responseBody['message'];
        Map<String, dynamic> data =  responseBody['data'];

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return JobDetailsPage(data:data, userId: widget.userId, type: widget.type,);
          }));
        } else {
          final snackBar = Message(message: message, type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
        // }else{
        //     // Navigator.of(context)
        //     //       .push(MaterialPageRoute(builder: (BuildContext context) {
        //     //     return const SuperAdminDashboard();
        //     //   }));
        // }

        // Now you can use the 'success' variable
        print('Success: $success');
        
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }

      // Handle the response here

      print('completed');
      // setState(() {
      //   isLoading = false;
      // });
    } catch (err) {
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  }
}
