import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/ScanQR.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/admin/AdminAssignedItems.dart';
import 'package:flutter_p/pages/customer/CustomerAssignedItems.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JobDetailsPage extends StatelessWidget {
  final String type;
  final String userId;
  final dynamic data;
  const JobDetailsPage(
      {super.key, this.data, required this.userId, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == 'pending' ? 'Pending Job Details' : 'Job Details'),
        backgroundColor: Colors.red,
      ),
      body: BranchCreationForm(
        data: data,
        userId: userId,
        type: type,
      ),
      bottomNavigationBar: BottomNaviatiobBar(),
    );
  }
}

class BranchCreationForm extends StatefulWidget {
  final String type;
  final String userId;
  final dynamic data;
  const BranchCreationForm(
      {Key? key, this.data, required this.userId, required this.type})
      : super(key: key);

  @override
  _BranchCreationFormState createState() => _BranchCreationFormState();
}

class _BranchCreationFormState extends State<BranchCreationForm> {
  late TextEditingController _senderName = TextEditingController();
  late TextEditingController _senderAddressController = TextEditingController();
  late TextEditingController _senderContactNumberController =
      TextEditingController();
  late TextEditingController _senderEmailController = TextEditingController();

  late TextEditingController _reName = TextEditingController();
  late TextEditingController _reAddressController = TextEditingController();
  late TextEditingController _reContactNumberController =
      TextEditingController();
  late TextEditingController _reEmailController = TextEditingController();

  late TextEditingController _desController = TextEditingController();
  late TextEditingController _instructionController = TextEditingController();
  late TextEditingController _weightController = TextEditingController();
  late TextEditingController _hightController = TextEditingController();
  late TextEditingController _widthController = TextEditingController();
  late TextEditingController _lengthController = TextEditingController();
  late TextEditingController _currStatus = TextEditingController();

  String? statusTo;
  String? dispatchBranch;
  String? dispatchBranchName;
  String? assingPostman;

  bool isLoading = false;

  List<dynamic> branches = [];
  List<dynamic> postmans = [];
  List<dynamic> sequense = [];

  @override
  void initState() {
    super.initState();
    // Call the function to fetch admins when the widget initializes
    _senderName = TextEditingController(text: widget.data['sender_name']);
    _senderAddressController =
        TextEditingController(text: widget.data['sender_address']);
    _senderContactNumberController =
        TextEditingController(text: widget.data['sender_contact']);
    _reName = TextEditingController(text: widget.data['re_name']);
    _reAddressController =
        TextEditingController(text: widget.data['re_address']);
    _reContactNumberController =
        TextEditingController(text: widget.data['re_contact']);
    _desController = TextEditingController(text: widget.data['description']);
    _instructionController =
        TextEditingController(text: widget.data['instruction']);
    _currStatus = TextEditingController(text: widget.data['status']);
    _weightController = TextEditingController(text: widget.data['weight']);
    _senderEmailController =
        TextEditingController(text: widget.data['sender_email']);
    _reEmailController = TextEditingController(text: widget.data['re_email']);
    _fetchBranches(); // Call the function to fetch admins when the widget initializes
    _fetchPostmans(); // Call the function to fetch admins when the widget initializes
    if (widget.type == 'inquery') {
      _fetchSequense(widget.data['id']);
    }
  }

