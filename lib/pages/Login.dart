import 'package:flutter/material.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.red, // Change app bar color to red
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LoginForm(),
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
        ),
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                'Username: ',
                style: TextStyle(fontSize: 12.0), // Decrease font size
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 30.0,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter your username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 120.0,
              child: Text(
                'Password: ',
                style: TextStyle(fontSize: 12.0), // Decrease font size
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: SizedBox(
                height: 30.0,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Implement login logic here
            String username = _usernameController.text;
            String password = _passwordController.text;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const SuperAdminDashboard();
            }));
            print('Username: $username, Password: $password');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Set button color to red
            minimumSize: Size(double.infinity, 40.0), // Set full width
          ),
          child: Text('Login'),
        ),
      ],
    );
  }
}
