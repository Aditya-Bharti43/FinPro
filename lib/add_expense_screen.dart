import 'package:fin_pro_new/just_check_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  @override
  TextEditingController _txt_controller = TextEditingController();
  String? _selectedCategory; // Store selected category
  Map<String, String> mpp = {
    'Food': 'assets/images/food_1.png',
    'Education': 'assets/images/edu_1.png',
    'Entertainment': 'assets/images/entertain_1.png',
    'Health': 'assets/images/health_1.png',
    'Miscellaneous': 'assets/images/misc_1.png'
  };

  Widget build(BuildContext context) {
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
                "Add Expense",
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
                   
                    if (_txt_controller.text.isNotEmpty &&
                        _selectedCategory != null) {
                      Navigator.pop(context, {
                        'amount': _txt_controller.text,
                        'category': _selectedCategory,
                        'iconpath':mpp[_selectedCategory]

                      });
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    size: 40,
                    color: (_txt_controller.text.isNotEmpty &&
                            _selectedCategory != null)
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: screenHeight * 0.8,
            left: screenWidth * 0.3,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: SizedBox(
                width: screenWidth * 0.5, // Give it a constrained width
                child: DropdownButton<String>(
                  value: _selectedCategory, // The selected value
                  hint: Text('Select category'),
                  isExpanded: true, // Prevents UI overflow
                  items: <String>[
                    'Food',
                    'Education',
                    'Entertainment',
                    'Health',
                    'Miscellaneous'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory =
                          newValue; // Update the selected category
                    });
                  },
                ),
              ),
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
                controller: _txt_controller,
                style: TextStyle(fontSize: 90), // Larger text size
                decoration: InputDecoration(
                  // hintText: 'Enter amount',
                  hintText: '0 INR',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // onChanged: (_) => setState(() {}),
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
