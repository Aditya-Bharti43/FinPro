import 'package:fin_pro_new/backend/auth_service.dart';
import 'package:fin_pro_new/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // function for checking the password validity

  Pair<bool, String> isPasswordValid(String password) {
    if (password.length < 6) return Pair(false, 'length');
    bool has_upper = false;
    bool has_lower = false;
    bool has_digit = false;
    bool hasSpecial = false;

    for (int i = 0; i < password.length; i++) {
      String char = password[i];

      if (char.contains(RegExp(r'[A-Z]'))) {
        has_upper = true;
      } else if (char.contains(RegExp(r'[a-z]'))) {
        has_lower = true;
      } else if (char.contains(RegExp(r'\d'))) {
        has_digit = true;
      }
      if (char.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecial = true;
      }
    }

    if (!has_upper) return Pair(false, 'upper');
    if (!has_lower) return Pair(false, 'lower');
    if (!has_digit) return Pair(false, 'digit');
    if (!hasSpecial) return Pair(false, 'special');

    return Pair(true, 'Passed all validations');
  }

  // logic for email validation basic
  bool isValidEmail(String email) {
    if (!email.contains('@') || !email.contains('.')) return false;

    int atIndex = email.indexOf('@');
    int dotIndex = email.lastIndexOf('.');

    // Basic rule: @ must be before ., and not at start or end
    if (atIndex < 1 || dotIndex < atIndex + 2 || dotIndex >= email.length - 1) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.4,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.tealAccent],
                  ).createShader(bounds),
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your email",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.33,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                style:TextStyle(color: Colors.white),
                controller: _emailController,
                
                decoration: InputDecoration(
                  hintText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ), // Border color and width
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.45,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your password",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),

          Positioned(
            top: screenHeight * 0.48,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                style:TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText:true,
                decoration: InputDecoration(
                  hintText: "Password",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ), // Border color and width
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // login button
          Positioned(
            top: screenHeight * 0.6,
            left: screenWidth * 0.2,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.6, screenHeight * 0.05),
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:
                  _isLoading
                      ? null
                      : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        // password should have one uppercase , one lowercase , one number and one special character

                        bool chck = isPasswordValid(password).first;
                        String str = isPasswordValid(password).second;

                        if (!chck) {
                          setState(() {
                            _isLoading=false;
                          });
                          String message =
                              {
                                'upper':
                                    'Password should contain at least one uppercase letter',
                                'lower':
                                    'Password should contain at least one lowercase letter',
                                'digit':
                                    'Password should contain at least one digit',
                                'special':
                                    'Password should contain at least one special character',
                                'length':
                                    'Password should be at least 6 characters long',
                              }[str] ??
                              'Invalid password';

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                          print(str);
                        }

                        bool val_email = isValidEmail(email);

                        if (!val_email) {
                          setState(() {
                            _isLoading=false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid email')),
                          );
                        }

                        if (chck && val_email) {
                          final userCredential = await _authService.login(
                            email,
                            password,
                          );

                          setState(() {
                            _isLoading = false;
                          });
                          if (userCredential != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          } else {
                            // Display error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Login failed. Please try again.',
                                ),
                              ),
                            );
                          }
                        }
                      },
              // onHover: ,
              child: ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: [Colors.orangeAccent, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // Loading Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              ),
            ),
        ],
      ),
    );
  }
}
