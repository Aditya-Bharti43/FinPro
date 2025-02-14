import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCardEntertain extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String iconPath;
  final Color amountColor;

  const ExpenseCardEntertain({ 
    
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
            const SizedBox(width: 20),
            // Title and subtitle section: expands to use available space
            Expanded(
              flex: 3,
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
                  const SizedBox(height: 4),
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
            const SizedBox(width: 15),
            // Amount and date section: flexible to avoid overflow
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Amount row
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                      Flexible(
                        child: Text(
                          amount,
                          style: GoogleFonts.poppins(
                            color: amountColor,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Date text
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
