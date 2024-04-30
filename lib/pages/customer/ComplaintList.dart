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

class ComplaintList extends StatefulWidget {
  final String type;
  final String userId;
  const ComplaintList({super.key, required this.userId, required this.type});

  @override
  State<ComplaintList> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<ComplaintList> {
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
        title: const Text('Complaints'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          if(type != "admin")...[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ComplaintCreation(userId: widget.userId);
                }));
                // Functionality for the "Create New" button
                // For example, navigate to the create new page
              },
              child: Text('Create New'),
            ),

          ],
          Expanded(
            child: ListView.builder(
                // shrinkWrap: true, // Add this line
                //   physics: NeverScrollableScrollPhysics(),

                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final id = user['id'];
                  // final image = user['picture']['thumbnail'];
                  final status = (user['resolved'] == true ? 'Resolved': 'Not Resolved');
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      // leading: ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      // child: Image.network(image)),
                      // CircleAvatar(child: Text('${index}')),
                      title: Text('Complaint Id : $id'),
                      subtitle: Text('Status : $status'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            ElevatedButton(
                              onPressed: () {
                                _getComplaintData(id, type == 'admin'? 'admin' : 'inquery');
                                // Navigate to the UpdateUserPage and pass user data as arguments
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => JobDetailsPage(userData: user),
                                // ));
                              },
                              child: Text(type == 'admin'? 'Update' : 'View'),
                            ),
                            SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  void fetchUsers(id, type) async {
    print('fetching items');
    final url = type == 'admin'? '$getComplaintByAdmin/$id' : '$getComplaintByCustomer/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['data'];
    });
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
