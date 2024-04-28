import 'package:flutter/material.dart';
import 'package:flutter_p/pages/StartingPage.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:flutter_p/pages/admin/AdminDashboard.dart';
import 'package:flutter_p/pages/customer/CustomerDashboard.dart';
import 'package:flutter_p/pages/employee/PostOfficerDashboard.dart';
import 'package:flutter_p/pages/employee/PostmanDashboard.dart';

class BottomNaviatiobBar extends StatelessWidget {
  final String type;
  final String userId;
  const BottomNaviatiobBar({
    super.key, required this.type, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
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
        BottomNavigationBarItem(
          label: '',
          icon: Icon(
            Icons.notification_add_rounded,
            color: Colors.white,
          ),
        )
      ],
      backgroundColor: Colors.red,
      currentIndex: 0,
      onTap: (int value) {
        // Handle navigation here
         switch (value) {
          case 0:
            // Navigator.pushNamed(context, '/'); // Navigate to the first screen
            break;
          case 1:
             Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                      if(type == 'super-admin'){
                        return const SuperAdminDashboard();
                      }
                      if(type == 'admin'){
                        return AdminDashboard(userId: userId);
                      }
                       if(type == 'customer'){
                        return CustomerDashboard(userId: userId);
                      }
                       if(type == 'post-officer'){
                        return PostOfficerDashboard(userId: userId);
                      }else if(type == 'postman'){
                        return PostmanDashboard(userId: userId);      
                      }
                  return const StartingPage();
                })); // Navigate to the second screen
            break;
          // Add cases for more items if needed
        }
      },
    );
  }
}