import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APICalling extends StatefulWidget {
  const APICalling({super.key});

  @override
  State<APICalling> createState() => _APICallingState();
}

class _APICallingState extends State<APICalling> {
  List<dynamic> users = [];

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
            final image = user['picture']['thumbnail'];
            final name = user['name']['first'];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
              child: Image.network(image)),
              // CircleAvatar(child: Text('${index}')),
              title: Text(email),
              subtitle: Text(name)
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async {
    print('fetching users');
    const url = 'https://randomuser.me/api/?results=50';
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
