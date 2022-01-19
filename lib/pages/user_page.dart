import 'package:flutter/material.dart';
import 'package:future_builder2/model/user.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.urlAvatar),
              radius: 80,
            ),
            const SizedBox(height: 16),
            Text(
              user.username,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              user.email,
              style: const TextStyle(color: Colors.grey),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email sent to ${user.username}')));
              },
              child: const Text('Send email'),
            ),
          ],
        ),
      ),
    );
  }
}
