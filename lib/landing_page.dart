import 'package:fin_pro_new/login_screen.dart';
import 'package:fin_pro_new/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Positioned(
          top: screenHeight * 0.1,
          left: screenWidth * 0.34,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(colors: [Colors.blueAccent, Colors.tealAccent]).createShader(bounds),
            child: Text(
              'FinPro',
              style: GoogleFonts.poppins(
                  fontSize: 32, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
        // buttons Login,signin
        Positioned(
          top: screenHeight * 0.6,
          left: screenWidth * 0.05,
          child: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.9, screenHeight * 0.05),
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            // onHover: ,
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
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
        Positioned(
          top: screenHeight * 0.68,
          left: screenWidth * 0.05,
          child: TextButton(
            style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.9, screenHeight * 0.05),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: Colors.white, width: 2)),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.orangeAccent, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'Sign In',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.2,
          left: screenWidth * 0.2,
          child: SizedBox(
            width: screenWidth * 0.7, // Adjust the width as needed
            child: Text(
              "The only app you need to ",
              style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
              softWrap: true, // Ensures text wraps to the next line
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.23,
          left: screenWidth * 0.2,
          child: SizedBox(
            width: screenWidth * 0.7, // Adjust the width as needed
            child: Text(
              "keep expenses tracked!! ",
              style: GoogleFonts.poppins(fontSize: 17, color: Colors.white),
              softWrap: true, // Ensures text wraps to the next line
            ),
          ),
        ),
      ]),
    );
  }
}
