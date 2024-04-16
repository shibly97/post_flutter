import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_p/Utils/API/API.dart';
import 'package:flutter_p/pages/AdminUpdatePage.dart';
import 'package:flutter_p/pages/BranchUpdatePage.dart';
import 'package:http/http.dart' as http;

class UpdateBranch extends StatefulWidget {
  const UpdateBranch({super.key});

  @override
  State<UpdateBranch> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateBranch> {
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
        title: const Text('Update Branch'),
         backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user['branch_name'];
            // final image = user['picture']['thumbnail'];
            final name = user['branch_code'];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                // leading: ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                // child: Image.network(image)),
                // CircleAvatar(child: Text('${index}')),
                title: Text('Branch : $email'),
                subtitle: Text('Code : $name'),
                 trailing: ElevatedButton(
                onPressed: () {
                    // Navigate to the UpdateUserPage and pass user data as arguments
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BranchUpdatePage(userData: user),
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
    const url = allBranches;
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