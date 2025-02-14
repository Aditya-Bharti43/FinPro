// import 'package:fin_pro/expense_card_edu.dart';
// import 'package:fin_pro/expense_card_entertain.dart';
// import 'package:fin_pro/expense_card_food.dart';
// import 'package:fin_pro/expense_card_health.dart';
// import 'package:fin_pro/expense_card_misc.dart';
// import 'package:flutter/material.dart';
// import 'package:fin_pro/income_screen.dart'; // Ensure the correct import path

// class JustCheckScreen extends StatefulWidget {
//   const JustCheckScreen({super.key});

//   @override
//   State<JustCheckScreen> createState() => _JustCheckScreenState();
// }

// class _JustCheckScreenState extends State<JustCheckScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         children: [

//           SizedBox(height: 20,),
//           // Add other widgets here if needed
//            IncomeScreen(),
//           // ExpenseCardEdu(title: 'Education',subtitle: 'Expense',amount: '545.00',date: 'Feb9',iconPath: 'assets/images/edu_1.png',),
//            IncomeScreen(),
//           ExpenseCardEntertain(title: 'Entertainment', subtitle: 'Expense', amount: '545.00', date: 'Feb9', iconPath: 'assets/images/entertain_1.png'),
//           ExpenseCardFood(title: 'Food', subtitle: 'Expense', amount:'545.00', date: 'Feb9', iconPath: 'assets/images/food_1.png'),
//            IncomeScreen(),
//           ExpenseCardHealth(title: 'Health', subtitle: 'Expense', amount: '545.00', date: 'Feb9', iconPath: 'assets/images/health_1.png'),
//           ExpenseCardMisc(title: 'Misc.', subtitle: 'Expense', amount: '545.00', date: 'Feb9', iconPath: 'assets/images/misc_1.png'),
        
//           IncomeScreen(),
//         ],
//       ),
//     );
//   }
// }