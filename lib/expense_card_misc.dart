import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCardMisc extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String iconPath;
  final Color amountColor;

  const ExpenseCardMisc({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.iconPath,
    this.amountColor = Colors.red, // Default color for expense
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 61, 57, 57),
      child: Row(
        children: [
          // Icon
          Image.asset(
            iconPath,
            height: 50,
            width: 50,
          ),
          const SizedBox(width: 50),
          // Main heading (title and subtitle)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(width: 70),
          // Amount and date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Amount
              Row(
                children: [
                  Text(
                    '-', // Negative sign for expense
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: amountColor,
                    ),
                  ),
                  Icon(
                    Icons.currency_rupee_sharp,
                    size: 20,
                    color: amountColor,
                  ),
                  Text(
                    amount,
                    style: GoogleFonts.poppins(
                      color: amountColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              // Date
              Opacity(
                opacity: 0.5,
                child: Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}