import 'package:api/model/user.dart';
import 'package:flutter/material.dart';

import '../services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rest API Tutorial"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.email;

            return ListTile(
              title: Text(user.fullName),
              subtitle: Text(user.phone),
              // tileColor: color,
            );
          }),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserAPI.fetchUser();
    setState(() {
      users = response;
    });
  }
}
