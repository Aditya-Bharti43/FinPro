import 'package:fin_pro_new/expense_screen.dart';
import 'package:fin_pro_new/income_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseRecords extends StatefulWidget {
  final List<Map<String, String>> expenseList;
  const ExpenseRecords({super.key, required this.expenseList});

  @override
  State<ExpenseRecords> createState() => _ExpenseRecordsState();
}

class _ExpenseRecordsState extends State<ExpenseRecords> {
  late List<Map<String, String>> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = List.from(widget.expenseList); // Make a mutable copy
  }

  void _deleteTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header
          SizedBox(height: screenHeight*0.05,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromARGB(255, 61, 57, 57),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Records',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  child: Card(
                    color: Colors.grey[900],
                    margin: EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.8,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Transactions',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Transaction List with Swipe-to-Delete
                          Expanded(
                            child: ListView.builder(
                              itemCount: _transactions.length,
                              itemBuilder: (context, index) {
                                final transaction = _transactions[index];

                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                                  ),
                                  onDismissed: (direction) {
                                    _deleteTransaction(index);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    child: transaction['type'] == 'income'
                                        ? IncomeCard(
                                            title: 'Income',
                                            subtitle: 'Income',
                                            amount: transaction['amount']!,
                                            date: transaction['date']!,
                                          )
                                        : ExpenseCard(
                                            title: transaction['category']!,
                                            subtitle: 'Expense',
                                            amount: transaction['amount']!,
                                            date: transaction['date']!,
                                            iconPath: transaction['iconpath']!,
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
