import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateBranch extends StatefulWidget {
  const UpdateBranch({super.key});

  @override
  State<UpdateBranch> createState() => _UpdateBranchState();
}

class _UpdateBranchState extends State<UpdateBranch> {
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
        title: const Text('Test API'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['email'];
            // final image = user['picture']['thumbnail'];
            final name = user['firstname'];
            return ListTile(
              // leading: ClipRRect(
              //   borderRadius: BorderRadius.circular(100),
              // child: Image.network(image)),
              // CircleAvatar(child: Text('${index}')),
              title: Text(email),
              subtitle: Text(name)
            );
          }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: fetchUsers,
      // ),
    );
  }

  void fetchUsers() async {
    print('fetching users');
    const url = 'http://192.168.0.101:8080/api/users/get/allAdmin';
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