import 'package:fin_pro_new/add_income_screen.dart';
import 'package:fin_pro_new/dashboard.dart';
import 'package:fin_pro_new/expense_bar_cahrt.dart';
import 'package:fin_pro_new/expense_card_edu.dart';
import 'package:fin_pro_new/expense_card_entertain.dart';
import 'package:fin_pro_new/expense_card_food.dart';
import 'package:fin_pro_new/expense_card_health.dart';
import 'package:fin_pro_new/expense_card_misc.dart';
import 'package:fin_pro_new/expense_records.dart';
import 'package:fin_pro_new/firebase_options.dart';
import 'package:fin_pro_new/income_screen.dart';
import 'package:fin_pro_new/just_check_screen.dart';
import 'package:fin_pro_new/landing_page.dart';
import 'package:fin_pro_new/login_screen.dart';
import 'package:fin_pro_new/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinPro',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LandingPage()
      // home: LoginScreen(),
      // home: SignInScreen(),
      // home: Dashboard(),
      // home: AddIncomeScreen(),
      // home:ExpenseCardFood()
      // home: ExpenseCardEdu(),
      // home: ExpenseCardEntertain(),
      // home: ExpenseCardHealth(),
      // home: ExpenseCardMisc(),
      // home: IncomeScreen(),
      // home: JustCheckScreen(),
      // home: ExpenseRecords(),
      // home:ExpenseBarChart()
      


    );
  }
}
