import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayExpenseScreen extends StatefulWidget {
  final String expense;
  const DisplayExpenseScreen({super.key,required this.expense});

  @override
  State<DisplayExpenseScreen> createState() => _DisplayExpenseScreenState();
}

class _DisplayExpenseScreenState extends State<DisplayExpenseScreen> {
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
                    'Your expense is:',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    '${widget.expense}',
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