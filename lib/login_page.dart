import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String validUsername = "han";
  final String validPassword = "hanhan";
  String? errorMessage;

  void _login() {
    if (_usernameController.text == validUsername &&
        _passwordController.text == validPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid username or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 59, 167, 255), const Color.fromARGB(255, 208, 234, 255)], // Gradient colors
            begin: Alignment.topCenter, // Gradient starts from top
            end: Alignment.bottomCenter, // Gradient ends at bottom
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo
                  Image.asset(
                    'assets/images/logo.png', // Editable logo image
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 30),
                  // Username Field
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/user_icon.png', // Editable user icon
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/lock_icon.png', // Editable lock icon
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Error Message
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 20),
                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18),

   
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
