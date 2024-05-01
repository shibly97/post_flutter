import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/components/ComplaintDetails.dart';
import 'package:flutter_p/components/JobDetails.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/AdminUpdatePage.dart';
import 'package:flutter_p/pages/customer/COmplaintCreation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  final String type;
  final String userId;
  const NotificationPage({super.key, required this.userId, required this.type});

  @override
  State<NotificationPage> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<NotificationPage> {
  late String userId;
  late String type;
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    type = widget.type;
    fetchNotifications(userId); // Call the function to fetch admins when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final item = users[index];
                    DateTime dateTime = DateTime.parse(item['created_date']);
                    // Format the date and time
                    String formattedDate = DateFormat.yMMMd()
                        .format(dateTime); // e.g., Apr 27, 2024
                    String formattedTime = DateFormat.Hms().format(dateTime);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        // title: Text('Status: ${item['status']}'),
                        subtitle: Column(
                          children: [
                            Text('${item['description']}'),
                             SizedBox(height: 8.0),
                            Text('${formattedDate} at ${formattedTime}'),
                          ],
                        ),
                        // Add more details as needed
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  void fetchNotifications(id) async {
    print('fetching items');
    final url = '$customerNotifications/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    maskAsReadNotifications(id);
    print('completed');
  }

    void maskAsReadNotifications(id) async {
    print('mark items');
    final url = '$markAsReadNotifications/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri);
    // final body = response.body;
    // final json = jsonDecode(body);
    // setState(() {
    //   users = json['data'];
    // });
    print('completed');
  }

  void _getComplaintData(id, type) async {
    try {
      // Make the POST request with the username and password in the body
      final response = await http.get(
        Uri.parse('$getComplaintById/$id'),
        headers: {"Content-Type": "application/json"},
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
        Map<String, dynamic> data = responseBody['data'];

        if (success) {
          // final String jobId = responseBody['id'];
          final snackBar = Message(message: message, type: "success");

          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);

            print(data);

          // await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ComplaintDetails(
              data: data,
              userId: widget.userId,
              type: type,
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
      // setState(() {
      //   isLoading = false;
      // });
    } catch (err) {
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  }
}
