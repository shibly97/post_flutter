import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/pages/AdminUpdatePage.dart';
import 'package:http/http.dart' as http;

class UpdateAdmin extends StatefulWidget {
  const UpdateAdmin({super.key});

  @override
  State<UpdateAdmin> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateAdmin> {
  List<dynamic> users = [];

      @override
  void initState() {
    super.initState();
    fetchUsers(); // Call the function to fetch admins when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Admin'),
         backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            // final image = user['picture']['thumbnail'];
            final name = user['user_name'];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                // leading: ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                // child: Image.network(image)),
                // CircleAvatar(child: Text('${index}')),
                title: Text('Username : $name'),
                subtitle: Text('Email : $email'),
                 trailing: ElevatedButton(
                onPressed: () {
                    // Navigate to the UpdateUserPage and pass user data as arguments
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminUpdatePage(userData: user),
                    ));

                },
                child: Text('Edit'),
              ),
              ),
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  void fetchUsers() async {
    print('fetching users');
    const url = getAllAdmin;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print('completed');
  }
}