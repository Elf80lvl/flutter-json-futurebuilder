import 'package:flutter/material.dart';
import 'package:future_builder2/api/users_api.dart';
import 'package:future_builder2/model/user.dart';
import 'package:future_builder2/pages/user_page.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: UsersApi.getUsers(),
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
      // floatingActionButton: FloatingActionButton.large(
      //   onPressed: () async {
      //     await UsersApi.getUsers();

      //   },
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UserPage(user: user))),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.urlAvatar),
          ),
          title: Text(user.username),
          subtitle: Text(user.email),
        );
      });
}
