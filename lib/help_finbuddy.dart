import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: ShaderMask(
          shaderCallback:
              (bounds) => LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
              ).createShader(bounds),
          blendMode: BlendMode.srcIn,
          child: Text('Ask Finbuddy', style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w500)),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildQuestionTile(
            question: '1. About the App',
            answer:
                'This app is a personal finance manager that helps you track your income and expenses. You can add, delete, and view transactions easily.',
          ),
          _buildQuestionTile(
            question: '2. How to Get Started',
            answer:
                'To get started, navigate to the Dashboard and add your first income or expense transaction. You can view your transactions and balance on the Dashboard.',
          ),
          _buildQuestionTile(
            question: '3. How to Add/Delete Transactions',
            answer:
                'To add a transaction, go to the Dashboard and click on "Add Transaction". To delete a transaction, swipe left on the transaction in the list and confirm the deletion.',
          ),
          _buildQuestionTile(
            question: '3. How to view transaction history',
            answer:
                'To view your transaction history, go to the Dashboard and click on "View Transactions". You can see a list of all your transactions with details like date, category, and amount.',
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile({
    required String question,
    required String answer,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(answer, style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
