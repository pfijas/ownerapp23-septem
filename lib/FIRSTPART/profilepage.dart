import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'Editprofile.dart';
import 'loginpage.dart';

class profilepg extends StatefulWidget {
  const profilepg({Key? key}) : super(key: key);

  @override
  State<profilepg> createState() => _profilepgState();
}

class _profilepgState extends State<profilepg> {
  String _name = "admin"; // Declare _name here
  String _selectedLanguage = "English"; // Initialize with the default language

  @override
  void initState() {
    super.initState();
    _loadName(); // Load the user's name from SharedPreferences when the widget initializes
  }

  // Function to load the user's name from SharedPreferences
  void _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "admin";
    });
  }

  // Function to save the user's name to SharedPreferences
  void _saveName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
  }

  // Function to change the selected language
  void _changeLanguage(String newLanguage) {
    setState(() {
      _selectedLanguage = newLanguage;
      // You can implement language change logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.grey,
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [
          SizedBox(height: 16),
          Text(
            _name, // Use _name here
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Row(
              children: [
                Text('Language'),
                Spacer(),
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _changeLanguage(newValue);
                    }
                  },
                  items: <String>['English', 'Arabic'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () async {
              Map<String, dynamic>? updatedProfile = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    currentName: _name, // Pass the current name here
                  ),
                ),
              );

              if (updatedProfile != null) {
                setState(() {
                  // Update the profile details if they were changed
                  String newName = updatedProfile['name'];
                  _name = newName;
                  _saveName(
                      newName); // Save the updated name to SharedPreferences
                });
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
