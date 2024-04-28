import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/admin/UpdateUsers.dart';
import 'package:http/http.dart' as http;

class UserUpdatePage extends StatelessWidget {
  final String userId;
  final dynamic userData;

  const UserUpdatePage({Key? key, required this.userData, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Users'),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(
        userData: userData,
        userId: userId,
      ),
      bottomNavigationBar: BottomNaviatiobBar(type: 'admin', userId: userId),
    );
  }
}

class LoginForm extends StatefulWidget {
  // const LoginForm({Key? key}) : super(key: key);
  final String userId;
  final dynamic userData;

  LoginForm({required this.userData, required this.userId});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;

  late TextEditingController _staffIdController = TextEditingController();
  late TextEditingController _firstNameController = TextEditingController();
  late TextEditingController _lastNameController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  String? selectedBranch;
  late TextEditingController _postalCodeController = TextEditingController();
  late TextEditingController _contactNumberController = TextEditingController();
  late TextEditingController _nicController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _userNameController = TextEditingController();
  String? selectedOfficer;

  @override
  void initState() {
    super.initState();
    _staffIdController = TextEditingController(text: widget.userData['id']);
    _firstNameController =
        TextEditingController(text: widget.userData['firstname']);
    _lastNameController =
        TextEditingController(text: widget.userData['lastname']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _userNameController =
        TextEditingController(text: widget.userData['user_name']);
    _passwordController =
        TextEditingController(text: widget.userData['password']);
    _nicController = TextEditingController(text: widget.userData['nic']);
    _postalCodeController = TextEditingController(text: widget.userData['zip']);
    _contactNumberController =
        TextEditingController(text: widget.userData['contact']);
    // _postalCodeController =
    //     TextEditingController(text: widget.userData['zip']);
    setState(() {
      selectedOfficer =  widget.userData['type'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Employee Type:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                      height: 30.0,
                      child: DropdownButtonFormField(
                        value: selectedOfficer,
                        // disabledHint: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'postOfficer',
                            child: Text('Post Officer'),
                          ),
                          DropdownMenuItem(
                            value: 'postman',
                            child: Text('Postman'),
                          ),
                        ],
                       onChanged: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(4)),
                      )),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Staff ID:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: false,
                      controller: _staffIdController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter staff ID',
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
                    'First Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter first name',
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
                    'Last Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter last name',
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
                    'Username:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter username',
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
                    'Password:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter password',
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
                    'Email:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SizedBox(
            //       width: 120.0,
            //       child: Text(
            //         'Branch:',
            //         style: TextStyle(fontSize: 12.0), // Decrease font size
            //       ),
            //     ),
            //     SizedBox(width: 10.0),
            //     Expanded(
            //       child: SizedBox(
            //           height: 30.0,
            //           child: DropdownButtonFormField(
            //             items: const [
            //               DropdownMenuItem(
            //                 value: 'Kandy',
            //                 child: Text('Kandy - Main Branch'),
            //               ),
            //               DropdownMenuItem(
            //                 value: 'Colombo',
            //                 child: Text('Colombo - Bambalapitiya'),
            //               ),
            //             ],
            //             onChanged: (value) {setState(() {
            //               selectedBranch = value;
            //             });},
            //             decoration: InputDecoration(
            //                 border: OutlineInputBorder(),
            //                 contentPadding: EdgeInsets.all(4)),
            //           )
            //           // TextField(
            //           //   controller: _branchController,
            //           //   decoration: InputDecoration(
            //           //     contentPadding: EdgeInsets.all(8.0),
            //           //     hintText: 'Enter branch',
            //           //     border: OutlineInputBorder(),
            //           //   ),
            //           // ),
            //           ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Postal/Zip Code:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _postalCodeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter postal/zip code',
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
                    'Contact Number',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _contactNumberController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter Contact Number',
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
                    'NIC',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _nicController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        hintText: 'Enter NIC',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
                String staffId = _staffIdController.text;
                String userName = _userNameController.text;
                String password = _passwordController.text;
                String fistName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String email = _emailController.text;
                String zip = _postalCodeController.text;
                String contact = _contactNumberController.text;
                String nic = _nicController.text;
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return const SuperAdminDashboard();
                // }));
                // print('Username: $selectedBranch, Password: $nic');
                _fetchUsers(userName, password, staffId, fistName, lastName,
                    email, zip, contact, nic, selectedOfficer, 
                    // selectedBranch
                    );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Set button color to red
                minimumSize: Size(double.infinity, 40.0), // Set full width
              ),
              child: Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchUsers(
    userName,
    password,
    staffId,
    fistName,
    lastName,
    email,
    zip,
    contact,
    nic,
    officer
    // selectedBranch
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        'userName': userName,
        'password': password,
        'staffId': staffId,
        "fistName": fistName,
        "lastName": lastName,
        "email": email,
        "zip": zip,
        "contact": contact,
        "nic": nic,
        "officer": officer,
        // "selectedBranch": selectedBranch
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.put(
        Uri.parse(updateUser),
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
            return UpdateUsers(userId: widget.userId);
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
