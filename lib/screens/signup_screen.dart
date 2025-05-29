import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();
  bool isObscure = true;

  void registerUser() async {
    var user = await auth.signUp(emailCtrl.text.trim(), passCtrl.text.trim());
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Sign-Up Successful")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Sign-Up Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text('Create New Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              SizedBox(height: 10),
              Text("Please Login To Your Account",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[800])),

              SizedBox(height: 30),

              // User Name
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: "Enter Your Name",
                  labelText: "User Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),

              // Password
              TextField(
                controller: passCtrl,
                obscureText: isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => isObscure = !isObscure),
                  ),
                  hintText: "Create a Password",
                  labelText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),

              // Email/Phone
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Enter Your Email / Number",
                  labelText: "Email/Phone",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text("Sign Up", style: TextStyle(fontSize: 18)),
              ),

              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(Icons.g_mobiledata), // Google
                  SizedBox(width: 20),
                  _socialIcon(Icons.facebook), // Facebook
                  SizedBox(width: 20),
                  _socialIcon(Icons.linked_camera), // LinkedIn (can customize icon)
                ],
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("LOGIN"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return CircleAvatar(
      backgroundColor: Colors.grey[300],
      radius: 25,
      child: Icon(icon, size: 30, color: Colors.teal),
    );
  }
}
