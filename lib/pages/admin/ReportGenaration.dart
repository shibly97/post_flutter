import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/GenerateQR.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/customer/ComplaintList.dart';
import 'package:flutter_p/pages/customer/OTP.dart';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ReportGenaration extends StatelessWidget {
  final String userId;
  const ReportGenaration({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Reports'),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(userId: userId),
      bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId),
    );
  }
}

class LoginForm extends StatefulWidget {
  final String userId;
  const LoginForm({Key? key, required this.userId}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;

  // final TextEditingController _ticketId = TextEditingController();
  // final TextEditingController _description = TextEditingController();
  // final TextEditingController _date = TextEditingController();
  // final TextEditingController _comment = TextEditingController();
  // final TextEditingController _time = TextEditingController();
  // final TextEditingController _reAddressController = TextEditingController();
  // final TextEditingController _reContactNumberController =
  //     TextEditingController();
  // final TextEditingController _reEmailController = TextEditingController();

  // final TextEditingController _desController = TextEditingController();
  // final TextEditingController _instructionController = TextEditingController();
  // final TextEditingController _weightController = TextEditingController();
  // final TextEditingController _hightController = TextEditingController();
  // final TextEditingController _widthController = TextEditingController();
  // final TextEditingController _lengthController = TextEditingController();
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  String? nature;
  bool _isChecked = false;

  // int step = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Report Type:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                    height: 30.0,
                    child: DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(
                          value: 'PENDING',
                          child: Text('Pending Item'),
                        ),
                        DropdownMenuItem(
                          value: 'DELIVERED',
                          child: Text('Delivered Item'),
                        ),
                        DropdownMenuItem(
                          value: 'RECEIVER_NOT_FOUNT',
                          child: Text('Receiver not found Items'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          nature = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4)),
                    )),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'From Date',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: DateTimeField(
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Select date',
                      border: OutlineInputBorder(),
                    ),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    controller: fromDate,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'To Date',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: DateTimeField(
                    format: DateFormat("yyyy-MM-dd"),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Select date',
                      border: OutlineInputBorder(),
                    ),
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    controller: toDate,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // print('Username: $selectedBranch, Password: $nic');
              _fetchUsers(nature, fromDate.text, toDate.text);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Set button color to red
              minimumSize: Size(double.infinity, 40.0), // Set full width
            ),
            child: Text('Genarate Report'),
          ),
        ],
      ),
    );
  }

  void _fetchUsers(nature, fromDate, toDate) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        "status": nature?? '',
        "fromDate": fromDate,
        "toDate": toDate,
        "userId": widget.userId
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.post(
        Uri.parse(genarateReport),
        headers: {
          "Content-Type": "application/json"
        }, // Set headers for JSON data
        body: body,
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
        List<dynamic> data = responseBody['data'];

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          // automatically creates 1 empty sheet: Sheet1
          var excel = Excel.createExcel();
          Sheet sheetObject = excel['Report'];

          CellStyle cellStyle = CellStyle(
              backgroundColorHex: ExcelColor.blue900,
              fontFamily: getFontFamily(FontFamily.Calibri));

          // var cell = sheetObject.cell(CellIndex.indexByString('A1'));
          // cell.value = TextCellValue('Damn Text zz');
          // var cell1 = sheetObject.cell(CellIndex.indexByString('A2'));
          // cell1.value = TextCellValue('Damn Text x');
          // var cell2 = sheetObject.cell(CellIndex.indexByString('A3'));
          // cell2.value = TextCellValue('Damn Text 3');
          // var cell3 = sheetObject.cell(CellIndex.indexByString('A4'));
          // cell3.value = TextCellValue('Damn Text 5');

            List<CellValue> dataList = [
                TextCellValue('Sender Name'),
                TextCellValue('Sender Address'),
                TextCellValue('Sender Contact'),
                TextCellValue('Sender Email'),
                TextCellValue('Receiver Name'),
                TextCellValue('Receiver address'),
                TextCellValue('Receiver contact'),
                TextCellValue('Receiver email'),
                TextCellValue('description'),
                TextCellValue('instruction'),
                TextCellValue('weight'),
                TextCellValue('height'),
                TextCellValue('length'),
                TextCellValue('Status'),
                TextCellValue('Customer Id'),
                TextCellValue('Current Branch'),
            ];

            sheetObject.insertRowIterables(dataList, 0);

          for (int row = 0; row < data.length; row++) {
            Map<String, dynamic> rowData = data[row];
             List<CellValue> dataList = [
                TextCellValue(rowData['sender_name']),
                TextCellValue(rowData['sender_address']),
                TextCellValue(rowData['sender_contact']),
                TextCellValue(rowData['sender_email']),
                TextCellValue(rowData['re_name']),
                TextCellValue(rowData['re_address']),
                TextCellValue(rowData['re_contact']),
                TextCellValue(rowData['re_email']),
                TextCellValue(rowData['description']),
                TextCellValue(rowData['instruction']),
                TextCellValue(rowData['weight']),
                TextCellValue(rowData['height']),
                TextCellValue(rowData['length']),
                TextCellValue(rowData['status']),
                TextCellValue(rowData['customer'].toString()),
                TextCellValue(rowData['current_branch'].toString())
            ];

            sheetObject.insertRowIterables(dataList, row + 1);
            // for (int col = 0; col < data[row].length; col++) {
            //   sheetObject
            //       .cell(CellIndex.indexByColumnRow(
            //           rowIndex: row, columnIndex: col))
            //       .value = data[row][col];
            // }
          }

          // List<CellValue> dataList = [
          //   TextCellValue('Google'),
          //   TextCellValue('loves'),
          //   TextCellValue('Flutter'),
          //   TextCellValue('and'),
          //   TextCellValue('Flutter'),
          //   TextCellValue('loves'),
          //   TextCellValue('Excel')
          // ];

          // sheetObject.insertRowIterables(dataList, 1);

          

          // excel.save();
          // final List<int>? excelBytes = excel.encode();
          var excelBytes = excel.save();

          if (excelBytes != null) {
            // Save Excel file to device's temporary directory
            // final Directory tempDir = await getTemporaryDirectory();
            var directory = await getApplicationDocumentsDirectory();
            final String path = '${directory.path}/report.xlsx';
            final File file = File(path);

            // Write Excel bytes to file
            await file.writeAsBytes(excelBytes);

            //           File(join('$directory/output_file_name.xlsx'))
            // ..createSync(recursive: true)
            // ..writeAsBytesSync(fileBytes)

            // Share the Excel file
            await Share.shareXFiles([XFile(path)], text: 'Sharing Excel File');
          } else {
            // Handle the case where excelBytes is null
            throw Exception('Failed to encode Excel data');
          }

          // // Add data to Excel sheet
          // for (int row = 0; row < data.length; row++) {
          //   for (int col = 0; col < data[row].length; col++) {
          //     sheet
          //         .cell(CellIndex.indexByColumnRow(
          //             rowIndex: row, columnIndex: col))
          //         .value = data[row][col];
          //   }
          // }

          // final Directory directory =
          //     await getExternalStorageDirectory() ?? Directory('default_path');
          // final String path = '${directory.path}/data.xlsx';
          // final File file = File(path);
          // // await file.writeAsBytes(excel.encode());
          // final List<int>? excelBytes = excel.encode();
          // if (excelBytes != null) {
          //    print('Error: Excel data could not be encoded.');
          //   await file.writeAsBytes(excelBytes);
          // } else {
          //   // Handle the case where excel.encode() returns null
          //   print('Error: Excel data could not be encoded.');
          // }

          // ScaffoldMessenger.of(context)
          //   ..removeCurrentSnackBar()
          //   ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 1));

          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (BuildContext context) {
          //   return ComplaintList(userId: widget.userId, type: 'customer',);
          // }));
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
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  }
}
