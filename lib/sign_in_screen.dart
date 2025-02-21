import 'package:fin_pro_new/backend/auth_service.dart';
import 'package:fin_pro_new/dashboard.dart';
import 'package:fin_pro_new/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // "SignIn" Text
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.4,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.tealAccent],
                  ).createShader(bounds),
              child: Text(
                "SignIn",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // First Name and Last Name Fields
          Positioned(
            top: screenHeight * 0.2, // Position below "SignIn"
            left: screenWidth * 0.12, // Shift left by 12% of screen width
            child: Text(
              "Enter your full name",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),

          Positioned(
            top: screenHeight * 0.23,
            left: screenWidth * 0.10,
            child: // Small spacing between text and text field
                SizedBox(
              width: screenWidth * 0.8, // Adjust width to fit within the screen
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.35,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your email",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.38,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
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
            top: screenHeight * 0.49,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your password",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.52,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
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

          // SignIn Button
          Positioned(
            top: screenHeight * 0.64,
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

                        final userCredential = await _authService.signUp(
                          email,
                          password,
                        );

                        setState(() {
                          _isLoading = false;
                        });
                        if (userCredential != null) {
                          // Navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        } else {
                          /// Display error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Signup failed. Please try again.'),
                            ),
                          );
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
                  'SignIn',
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
