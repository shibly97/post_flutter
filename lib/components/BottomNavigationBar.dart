import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/pages/StartingPage.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/admin/AdminDashboard.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:flutter_p/pages/customer/NotificationPage.dart';
import 'package:flutter_p/pages/employee/PostOfficerDashboard.dart';
import 'package:flutter_p/pages/employee/PostmanDashboard.dart';
import 'package:http/http.dart' as http;

class BottomNaviatiobBar extends StatefulWidget {
  final String type;
  final String userId;

  const BottomNaviatiobBar({
    super.key,
    required this.type,
    required this.userId,
  });

  @override
  State<BottomNaviatiobBar> createState() => _BottomNaviatiobBarState();
}

class _BottomNaviatiobBarState extends State<BottomNaviatiobBar> {
  int notificationCount = 0;
  List<dynamic> notification = [];

  void initState() {
    super.initState();
    // Call the function to fetch notifications when the widget is initialized
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    // Make API call to fetch notifications
    // For example:
    // final response = await yourAPIService.getNotifications();
    // Parse the response and extract notifications
    // final notifications = response.data['notifications'];
    // Update the notification count
    // setState(() {
    //   notificationCount = notifications.length;
    // });
    // Dummy implementation:
    print('fetching items');
    if (widget.type == 'customer') {
      String userId = widget.userId;
      final url = '$customerNotifications/$userId';
      print(url);
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      setState(() {
        notification = json['data'];
        notificationCount = notification.length; // Sample notification count
      });
      print('completed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.accessibility_sharp,
            color: Colors.white,
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        // BottomNavigationBarItem(
        //   label: '',
        //   icon: Icon(
        //     Icons.notification_add_rounded,
        //     color: Colors.white,
        //   ),
        // )
        BottomNavigationBarItem(
          label: '',
          icon: Stack(
            children: [
              Icon(
                Icons.notification_add_rounded,
                color: Colors.white,
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$notificationCount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.red,
      currentIndex: 0,
      onTap: (int value) {
        // Handle navigation here
        switch (value) {
          case 0:
            // Navigator.pushNamed(context, '/'); // Navigate to the first screen
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Perform logout action here
                        // For example, navigate to the login screen
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const StartingPage();
                        }));
                      },
                      child: Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                  ],
                );
              },
            );
            break;
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              if (widget.type == 'super-admin') {
                return const SuperAdminDashboard();
              }
              if (widget.type == 'admin') {
                return AdminDashboard(userId: widget.userId);
              }
              if (widget.type == 'customer') {
                return CustomerDashboard(userId: widget.userId);
              }
              if (widget.type == 'post-officer') {
                return PostOfficerDashboard(userId: widget.userId);
              } else if (widget.type == 'postman') {
                return PostmanDashboard(userId: widget.userId);
              }
              return const StartingPage();
            })); // Navigate to the second screen
            break;
          // Add cases for more items if needed
          case 2:
            if (notificationCount > 0) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationPage(
                  userId: widget.userId,
                  type: widget.type,
                );
              }));
            }
        }
      },
    );
  }
}
