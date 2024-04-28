// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/admin/AdminDashboard.dart';
import 'package:flutter_p/pages/customer/CustomerCreation.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:flutter_p/pages/employee/PostOfficerDashboard.dart';
import 'package:flutter_p/pages/employee/PostmanDashboard.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(Login());
// }

class Login extends StatefulWidget {
  final String userType;

  const Login({
    Key? key,
    required this.userType,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false; // Add a boolean to track loading state

  // void toggleLoading() {
  //   setState(() {
  //     isLoading = !isLoading; // Toggle isLoading state
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // This will pop the current route and go back to the previous route
            },
          ),
          title: widget.userType == "superAdmin"
              ? const Text('Super Admin Login Page')
              : widget.userType == "admin"
                  ? const Text('Admin Login Page')
                  : widget.userType == "customer"
                      ? const Text('Customer Login Page')
                      : const Text('Employee Page'),
          backgroundColor: Colors.red, // Change app bar color to red
        ),
        body: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: LoginForm(
                  toggleLoading: () {
                    setState(() {
                      isLoading = !isLoading; // Toggle isLoading state
                    });
                  },
                  userType: widget.userType), // Your main content goes here
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
        bottomNavigationBar: const BottomNaviatiobBar(),
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
  final String userType;

// THE CONSTRUCTOR
  LoginForm({required this.toggleLoading, required this.userType});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  String? selectedOfficer;
  // Define a callback function to toggle loading state
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         if (widget.userType == "employee") ...[
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
                      onChanged: (value) {setState(() {
                        selectedOfficer = value;
                      });},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(4)),
                    )
                    // TextField(
                    //   controller: _branchController,
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.all(8.0),
                    //     hintText: 'Enter branch',
                    //     border: OutlineInputBorder(),
                    //   ),
                    // ),
                    ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
         ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                widget.userType == 'customer' ? 'E-mail: ' : 'Username: ',
                style: TextStyle(fontSize: 12.0), // Decrease font size
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 30.0,
                child: TextField(
                  controller: _usernameController,
                  //  maxLines: 3, // Allow the TextField to expand vertically
                  //   minLines: 2, // Set a minimum number of lines to start with
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                'Password: ',
                style: TextStyle(fontSize: 12.0), // Decrease font size
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 30.0,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implement login logic here
            String username = _usernameController.text;
            String password = _passwordController.text;
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //   return const SuperAdminDashboard();
            // }));
            print('Username: $username, Password: $password');
            _fetchUsers(
              username,
              password,
              selectedOfficer?? ''
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red, // Set button color to red
            minimumSize: Size(double.infinity, 40.0), // Set full width
          ),
          child: Text('Login'),
        ),
        SizedBox(height: 20.0),
        if (widget.userType == "customer") ...[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Login form widgets go here

              // "Don't have an account : Sign Up" message
              Text(
                'Don\'t have an account? ',
                style: TextStyle(fontSize: 16.0),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const CustomerCreationPage();
                  }));
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue, // Set button text color to blue
                  ),
                ),
              ),
            ],
          )
        ],
      ],
    );
  }

  void _fetchUsers(username, password,selectedOfficer) async {
    try {
      widget.toggleLoading();
      print('fetching users');
      print(widget.userType);

      // Create a Map to hold the username and password
      Map<String, String> data = {
        'username': username,
        'password': password,
        "type": widget.userType,
        "selectedOfficer": selectedOfficer
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.post(
        Uri.parse(login),
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
        

        if (!success) {
          final snackBar = Message(
              message: "Username or Password is Incorrect", type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          String userId = responseBody['id'];
          
          final snackBar =
              Message(message: "Successfully Logged In", type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          await Future.delayed(Duration(seconds: 1));

          final navigateTo = widget.userType == 'superAdmin'
              ? SuperAdminDashboard()
              : widget.userType == 'admin'
                  ? AdminDashboard(userId: userId)
                  : widget.userType == 'customer' ? CustomerDashboard(userId: userId) 
                  : selectedOfficer == 'postOfficer' ?
                    PostOfficerDashboard(userId: userId)
                  : PostmanDashboard(userId: userId);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return navigateTo;
          }));
        }
        // Now you can use the 'success' variable
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}');
      }

      // Handle the response here
      widget.toggleLoading();
    } catch (err) {
      print(err);
    }
  }
}