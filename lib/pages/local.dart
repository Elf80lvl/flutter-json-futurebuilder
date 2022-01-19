import 'package:flutter/material.dart';
import 'package:future_builder2/api/users_api.dart';
import 'package:future_builder2/model/user.dart';

class LocalPage extends StatefulWidget {
  const LocalPage({Key? key}) : super(key: key);

  @override
  _LocalPageState createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: UsersApi.getUsersLocally(context),
        builder: (context, snapshot) {
          final users = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return buildUsers(users!);
              }
          }
        },
      ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.urlAvatar),
          ),
          title: Text(user.username),
          subtitle: Text(user.email),
        );
      });
}
