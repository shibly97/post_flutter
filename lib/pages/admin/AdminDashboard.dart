import 'package:flutter/material.dart';
import 'package:flutter_p/pages/AdminCreationPage.dart';
import 'package:flutter_p/pages/BranchCreationPage.dart';
import 'package:flutter_p/pages/UpdateAdmin.dart';
import 'package:flutter_p/pages/UpdateBranch.dart';

class AdminDashboard extends StatelessWidget {

   final String userId;
  
  const AdminDashboard({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdminDashboard',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Dashboard'),
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
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: 'Back',
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Add',
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
            backgroundColor: Colors.red,
            currentIndex: 0,
            onTap: (int value) {
              // Handle navigation here
            },
          )),
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
              title: 'Create Job',
              icon: Icons.person_add,
              onPressed: () {
                // Action to perform when Create Admin Accounts card is pressed
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AdminCreationPage();
                }));
              },
            ),
            DashboardCard(
              title: 'Rete Us',
              icon: Icons.person,
              onPressed: () {
                // Action to perform when Update Admin Accounts card is pressed
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return UpdateAdmin();
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
              title: 'Inquery',
              icon: Icons.add_location,
              onPressed: () {
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return BranchCreationPage();
                }));
                // Action to perform when Create Branches card is pressed
              },
            ),
            DashboardCard(
              title: 'Complains',
              icon: Icons.update,
              onPressed: () {
                // Action to perform when Update Branches card is pressed
                 Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return UpdateBranch();
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
