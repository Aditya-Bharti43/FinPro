import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayBalanceScreen extends StatefulWidget {
  final String balance;
  final bool col_or;
  const DisplayBalanceScreen({
    super.key,
    required this.balance,
    required this.col_or,
  });

  @override
  State<DisplayBalanceScreen> createState() => _DisplayBalanceScreenState();
}

class _DisplayBalanceScreenState extends State<DisplayBalanceScreen> {
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
                    'Your balance is:',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${widget.balance}',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: widget.col_or ? Colors.green : Colors.red,
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
