import 'package:fin_pro_new/landing_page.dart';
import 'package:fin_pro_new/login_screen.dart';
import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}



class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  void initState(){
    super.initState();
       // Simulate a loading delay (e.g., 3 seconds)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FinPro starting up..",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: LinearProgressIndicator(
                color: Colors.tealAccent,
                backgroundColor: Colors.white24,
                minHeight: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
