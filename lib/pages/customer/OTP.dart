// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/customer/CustomerCreation.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(Login());
// }

class OTP extends StatefulWidget {
  final String userId;

  const OTP({
    Key? key,
    required this.userId,  
  }) : super(key: key);

  @override
  State<OTP> createState() => _LoginState();
}

class _LoginState extends State<OTP> {
  bool isLoading = false; // Add a boolean to track loading state

  // void toggleLoading() {
  //   setState(() {
  //     isLoading = !isLoading; // Toggle isLoading state
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // This will pop the current route and go back to the previous route
            },
          ),
          title: Text('OTP'),
          backgroundColor: Colors.red, // Change app bar color to red
        ),
        body: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: LoginForm(toggleLoading: () {
                setState(() {
                  isLoading = !isLoading; // Toggle isLoading state
                });
              },
              userId: widget.userId
              ), // Your main content goes here
            ),
            // Loading indicator (displayed above main content if isLoading is true)
            if (isLoading)
              Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent black color
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ), // Loading indicator
                ),
              ),
          ],
        ),
        bottomNavigationBar:  BottomNaviatiobBar(type: 'customer', userId: widget.userId),
      ),
    );
  }
}

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        color: Colors.red,
        // backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  // const LoginForm({Key? key}) : super(key: key);
  // final VoidCallback onFlatButtonPressed;

  // MyCustomWidget({@required this.onFlatButtonPressed});

  final Function toggleLoading;
  final String userId;

// THE CONSTRUCTOR
  LoginForm({required this.toggleLoading, required this.userId});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  // Define a callback function to toggle loading state
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                'OTP Recived For Email: ',
                style: TextStyle(fontSize: 12.0), // Decrease font size
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 30.0,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: '',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
       
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implement login logic here
            String otp = _usernameController.text;
            // }));
            _fetchUsers(
              otp
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red, // Set button color to red
            minimumSize: Size(double.infinity, 40.0), // Set full width
          ),
          child: Text('Submit'),
        ),
       
      ],
    );
  }

  void _fetchUsers(username) async {
    try {
      widget.toggleLoading();
      print('fetching users');
      print( widget.userId);

      // Create a Map to hold the username and password
      Map<String, String> data = {
        'otp': username,
        "id": widget.userId
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.post(
        Uri.parse(checkOTP),
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

        if (!success) {
          final snackBar = Message(
              message: message, type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {

          final snackBar =
              Message(message: message , type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return CustomerDashboard(userId: widget.userId);
          }));
        }

        // Now you can use the 'success' variable
        print('Success: $success');
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }

      // Handle the response here

      print('completed');
      widget.toggleLoading();
    } catch (err) {
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  }
}