import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/components/JobDetails.dart';
import 'package:flutter_p/components/SnackBar.dart';
import 'package:flutter_p/pages/AdminUpdatePage.dart';
import 'package:http/http.dart' as http;

class AdminAssignedItems extends StatefulWidget {
  final String type;
  final String userId;
  const AdminAssignedItems(
      {super.key, required this.userId, required this.type});

  @override
  State<AdminAssignedItems> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<AdminAssignedItems> {
  late String userId;
  late String type;
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    type = widget.type;
    fetchUsers(userId,
        type); // Call the function to fetch admins when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items In the Branch'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          // shrinkWrap: true, // Add this line
          //   physics: NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final id = user['id'];
            // final image = user['picture']['thumbnail'];
            final status = user['status'];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                // leading: ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                // child: Image.network(image)),
                // CircleAvatar(child: Text('${index}')),
                title: Text('Job Id : $id'),
                subtitle: Text('Status : $status'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.type == 'view') ...[
                      ElevatedButton(
                        onPressed: () {
                          _getJobData(id, 'inquery');
                          // Navigate to the UpdateUserPage and pass user data as arguments
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => JobDetailsPage(userData: user),
                          // ));
                        },
                        child: Text('View'),
                      ),
                    ],
                    if (widget.type == 'pending') ...[
                      ElevatedButton(
                        onPressed: () {
                          _getJobData(id, 'inquery');
                          // Navigate to the UpdateUserPage and pass user data as arguments
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => JobDetailsPage(userData: user),
                          // ));
                        },
                        child: Text('View'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          _getJobData(id, 'pending');
                          // Navigate to the UpdateUserPage and pass user data as arguments
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => JobDetailsPage(userData: user),
                          // ));
                        },
                        child: Text('Pending'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  void fetchUsers(id, typea) async {
    print('fetching items');
    final url =( (type == 'pending')? '$getPendingJobsByAdmin/$id'  :  '$getJobsByAdmin/$id');
    print(url);
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
    print('completed');
  }

  void _getJobData(id, type) async {
    try {
      // Make the POST request with the username and password in the body
      final url = (type == 'pending'? '$getPendingJobById/$id' :  '$getJobById/$id');
      final response = await http.get(
        Uri.parse(url),
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

          // await Future.delayed(Duration(seconds: 1));

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return JobDetailsPage(
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
