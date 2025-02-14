import 'package:fin_pro_new/add_expense_screen.dart';
import 'package:fin_pro_new/add_income_screen.dart';
import 'package:fin_pro_new/doughnut_chart_example.dart';
import 'package:fin_pro_new/expense_card_edu.dart';
import 'package:fin_pro_new/expense_records.dart';
import 'package:fin_pro_new/expense_screen.dart';
import 'package:fin_pro_new/income_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? _selectedMainCategory;
  bool _showTranscationDropdown = false;
  List<Map<String, String>> transactions = []; // List to store the transactions
  // double income=0;
  double getTotalIncome() {
    return transactions
        .where((transaction) => transaction['type'] == 'income')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0.0, (sum, amount) => sum + amount);
  }

  double getTotalExpense() {
    return transactions
        .where((transaction) => transaction['type'] == 'expense')
        .map((transaction) => double.parse(transaction['amount']!))
        .fold(0.0, (sum, amount) => sum + amount);
  }

  // Get category-wise expenses
  Map<String, double> getCategoryExpenses() {
    Map<String, double> categoryExpenses = {};
    for (var transaction in transactions) {
      if (transaction['type'] == 'expense') {
        String category = transaction['category']!;
        double amount = double.parse(transaction['amount']!);
        categoryExpenses[category] = (categoryExpenses[category] ?? 0) + amount;
      }
    }
    return categoryExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    String formattedIncome = NumberFormat.currency(
      symbol: '₹',
    ).format(getTotalIncome());
    String formattedExpense = NumberFormat.currency(
      symbol: '₹',
    ).format(getTotalExpense());
    double avlBal = getTotalIncome() - getTotalExpense();
    String formattedBalance = NumberFormat.currency(symbol: '₹').format(avlBal);

    // Get category-wise expenses
    Map<String, double> categoryExpenses = getCategoryExpenses();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 85, 80, 80),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menu",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Manage your transactions",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              // tileColor: Colors.,
              leading: Icon(Icons.add, color: Colors.blue),
              title: Text(
                "Add Transaction",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                setState(() {
                  _showTranscationDropdown = !_showTranscationDropdown;
                });
              },
            ),

            // This container is for selecting type of transaction income or expense
            if (_showTranscationDropdown)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _selectedMainCategory,
                  hint: Text('Transaction type'),
                  onChanged: (String? newValue) async {
                    setState(() {
                      _selectedMainCategory = newValue;
                    });

                    if (newValue == 'Add Income') {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddIncomeScreen(),
                        ),
                      );

                      if (result != null) {
                        setState(() {
                          transactions.add({
                            'amount': result,
                            'date': DateFormat('MMM d').format(DateTime.now()),
                            'type': 'income',
                          });
                        });
                      }
                    }

                    if (newValue == 'Add Expense') {
                      final res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExpenseScreen(),
                        ),
                      );

                      if (res != null) {
                        setState(() {
                          transactions.add({
                            'amount': res['amount'],
                            'date': DateFormat('MMM d').format(DateTime.now()),
                            'category': res['category'],
                            'iconpath': res['iconpath'],
                            'type': 'expense',
                          });
                        });
                      }
                    }
                  },
                  items:
                      <String>[
                        'Add Income',
                        'Add Expense',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),

            ListTile(
              leading: Icon(Icons.list, color: Colors.green),
              title: Text(
                "View Transactions",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ExpenseRecords(expenseList: transactions),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.amber),
              title: Text(
                "Settings",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings Screen
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark_rounded, color: Colors.cyan),
              title: Text(
                "Help",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings Screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout,color: Colors.red,),
              title: Text("Logout",style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w400),),
              onTap: () {
                Navigator.pop(context);
                // Logout Functionality
              },
            ),
          ],
        ),
      ),
      body: Stack(
        // header section->includes username,profile pic,date(today fetching dynamically)
        children: [
          // this column is for name and date.
          Positioned(
            top: screenHeight * 0.001,
            left: screenWidth * 0.02,
            child: Card(
              color: Colors.grey[900],

              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Username123',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 130),
                    // profile pic
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.person_pin,
                        color: Colors.white,
                        size: screenHeight * 0.06,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Transactions inside a single long card
          Positioned(
            top: screenHeight * 0.52,
            left: screenWidth * 0.05,
            child: Card(
              color: Colors.grey[900],
              margin: EdgeInsets.only(bottom: 16),
              child: Container(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.35,
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      ...transactions.map((transaction) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child:
                              transaction['type'] == 'income'
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
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Total Income Display Card (ADD THIS WIDGET)
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.05,
            child: Container(
              height: screenHeight * 0.13,
              width: screenWidth * 0.3,
              child: Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Income',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          formattedIncome,
                          style: GoogleFonts.poppins(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // total expense
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.35,
            // right: screenWidth * 0.05,
            child: Container(
              height: screenHeight * 0.13,
              width: screenWidth * 0.3,
              child: Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Expense',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          formattedExpense,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // total balance
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.65,
            child: Container(
              height: screenHeight * 0.13,
              width: screenWidth * 0.3,
              child: Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Avl Balance',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          formattedBalance,
                          style: GoogleFonts.poppins(
                            color: avlBal >= 0 ? Colors.green : Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.26,
            left: screenWidth * 0.05,
            child: Container(
              height: screenHeight * 0.25,
              width: screenWidth * 0.9,
              child: Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expenses by Category',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: _getChartSections(categoryExpenses),
                            centerSpaceRadius: 40, // Doughnut hole size
                            sectionsSpace: 2, // Space between sections
                            startDegreeOffset: -90, // Start from top
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Generate chart sections for doughnut chart
List<PieChartSectionData> _getChartSections(
  Map<String, double> categoryExpenses,
) {
  List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.teal,
  ];

  return categoryExpenses.entries.map((entry) {
    return PieChartSectionData(
      value: entry.value,
      color:
          colors[categoryExpenses.keys.toList().indexOf(entry.key) %
              colors.length],
      title: '${entry.key}\n${entry.value.toStringAsFixed(2)}',
      radius: 20,
      titleStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }).toList();
}
