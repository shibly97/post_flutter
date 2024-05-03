import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:http/http.dart' as http;

class BranchCreationPage extends StatelessWidget {
  const BranchCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Branch'),
        backgroundColor: Colors.red,
      ),
      body: BranchCreationForm(),
      bottomNavigationBar: BottomNaviatiobBar(type: 'super-admin', userId: ''),
    );
  }
}

class BranchCreationForm extends StatefulWidget {
  const BranchCreationForm({Key? key}) : super(key: key);

  @override
  _BranchCreationFormState createState() => _BranchCreationFormState();
}

class _BranchCreationFormState extends State<BranchCreationForm> {
  final TextEditingController _branchCodeController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  // List<Map<String, dynamic>> admins = [];
  // String? selectedAdmin;
  String? selectedProvince;
  String? selectedDistrict;

   bool isLoading = false;

  List<dynamic> users = [];

    @override
  void initState() {
    super.initState();
    _fetchAdmins(); // Call the function to fetch admins when the widget initializes
  }

  Future<void> _fetchAdmins() async {
    print('calling');
    final response = await http.get(Uri.parse(getAllAdmin));
    print(response.body);
    if (response.statusCode == 200) {
       final body = response.body;
        final json = jsonDecode(body);
        setState(() {
          users = json['results'];
        });
      // If the server returns a successful response, parse the JSON
      // final Map<String, dynamic> responseData = json.decode(response.body);
      // if (responseData['success']) {
      //   setState(() {
      //     // Clear the list and add new admins
      //     admins.clear();
      //     admins.addAll(responseData['admins']);
      //   });
      // } else {
      //   // Handle the case when the server response indicates failure
      //   throw Exception('Failed to load admins: ${responseData['message']}');
      // }
    } else {
      // If the server did not return a successful response, throw an error
      throw Exception('Failed to load admins');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Adjust padding as needed
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
                  'Branch Code:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _branchCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter branch code',
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
                  'Branch Name:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _branchNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter branch name',
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
                  'Address:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  // height: 30.0,
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter address',
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
                  'Contact Number:',
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
                      hintText: 'Enter contact number',
                      border: OutlineInputBorder(),
                    ),
                  ),
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
          //         'Admin:',
          //         style: TextStyle(fontSize: 12.0), // Decrease font size
          //       ),
          //     ),
          //     SizedBox(width: 10.0),
          //     Expanded(
          //       child: SizedBox(
          //           height: 30.0,
          //           child: DropdownButtonFormField(
          //              items: users.map((admin) {
          //             return DropdownMenuItem(
          //               value: admin['id'],
          //               child: Text(admin['user_name']),
          //             );
          //           }).toList(),
          //           onChanged: (value) {
          //             // print(value);
          //             setState(() {
          //               selectedAdmin = value as String?;
          //             });
          //           },
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
           SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Province:',
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
                          value: 'Central',
                          child: Text('Central'),
                        ),
                        DropdownMenuItem(
                          value: 'Western',
                          child: Text('Western'),
                        ),
                        DropdownMenuItem(
                          value: 'Uwa',
                          child: Text('Uwa'),
                        ),
                        DropdownMenuItem(
                          value: 'North',
                          child: Text('North'),
                        ),
                      ],
                      onChanged: (value) {setState(() {
                        selectedProvince = value;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 120.0,
                child: Text(
                  'Destrict:',
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
                          value: 'Kandy',
                          child: Text('Kandy'),
                        ),
                        DropdownMenuItem(
                          value: 'Mathale',
                          child: Text('Mathale'),
                        ),
                        DropdownMenuItem(
                          value: 'Nuwaraeliya',
                          child: Text('Nuwaraeliya'),
                        ),
                        DropdownMenuItem(
                          value: 'Colombo',
                          child: Text('Colombo'),
                        ),
                      ],
                      onChanged: (value) {setState(() {
                        selectedDistrict = value;
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
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Perform action on button press (e.g., create branch)
               _fetchUsers(
                  _branchCodeController.text,
                  _branchNameController.text,
                  _addressController.text, 
                  _contactNumberController.text,
                  // selectedAdmin,
                  selectedProvince,
                  selectedDistrict
                );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red, // Set button color to red
              minimumSize: Size(double.infinity, 40.0), // Set full width
            ),
            child: Text('Create Branch'),
          ),
        ],
      ),
    );
  }

    void _fetchUsers(
    branchCode,
    branchName,
    address,
    contact,
    // selectedAdmin,
    selectedProvince,
    selectedDistrict
  ) async {
    try{
      setState(() {
        isLoading = true;
      });
  print('fetching users');

    // Create a Map to hold the username and password
    Map<String, String> data = {
      'branchCode': branchCode,
      'branchName': branchName,
      'address':address , 
      "contact": contact,
      // "selectedAdmin": selectedAdmin,
      "selectedProvince": selectedProvince,
      "selectedDistrict": selectedDistrict,
    };

    // Encode the data as JSON
    String body = json.encode(data);

    // Make the POST request with the username and password in the body
    final response = await http.post(
      Uri.parse(addBranch),
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

          await Future.delayed(Duration(seconds: 1));

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
