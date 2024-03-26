import 'package:flutter/material.dart';

class AdminCreationPage extends StatelessWidget {
  const AdminCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Admin'),
        backgroundColor: Colors.red,
      ),
      body: LoginForm(),
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
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                  'Staff ID:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _staffIdController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter staff ID',
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
                  'First Name:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter first name',
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
                  'Last Name:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter last name',
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
                  'Email:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter email',
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
                  'Branch:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _branchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter branch',
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
                  'Postal/Zip Code:',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter postal/zip code',
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
                  'Contact Number',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter Contact Number',
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
                  'NIC',
                  style: TextStyle(fontSize: 12.0), // Decrease font size
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 30.0,
                  child: TextField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Enter NIC',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Implement login logic here
              String username = _staffIdController.text;
              String password = _passwordController.text;
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (BuildContext context) {
              //   return const SuperAdminDashboard();
              // }));
              print('Username: $username, Password: $password');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Set button color to red
              minimumSize: Size(double.infinity, 40.0), // Set full width
            ),
            child: Text('Create Admin'),
          ),
        ],
      ),
    );
  }
}
