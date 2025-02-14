import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpenseCard(
          title: 'Expense',
          subtitle: 'Education', // Example category
          amount: '300.00',
          date: 'Feb 9',
          iconPath: 'assets/images/education.png', // Example icon
        ),
      ],
    );
  }
}

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
    this.amountColor = Colors.red, // Default color for expenses
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 61, 57, 57),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Icon
            Image.asset(
              iconPath,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 30),
            // Title and category
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            // Amount and date
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Amount
                Row(
                  children: [
                    Text(
                      '-',
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
