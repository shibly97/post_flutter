import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/GenerateQR.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/customer/OTP.dart';
import 'package:http/http.dart' as http;

class CreateJobs extends StatelessWidget {
  final String userId;
  const CreateJobs({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Jobs'),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(userId: userId),
      bottomNavigationBar: BottomNaviatiobBar(),
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

  final TextEditingController _senderName = TextEditingController();
  final TextEditingController _senderAddressController = TextEditingController();
  final TextEditingController _senderContactNumberController =
      TextEditingController();
  final TextEditingController _senderEmailController = TextEditingController();

    final TextEditingController _reName = TextEditingController();
  final TextEditingController _reAddressController = TextEditingController();
  final TextEditingController _reContactNumberController =
      TextEditingController();
  final TextEditingController _reEmailController = TextEditingController();

  final TextEditingController _desController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _hightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();

  int step = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (step == 0) ...[
            Text(
              'Sender Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _senderName,
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
                    height: 30.0,
                    child: TextField(
                      controller: _senderAddressController,
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
                    'Contact Number:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _senderContactNumberController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
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
                      controller: _senderEmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter email',
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
            //             // hintText: 'Enter postal/zip code',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
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
            //         'NIC',
            //         style: TextStyle(fontSize: 12.0), // Decrease font size
            //       ),
            //     ),
            //     SizedBox(width: 10.0),
            //     Expanded(
            //       child: SizedBox(
            //         height: 30.0,
            //         child: TextField(
            //           controller: _nicController,
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.all(8.0),
            //             hintText: 'Enter NIC',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Login form widgets go here

                // "Don't have an account : Sign Up" message

                TextButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (BuildContext context) {
                    //   return const CustomerCreationPage();
                    // }));
                    setState(() {
                      step = 1;
                    });
                  },
                  child: Text(
                    'Add Receiver\'s Details',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue, // Set button text color to blue
                    ),
                  ),
                ),
              ],
            )
          ],
          if (step == 1) ...[
            Text(
              'Receiver Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _reName,
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
                    height: 30.0,
                    child: TextField(
                      controller: _reAddressController,
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
                    'Contact Number:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _reContactNumberController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
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
                      controller: _reEmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter email',
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
            //             // hintText: 'Enter postal/zip code',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 10.0),
            // SizedBox(height: 10.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SizedBox(
            //       width: 120.0,
            //       child: Text(
            //         'NIC',
            //         style: TextStyle(fontSize: 12.0), // Decrease font size
            //       ),
            //     ),
            //     SizedBox(width: 10.0),
            //     Expanded(
            //       child: SizedBox(
            //         height: 30.0,
            //         child: TextField(
            //           controller: _nicController,
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.all(8.0),
            //             hintText: 'Enter NIC',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 20.0),
                        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Login form widgets go here

                // "Don't have an account : Sign Up" message

                TextButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (BuildContext context) {
                    //   return const CustomerCreationPage();
                    // }));
                    setState(() {
                      step = 0;
                    });
                  },
                  child: Text(
                    'Back To sender\'s Details',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue, // Set button text color to blue
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Login form widgets go here

                // "Don't have an account : Sign Up" message

                TextButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (BuildContext context) {
                    //   return const CustomerCreationPage();
                    // }));
                    setState(() {
                      step = 2;
                    });
                  },
                  child: Text(
                    'Add item Details',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue, // Set button text color to blue
                    ),
                  ),
                ),
              ],
            )
          ],
          if (step == 2) ...[
            Text(
              'Item Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Description of Content:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _desController,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Instruction:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _instructionController,
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
                    'Weight:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
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
                    'Length',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _lengthController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter email',
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
                    'Height',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _hightController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter email',
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
                    'Width',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      controller: _widthController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter email',
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
            //             // hintText: 'Enter postal/zip code',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
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
            //         'Contact Number',
            //         style: TextStyle(fontSize: 12.0), // Decrease font size
            //       ),
            //     ),
            //     SizedBox(width: 10.0),
            //     Expanded(
            //       child: SizedBox(
            //         height: 30.0,
            //         child: TextField(
            //           controller: _reContactNumberController,
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.all(8.0),
            //             // hintText: 'Enter Contact Number',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
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
            //         'NIC',
            //         style: TextStyle(fontSize: 12.0), // Decrease font size
            //       ),
            //     ),
            //     SizedBox(width: 10.0),
            //     Expanded(
            //       child: SizedBox(
            //         height: 30.0,
            //         child: TextField(
            //           controller: _nicController,
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.all(8.0),
            //             hintText: 'Enter NIC',
            //             border: OutlineInputBorder(),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 30.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Login form widgets go here

                // "Don't have an account : Sign Up" message

                TextButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (BuildContext context) {
                    //   return const CustomerCreationPage();
                    // }));
                    setState(() {
                      step = 1;
                    });
                  },
                  child: Text(
                    'Back To Receiver\'s Details',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue, // Set button text color to blue
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Implement login logic here
                // String staffId = _staffIdController.text;
                // String userName = _userNameController.text;
                // String password = _passwordController.text;
                // String fistName = _firstNameController.text;
                // // String lastName = _lastNameController.text;
                // String email = _emailController.text;
                // String zip = _postalCodeController.text;
                // String contact = _contactNumberController.text;
                // String nic = _nicController.text;
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (BuildContext context) {
                //   return const SuperAdminDashboard();
                // }));
                // print('Username: $selectedBranch, Password: $nic');
                _fetchUsers(
                    _senderName.text,
                    _senderAddressController.text,
                    _senderContactNumberController.text,
                    _senderEmailController.text,
                    _reName.text,
                    _reAddressController.text,
                    _reContactNumberController.text,
                    _reEmailController.text,
                    _desController.text,
                    _instructionController.text,
                    _weightController.text,
                    _hightController.text,
                    _lengthController.text
                  );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red, // Set button color to red
                minimumSize: Size(double.infinity, 40.0), // Set full width
              ),
              child: Text('Submit and Generate QR Code'),
            ),
          ],
        ],
      ),
    );
  }

  void _fetchUsers(
    senderName,
    senderContactNumberController,
    senderAddressController,
    senderEmailController,
    reName,
    reAddressController,
    reContactNumberController,
    reEmailController,
    desController,
    instructionController,
    weightController,
    hightController,
    lengthController
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        "senderName": senderName,
        "senderContactNumberController":     senderContactNumberController,
        "senderAddressController":     senderAddressController,
        "senderEmailController":     senderEmailController,
        "reName":     reName,
        "reAddressController":     reAddressController,
        "reContactNumberController":     reContactNumberController,
        "reEmailController":     reEmailController,
        "desController":     desController,
        "instructionController":     instructionController,
        "weightController":     weightController,
        "hightController":     hightController,
        "lengthController":     lengthController,
        "userId": widget.userId      
        };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.post(
        Uri.parse(createJob),
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
          final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return QRCodeWidget(id: jobId, userId: widget.userId);
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
