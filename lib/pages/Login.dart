// ignore_for_file: empty_catches

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_p/pages/SuperAdminDashboard.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isLoading = false; // Add a boolean to track loading state

  // void toggleLoading() {
  //   setState(() {
  //     isLoading = !isLoading; // Toggle isLoading state
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // This will pop the current route and go back to the previous route
            },
          ),
          title: const Text('Login Page'),
          backgroundColor: Colors.red, // Change app bar color to red
        ),
        body: Stack(
          children: [
            // Main content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: LoginForm(toggleLoading : (){
                 setState(() {
                  isLoading = !isLoading; // Toggle isLoading state
                });
              }), // Your main content goes here
            ),
            // Loading indicator (displayed above main content if isLoading is true)
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5), // Semi-transparent black color
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ), // Loading indicator
                ),
              ),
          ],
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

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        color: Colors.red,
        // backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  // const LoginForm({Key? key}) : super(key: key);
  // final VoidCallback onFlatButtonPressed;

  // MyCustomWidget({@required this.onFlatButtonPressed});

  final Function toggleLoading;

// THE CONSTRUCTOR
  LoginForm({
    required this.toggleLoading
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

    // Define a callback function to toggle loading state
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
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //   return const SuperAdminDashboard();
            // }));
            print('Username: $username, Password: $password');
            _fetchUsers(username, password, );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red, // Set button color to red
            minimumSize: Size(double.infinity, 40.0), // Set full width
          ),
          
          child: Text('Login'),
        ),
      ],
    );
  }

  void _fetchUsers(username, password) async {
    try{
      widget.toggleLoading();
  print('fetching users');
    
    const url = 'http://192.168.0.101:8080/api/auth/login';

    // Create a Map to hold the username and password
    Map<String, String> data = {
      'username': username,
      'password': password,
    };

    // Encode the data as JSON
    String body = json.encode(data);

    // Make the POST request with the username and password in the body
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json"
      }, // Set headers for JSON data
      body: body,
    );

    print(response.body);

    final responseBody = response.body;

    // Check if the response status code is successful
    if (response.statusCode == 200) {
      // Parse the response body as JSON
      Map<String, dynamic> responseBody = json.decode(response.body);
      
      // Access the 'success' variable from the parsed JSON
      bool success = responseBody['success'];

      if(!success){
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 147, 29, 20),
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              // const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Error",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text("Username or Password is Incorrect"),
                  ],
                ),
              ),
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
      }else{
          Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const SuperAdminDashboard();
            }));
      }
      
      // Now you can use the 'success' variable
      print('Success: $success');
    } else {
      // Handle error response
      print('Request failed with status: ${response.statusCode}');
    }


    // Handle the response here

    print('completed');
    widget.toggleLoading();
    }
    catch(err){
      print(err);
    }
    // setState(() {
    //   // isLoading = true
    // });
    // toggleLoading();
  
  }
}

class name extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ET extends StatefulWidget {

  @override
  State<ET> createState() => _ETState();
}

class _ETState extends State<ET> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
