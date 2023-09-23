import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FIRSTPART/loginpage.dart';
import 'FIRSTPART/profilepage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _name = "admin";
  String _selectedLanguage = "English";

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "admin";
    });
  }

  void _saveName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // Set the initial locale
      home: LoginPage(),
    );
  }
}
