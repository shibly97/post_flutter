import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:http/http.dart' as http;

class AdminCreationPage extends StatelessWidget {
  const AdminCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Admin'),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(),
      bottomNavigationBar: BottomNaviatiobBar(type: 'super-admin', userId: ''),
    );
  }
}



class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool isLoading = false;

  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? selectedBranch;
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  List<dynamic> users = [];
  String? selectedAdmin;

      @override
  void initState() {
    super.initState();
    _fetchBranch(); // Call the function to fetch admins when the widget initializes
  }

  Future<void> _fetchBranch() async {
    final response = await http.get(Uri.parse(allBranches));
    print(response.body);
    if (response.statusCode == 200) {
       final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          users = json['results'];
        });
    } else {
      // If the server did not return a successful response, throw an error
      throw Exception('Failed to load admins');
    }
  }

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
                      hintText: 'Staff ID',
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
                  // height: 30.0,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Branch:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                    height: 30.0,
                    child: DropdownButtonFormField(
                       items: users.map((admin) {
                      return DropdownMenuItem(
                        value: admin['id'],
                        child: Text(admin['branch_name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // print(value);
                      setState(() {
                        selectedBranch = value as String?;
                      });
                    },
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
          // SizedBox(height: 10.0),
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     SizedBox(
          //       width: 120.0,
          //       child: Text(
          //         'Postal/Zip Code:',
          //         style: TextStyle(fontSize: 12.0), // Decrease font size
          //       ),
          //     ),
          //     SizedBox(width: 10.0),
          //     Expanded(
          //       child: SizedBox(
          //         height: 30.0,
          //         child: TextField(
          //           controller: _postalCodeController,
          //           decoration: InputDecoration(
          //             contentPadding: EdgeInsets.all(8.0),
          //             hintText: 'Enter postal/zip code',
          //             border: OutlineInputBorder(),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
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
              // String staffId = _staffIdController.text;
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
              _fetchUsers(
                  userName,
                  password,
                  // staffId, 
                  fistName,
                  lastName,
                  email,
                  // zip,
                  contact,
                  nic,
                  selectedBranch
                );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Set button color to red
              minimumSize: Size(double.infinity, 40.0), // Set full width
            ),
            child: Text('Create Admin'),
          ),
        ],
      ),
    );
  }

  void _fetchUsers(
    userName,
    password,
    // staffId, 
    fistName,
    lastName,
    email,
    // zip,
    contact,
    nic,
    selectedBranch
  ) async {
    try{
      setState(() {
        isLoading = true;
      });
  print('fetching users');
    
    

    // Create a Map to hold the username and password
    Map<String, String> data = {
      'userName': userName,
      'password': password,
      // 'staffId':staffId , 
      "fistName": fistName,
      "lastName": lastName,
      "email": email,
      // "zip": zip,
      "contact": contact,
      "nic": nic,
      "selectedBranch": selectedBranch
    };

    // Encode the data as JSON
    String body = json.encode(data);

    // Make the POST request with the username and password in the body
    final response = await http.post(
      Uri.parse(createAdmin),
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

          await Future.delayed(Duration(seconds: 2));

          Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const SuperAdminDashboard();
            }));
        } else {
          final snackBar = Message(message: message, type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }

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
    }
    catch(err){
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  
  }
}
