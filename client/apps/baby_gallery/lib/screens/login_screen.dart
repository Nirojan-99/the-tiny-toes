import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_gallery/components/c_error_message.dart';
import 'package:baby_gallery/components/c_label.dart';
import 'package:baby_gallery/components/c_button.dart';
import 'package:baby_gallery/services/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // Error messages
  String? _emailError;
  String? _passwordError;
  double invalidLoginHight = 0;
  // Handle login logic
  Future<void> _handleLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
      invalidLoginHight = 0;
    });
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    // Input validation
    if (email.isEmpty) {
      setState(() {
        _emailError = "Enter a valid username.";
      });
      return;
    }
    if (password.isEmpty) {
      setState(() {
        _passwordError = "Enter a valid password.";
      });
      return;
    }
    // Access the AuthProvider for login validation
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? error = authProvider.validateLogin(email, password);
    if (error == null) {
      Navigator.pushReplacementNamed(context, '/users');
    } else {
      setState(() {
        invalidLoginHight = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username Field
            CLabel("Username"),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                errorText: _emailError,
                hintText: "Enter your username",
                filled: true,
                fillColor: const Color(0xff4b576f),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            // Password Field
            CLabel("Password"),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                errorText: _passwordError,
                hintText: "Enter your password",
                filled: true,
                fillColor: const Color(0xff4b576f),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            // Login Button
            CButton("Login", _handleLogin),
            // Error Message
            ErrorMessage(invalidLoginHight, "Invalid Credentials"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
