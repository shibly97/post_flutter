import 'package:flutter/material.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/pages/AdminCreationPage.dart';
import 'package:flutter_p/pages/BranchCreationPage.dart';
import 'package:flutter_p/pages/UpdateAdmin.dart';
import 'package:flutter_p/pages/UpdateBranch.dart';
import 'package:flutter_p/pages/admin/CreateUsers.dart';
import 'package:flutter_p/pages/admin/UpdateUsers.dart';

class AdminUserDashboard extends StatelessWidget {

   final String userId;
  
  const AdminUserDashboard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdminUserDashboard',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Admin User Dashboard'),
            backgroundColor: Colors.red,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context); // This will pop the current route and go back to the previous route
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            // child: Text("Helloo"),
            child: DashboardCards(userId: userId),
          ),
          bottomNavigationBar: BottomNaviatiobBar(type: 'admin', userId: userId)),
    );
  }
}

// class SupAdminDashboard extends StatelessWidget {
//   const SupAdminDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dashboard',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dashboard'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: DashboardCards(),
//         ),
//       ),
//     );
//   }
// }

class DashboardCards extends StatelessWidget {

  final String userId;

  const DashboardCards({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardCard(
              title: 'Create Users',
              icon: Icons.add_location,
              onPressed: () {
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CreateUsers(userId: userId,);
                }));
                // Action to perform when Create Branches card is pressed
              },
            ),
            DashboardCard(
              title: 'Edit Users',
              icon: Icons.update,
              onPressed: () {
                // Action to perform when Update Branches card is pressed
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return UpdateUsers(userId: userId,);
                }));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 3.0,
        child: Container(
          width: 160.0,
          height: 170.0,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
              ),
              SizedBox(height: 10.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
