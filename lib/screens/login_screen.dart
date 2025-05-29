
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import '../main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();

  bool isObscure = true;
  bool rememberMe = false;

  void loginUser() async {
    try {
      User? user = await auth.login(
        emailCtrl.text.trim(),
        passCtrl.text.trim(),
      );

      if (user != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("✅ Login Successful")));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainNavigation(userId: user.uid), // ✅ Pass userId
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Login Failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Error: ${e.toString()}")));
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
              Image.asset('assets/images/logo.jpg', height: 100),
              SizedBox(height: 10),
              Text(
                'YOUR DOCTOR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(height: 20),
              Text(
                "Please Login To Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 30),

              // Email Input
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: "Please Enter Your Email or Number",
                  labelText: "Email/Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Password Input
              TextField(
                controller: passCtrl,
                obscureText: isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key_outlined),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => isObscure = !isObscure),
                  ),
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              SizedBox(height: 10),

              // Remember Me + Forgot Password
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (val) => setState(() => rememberMe = val!),
                  ),
                  Text("Remember Me"),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text("Forgot Password?"),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Login Button
              ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Login", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),

              // Divider
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

              // Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIcon(Icons.g_mobiledata),
                  SizedBox(width: 20),
                  _socialIcon(Icons.facebook),
                  SizedBox(width: 20),
                  _socialIcon(Icons.linked_camera),
                ],
              ),
              SizedBox(height: 20),

              // Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account?"),
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SignupScreen()),
                        ),
                    child: Text("SIGN UP"),
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
