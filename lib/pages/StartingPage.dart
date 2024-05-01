import 'package:flutter/material.dart';
import 'package:flutter_p/components/QRScanner.dart';
import 'package:flutter_p/pages/AdminCreationPage.dart';
import 'package:flutter_p/pages/BranchCreationPage.dart';
import 'package:flutter_p/pages/Login.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartingPage',
      home: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Dashboard'),
          //   backgroundColor: Colors.red,
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Navigator.pop(
          //           context); // This will pop the current route and go back to the previous route
          //     },
          //   ),
          // ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            // child: Text("Helloo"),
            child: DashboardCards(),
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   items: const [
          //     BottomNavigationBarItem(
          //       label: 'Back',
          //       icon: Icon(
          //         Icons.arrow_back,
          //         color: Colors.white,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Home',
          //       icon: Icon(
          //         Icons.home,
          //         color: Colors.white,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Add',
          //       icon: Icon(
          //         Icons.add,
          //         color: Colors.white,
          //       ),
          //     )
          //   ],
          //   backgroundColor: Colors.red,
          //   currentIndex: 0,
          //   onTap: (int value) {
          //     // Handle navigation here
          //   },
          // )
          ),
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
  const DashboardCards({super.key});

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
              title: 'Super Admin',
              icon: Icons.person_add,
              imagePath: 'images/super.png',
              onPressed: () {
                // Action to perform when Create Admin Accounts card is pressed
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return  Login(userType: 'superAdmin');
                }));
              },
            ),
            DashboardCard(
              title: 'Postal Master',
              icon: Icons.person,
              imagePath: 'images/admin.png',
              onPressed: () {
                // Action to perform when Update Admin Accounts card is pressed
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return  Login(userType: 'admin');
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
              title: 'Customer',
              imagePath: 'images/customer.png',
              icon: Icons.add_location,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return  Login(userType: 'customer');
                  // return  QRScanner();
                }));
                // Action to perform when Create Branches card is pressed
              },
            ),
            DashboardCard(
              title: 'Staff',
              imagePath: 'images/staff.png',
              icon: Icons.update,
              onPressed: () {
                // Action to perform when Update Branches card is pressed
                  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return  Login(userType: 'employee');
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
    required this.imagePath,
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
