import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IncomeCard(
          title: 'Income',
          subtitle: 'Income',
          amount: '545.00',
          date: 'Feb 9',
        ),
        IncomeCard(
          title: 'Income',
          subtitle: 'Income',
          amount: '999999999.00', // Large amount to test overflow
          date: 'Feb 9',
        ),
      ],
    );
  }
}

class IncomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final Color amountColor;

  const IncomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    this.amountColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 61, 57, 57),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Icon
            Image.asset(
              'assets/images/dollar_1.png',
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 16),
            // Title and Subtitle
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
                    overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                    maxLines: 1, // Ensure text stays on one line
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
            // Amount and Date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Amount
                Row(
                  children: [
                    Text(
                      '+',
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
                      overflow: TextOverflow.ellipsis, // Truncate if needed
                      maxLines: 1, // Ensure text stays on one line
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
      ),
    );
  }
}