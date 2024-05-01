import 'package:flutter/material.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
   final String userId;
  const GenerateQR({super.key, required this.userId});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
   late String userId;
  TextEditingController urlController = TextEditingController();
  late String QRString = ''; // Initialize QRString with an empty string
  
    @override
  void initState() {
    super.initState();
    userId = widget.userId;// Call the function to fetch admins when the widget initializes
  }

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
      bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId),
    );
  }
}
