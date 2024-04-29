import 'package:flutter/material.dart';
import 'package:flutter_p/components/BottomNavigationBar.dart';
import 'package:flutter_p/pages/AdminCreationPage.dart';
import 'package:flutter_p/pages/BranchCreationPage.dart';
import 'package:flutter_p/pages/UpdateAdmin.dart';
import 'package:flutter_p/pages/UpdateBranch.dart';
import 'package:flutter_p/pages/customer/ComplaintList.dart';
import 'package:flutter_p/pages/customer/CustomerAssignedItems.dart';
import 'package:flutter_p/pages/customer/createJobs.dart';

class CustomerDashboard extends StatelessWidget {

   final String userId;
  
  const CustomerDashboard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomerDashboard',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Customer Dashboard'),
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
          bottomNavigationBar: BottomNaviatiobBar(type: 'customer', userId: userId)),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardCard(
              title: 'Register Items',
              icon: Icons.person_add,
              imagePath: 'images/register items.png',
              onPressed: () {
                // Action to perform when Create Admin Accounts card is pressed
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CreateJobs(userId: userId);
                }));
              },
            ),
            DashboardCard(
              title: 'Rate Us',
              icon: Icons.person,
              imagePath: 'images/Rate-Us.png',
              onPressed: () {
                // Action to perform when Update Admin Accounts card is pressed
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                   return CustomerAssignedItems(userId: userId, type: 'rate',);
                }));
              },
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashboardCard(
              title: 'View Item\'s Journey',
              icon: Icons.add_location,
              imagePath: 'images/ViewItems.png',
              onPressed: () {
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return CustomerAssignedItems(userId: userId, type: 'inquery',);
                }));
                // Action to perform when Create Branches card is pressed
              },
            ),
            DashboardCard(
              title: 'Complaints',
              icon: Icons.update,
               imagePath: 'images/complaints.png',
              onPressed: () {
                // Action to perform when Update Branches card is pressed
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ComplaintList(userId: userId, type: 'complain',);
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
  final String imagePath;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.imagePath,
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
              Image.asset(
                imagePath,
                width: 80.0,
                height: 80.0,
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
