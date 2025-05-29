import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  final dummyName = "John Doe";
  final dummyEmail = "johndoe@example.com";

  void logoutUser() async {
    await AuthService().logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Profile"), backgroundColor: Colors.teal),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, color: Colors.white, size: 50),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              dummyName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Center(child: Text(dummyEmail, style: TextStyle(color: Colors.grey))),
          SizedBox(height: 30),

          // Change Password
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Change Password tapped")));
            },
          ),

          Divider(),

          // Dark Mode Toggle
          SwitchListTile(
            secondary: Icon(Icons.dark_mode),
            title: Text("Dark Mode"),
            value: isDarkMode,
            onChanged: (val) {
              setState(() => isDarkMode = val);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    val ? "Dark Mode Enabled" : "Light Mode Enabled",
                  ),
                ),
              );
            },
          ),

          Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: logoutUser,
          ),
        ],
      ),
    );
  }
}
