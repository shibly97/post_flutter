import 'dart:convert';

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

class ComplaintDetails extends StatelessWidget {
  final String userId;
  final String type;
   final dynamic data;
  const ComplaintDetails(
      {Key? key, required this.userId, required this.type, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == "admin"? 'Update Complaint' : 'Create Complaint' ),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(
        userId: userId,
        type: type,
        data: data,
      ),
      bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId),
    );
  }
}

class LoginForm extends StatefulWidget {
  final String type;
  final String userId;
  final dynamic data;
  const LoginForm(
      {Key? key, required this.userId, required this.type, this.data})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;

  late TextEditingController _ticketId = TextEditingController();
  late TextEditingController _description = TextEditingController();
  late TextEditingController _date = TextEditingController();
  late TextEditingController _comment = TextEditingController();
  late TextEditingController _time = TextEditingController();
  late TextEditingController resolve_comment = TextEditingController();
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
  String? nature;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

   _ticketId = TextEditingController(text: widget.data['job_id'].toString());

    _description = TextEditingController(text: widget.data['description']);
    _comment = TextEditingController(text: widget.data['comment']);
    DateTime dateTime = DateTime.parse(widget.data['issue_date']);
    String formattedDate =
        DateFormat.yMd().format(dateTime); // e.g., Apr 27, 2024
    String formattedTime = DateFormat.Hms().format(dateTime);
    _date = TextEditingController(text: formattedDate);
    _time = TextEditingController(text: formattedTime);
    resolve_comment = TextEditingController(text: widget.data['resolve_comment']);

    setState(() {
      nature = widget.data['nature'];
      _isChecked =  widget.data['resolved']? true : false;
    });
  }

  // int step = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Ticket / Reference Id:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    enabled: false,
                    controller: _ticketId,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      // hintText: 'Staff ID',
                      border: OutlineInputBorder(),
                    ),
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
                  'Nature of Complaint:',
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
                          value: 'damage',
                          child: Text('Damage'),
                        ),
                        DropdownMenuItem(
                          value: 'missing_item',
                          child: Text('Missing Item'),
                        ),
                        DropdownMenuItem(
                          value: 'delay',
                          child: Text('Delay'),
                        ),
                      ],
                      onChanged: null,
                      value: nature,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4)),
                    )),
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
                  'Description:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                     enabled: false,
                    controller: _description,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      // hintText: 'Enter first name',
                      border: OutlineInputBorder(),
                    ),
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
                  'Additional Comments:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                     enabled: false,
                    controller: _comment,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      // hintText: 'Enter last name',
                      border: OutlineInputBorder(),
                    ),
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
                  'Date',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: DateTimeField(
                    format: DateFormat("yyyy-MM-dd"),
                     enabled: false,
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
                    controller: _date,
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
                  'Time:',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: DateTimeField(
                    format: DateFormat("HH:mm"),
                     enabled: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Select time',
                      border: OutlineInputBorder(),
                    ),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      return time == null ? null : DateTimeField.convert(time);
                    },
                    controller: _time,
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
                  'Resolve Comment:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                     enabled: widget.type == 'admin' ? true : false,
                    controller: resolve_comment,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      // hintText: 'Enter last name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
            SizedBox(height: 10.0),
                     Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Checkbox(
                      value: _isChecked, // Current value of the checkbox
                      onChanged: widget.type == "admin"? (bool? value) {
                        // Update the value of the checkbox when it's changed
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      }: null,
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Text(
                      'Resolved', // Label for the checkbox
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
          SizedBox(height: 30.0),
          if(widget.type == 'admin')...[
            ElevatedButton(
              onPressed: () {
                // print('Username: $selectedBranch, Password: $nic');
                _fetchUsers(resolve_comment.text, _isChecked, widget.data['id'], widget.userId);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Set button color to red
                minimumSize: Size(double.infinity, 40.0), // Set full width
              ),
              child: Text('Update Complaint'),
            ),
          ]
        ],
      ),
    );
  }

  void _fetchUsers(comment, checked, id, userId) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        "comment": comment,
        "checked": checked.toString(),
        "id": id,
        "userId": widget.userId
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.put(
        Uri.parse(updateComplaint),
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

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ComplaintList(
              userId: widget.userId,
              type: 'admin',
            );
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