  Future<void> _fetchSequense(id) async {
    print('calling se');
    final response = await http.get(Uri.parse('$getSequenceByCustomerId/$id'));
    print(response.body);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json['data']);
      setState(() {
        sequense = json['data'];
      });
    } else {
      // If the server did not return a successful response, throw an error
      throw Exception('Failed to load admins');
    }
  }

  Future<void> _fetchBranches() async {
    print('calling');
    final response = await http.get(Uri.parse(allBranches));
    print(response.body);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json['results']);
      setState(() {
        branches = json['results'];
      });
    } else {
      // If the server did not return a successful response, throw an error
      throw Exception('Failed to load admins');
    }
  }

  Future<void> _fetchPostmans() async {
    String userId = widget.userId;
    print('calling postans');
    final response = await http.get(Uri.parse('$getPostmansByBranch/$userId'));
    print(response.body);
    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      print(json['data']);
      setState(() {
        postmans = json['data'];
      });
    } else {
      // If the server did not return a successful response, throw an error
      throw Exception('Failed to load admins');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), // Adjust padding as needed
      child: SingleChildScrollView(
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
                    'Sender Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _senderName,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter branch code',
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
                    'Sender Address:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _senderAddressController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter branch name',
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
                    'Sender Contact: ',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _senderContactNumberController,
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
                    'Reciver Name:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _reName,
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
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Reciver Address:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _reAddressController,
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
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Reciver Contact:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _reContactNumberController,
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
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120.0,
                  child: Text(
                    'Item Description:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _desController,
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
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _instructionController,
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
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _weightController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter contact number',
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
                    'Sender Email:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _senderEmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter contact number',
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
                    'Receiver Email:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: widget.type == 'customer-edit' ? true : false,
                      controller: _reEmailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        // hintText: 'Enter contact number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
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
                    'Current Status:',
                    style: TextStyle(fontSize: 12.0), // Decrease font size
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: SizedBox(
                    height: 30.0,
                    child: TextField(
                      enabled: false,
                      controller: _currStatus,
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
            SizedBox(height: 20.0),
            if (widget.type == "postman") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      'Change Status',
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
                              value: 'STARTING_DELIVERY',
                              child: Text('Staring Delivery'),
                            ),
                            DropdownMenuItem(
                              value: 'DELIVERED',
                              child: Text('Delivered'),
                            ),
                            DropdownMenuItem(
                              value: 'RECEIVER_NOT_FOUNT',
                              child: Text('Reciver Not Found'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              statusTo = value;
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
            ],
            if (widget.type == "postOfficer") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      'Change Status',
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
                              value: 'COLLECTED',
                              child: Text('Collected'),
                            ),
                            DropdownMenuItem(
                              value: 'DISPATCH',
                              child: Text('Dispatch'),
                            ),
                            DropdownMenuItem(
                              value: 'ASSIGNED_TO_POSTMAN',
                              child: Text('Assign To Postman'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              statusTo = value;
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
            ],
            SizedBox(height: 10.0),
            if (statusTo == "DISPATCH") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      'Dispatch To Branch',
                      style: TextStyle(fontSize: 12.0), // Decrease font size
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: SizedBox(
                        height: 30.0,
                        child: DropdownButtonFormField(
                          items: branches.map((admin) {
                            return DropdownMenuItem(
                              value: admin['id'],
                              child: Text(admin['branch_name']),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // print(value);
                            setState(() {
                              dispatchBranch = value as String?;
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
            ],
            SizedBox(height: 10.0),
            if (statusTo == "ASSIGNED_TO_POSTMAN") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      'Assign To Postman',
                      style: TextStyle(fontSize: 12.0), // Decrease font size
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: SizedBox(
                        height: 30.0,
                        child: DropdownButtonFormField(
                          items: postmans.map((admin) {
                            return DropdownMenuItem(
                              value: admin['id'],
                              child: Text(
                                  '${admin['firstname']} ${admin['lastname']}'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            // print(value);
                            setState(() {
                              assingPostman = value as String?;
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
            ],
            if (sequense.isNotEmpty && widget.type == 'inquery') ...[
              Text('Job Journey'),
              SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: sequense.length,
                itemBuilder: (context, index) {
                  final item = sequense[index];
                  DateTime dateTime = DateTime.parse(item['created_date']);
                  // Format the date and time
                  String formattedDate =
                      DateFormat.yMMMd().format(dateTime); // e.g., Apr 27, 2024
                  String formattedTime = DateFormat.Hms().format(dateTime);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text('Status: ${item['status']}'),
                      subtitle: Column(
                        children: [
                          Text('${item['description']}'),
                          Text('${formattedDate} at ${formattedTime}'),
                        ],
                      ),
                      // Add more details as needed
                    ),
                  );
                },
              ),
            ],
            SizedBox(height: 20.0),
            if (widget.type != 'inquery') ...[
              ElevatedButton(
                onPressed: () {
                  // Perform action on button press (e.g., create branch)
                  if (widget.type == 'customer-edit') {
                    _updateUsers(
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
                        widget.data['id'],
                        _currStatus.text);
                  } else if (widget.type == 'pending') {
                    print(widget.data);
                    _approvePending(widget.data['job']);
                  } else {
                    _fetchUsers(widget.data['id'], statusTo, dispatchBranch,
                        assingPostman);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red, // Set button color to red
                  minimumSize: Size(double.infinity, 40.0), // Set full width
                ),
                child: Text((widget.type == 'customer-edit' &&
                        widget.data['status'] != 'PENDING')
                    ? 'Send To Approval'
                    : widget.type == 'pending'
                        ? 'Approve Changes'
                        : 'Update Job Details'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _updateUsers(
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
      id,
      currentStatus) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        "senderName": senderName,
        "senderContactNumberController": senderContactNumberController,
        "senderAddressController": senderAddressController,
        "senderEmailController": senderEmailController,
        "reName": reName,
        "reAddressController": reAddressController,
        "reContactNumberController": reContactNumberController,
        "reEmailController": reEmailController,
        "desController": desController,
        "instructionController": instructionController,
        "weightController": weightController,
        "userId": widget.userId,
        "id": id,
        "currentStatus": currentStatus
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.put(
        Uri.parse(updateJob),
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
            return CustomerAssignedItems(
              userId: widget.userId,
              type: 'inquery',
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

  void _fetchUsers(id, statusTo, dispatchBranch, assingPostman) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, String> data = {
        'id': id,
        'statusTo': statusTo ?? '',
        'dispatchBranch': dispatchBranch ?? '',
        'assingPostman': assingPostman ?? '',
        'userId': widget.userId
      };

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.put(
        Uri.parse(updateJobStatus),
        headers: {
          "Content-Type": "application/json"
        }, // Set headers for JSON data
        body: body,
      );

      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);

      // Check if the response status code is successful
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        bool success = responseBody['success'];
        String message = responseBody['message'];

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 2));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ScanQRCode(userId: widget.userId, type: widget.type);
          }));
        } else {
          final snackBar = Message(message: message, type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
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

  void _approvePending(jobId) async {
    try {
      setState(() {
        isLoading = true;
      });
      print('fetching users');

      // Create a Map to hold the username and password
      Map<String, int> data = {'jobId': jobId};

      // Encode the data as JSON
      String body = json.encode(data);

      // Make the POST request with the username and password in the body
      final response = await http.put(
        Uri.parse(approveJob),
        headers: {
          "Content-Type": "application/json"
        }, // Set headers for JSON data
        body: body,
      );

      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);

      // Check if the response status code is successful
      if (response.statusCode == 200) {
        // Parse the response body as JSON
        bool success = responseBody['success'];
        String message = responseBody['message'];

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

          // await Future.delayed(Duration(seconds: 2));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AdminAssignedItems(userId: widget.userId, type: 'pending');
          }));
        } else {
          final snackBar = Message(message: message, type: "error");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        }
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
