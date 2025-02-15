import 'package:fin_pro_new/income_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _form_controller = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.3,
            child: ShaderMask(
              shaderCallback:(bounds)=>LinearGradient(
                colors: [Colors.blueAccent,Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Text(
                "Add Income",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),

          
          // 01.// cross and tick buttons for creating or discarding records
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.02,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.67,
                ),
                IconButton(
                  onPressed: () {
                    if(_form_controller.text.isNotEmpty)
                    {
                      Navigator.pop(context,_form_controller.text);
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          //for income
          // textfield for entering amount
          Positioned(
            top: screenHeight * 0.4,
            left: screenWidth * 0.13,
            child: SizedBox(
              height: screenHeight * 0.3,
              width: screenWidth * 0.7,
              child: TextFormField(
                controller: _form_controller,

                style: TextStyle(fontSize: 90), // Larger text size
                decoration: InputDecoration(
                  // hintText: 'Enter amount',
                  hintText: '0 INR',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          )
          //
          //
        ],
      ),
    );
  }
}
