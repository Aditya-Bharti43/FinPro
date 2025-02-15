import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              shaderCallback: (bounds) => LinearGradient(
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
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white,
              ),
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
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
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
              "Enter your username",
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
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2), // Border color and width
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue, width: 2), // Border when focused
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
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 2), // Border color and width
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue, width: 2), // Border when focused
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.64,
            left: screenWidth * 0.2,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.6, screenHeight * 0.05),
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              // onHover: ,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
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
        ],
      ),
    );
  }
}
