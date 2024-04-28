import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  const GenerateQR({super.key});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  TextEditingController urlController = TextEditingController();
  late String QRString = ''; // Initialize QRString with an empty string
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(QRString.isNotEmpty)
                QrImageView(data:QRString , size: 200),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) => {
                    setState(() {
                      QRString = value;
                    })
                  },
                  // controller: urlController,
                  decoration: InputDecoration(
                    hintText: 'Enter The Value',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    labelText: 'Enter Your Data'
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // ElevatedButton(onPressed: (){
              //   setState(() {
              //     QRString = urlController as String;
              //   });
              // }, child: Text('Genarate QR Code'))
            ],
          ),
        ),
      ),
    );
  }
}
