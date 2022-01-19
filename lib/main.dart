import 'package:flutter/material.dart';
import 'package:future_builder2/pages/local.dart';
import 'package:future_builder2/pages/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.red),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final screens = [
    const LocalPage(),
    const NetworkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.storage), label: 'Local'),
            NavigationDestination(icon: Icon(Icons.public), label: 'Network'),
          ],
        ),
      ),
    );
  }
}
