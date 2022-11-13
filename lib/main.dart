import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinehouse/Screens/Screen1.dart';
import 'package:pinehouse/Screens/Screen2.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PineHouse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final screens = [
    Screen1(),
    Screen2()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Screen 1",
          backgroundColor: Colors.red
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Screen 2',
          backgroundColor: Colors.orange
        )
      ],
      onTap: (index) => setState(() {
        _currentIndex = index;
      }) ,
      ),
    );
  }
}