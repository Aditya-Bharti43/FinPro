import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String iconPath;
  final Color amountColor;

  const ExpenseCard({
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Icon section with fixed dimensions
            Image.asset(
              iconPath,
              height: 50,
              width: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16),
            // Title and Subtitle section (Expanded to take available space)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
            ),
            const SizedBox(width: 16),
            // Amount and Date section (same layout as IncomeCard, with a minus sign)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      '-', // Minus sign for expense
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
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
      ),
    );
  }
}
