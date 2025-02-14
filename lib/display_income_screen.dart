import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayIncomeScreen extends StatefulWidget {
  final String income;
  const DisplayIncomeScreen({super.key, required this.income});

  @override
  State<DisplayIncomeScreen> createState() => _DisplayIncomeScreenState();
}

class _DisplayIncomeScreenState extends State<DisplayIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
          ),
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.2,
            child: Expanded(
              child: Column(
                children: [
                  Text(
                    'Your income is:',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '${widget.income}',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
