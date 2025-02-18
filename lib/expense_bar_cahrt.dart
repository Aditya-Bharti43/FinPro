import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:collection';

import 'package:google_fonts/google_fonts.dart';

class ExpenseBarChart extends StatefulWidget {
  final List<Map<String, String>> transactions;
  ExpenseBarChart({required this.transactions});
  @override
  _ExpenseBarChartState createState() => _ExpenseBarChartState();
}

class _ExpenseBarChartState extends State<ExpenseBarChart> {
  // List of categories
  List<String> categories = ["Food", "Edu.", "Ent.", "Misc.", "Health"];

  // Group transactions by category
  Map<String, double> getGroupedExpenses() {
    Map<String, double> expenseMap = {
      "Food": 0,
      "Education": 0,
      "Entertainment": 0,
      "Miscellaneous": 0,
      "Health": 0,
    };

    for (var tx in widget.transactions) {
      if (tx['type'] == 'expense' && tx.containsKey('category')) {
        String category = tx["category"]!;
        double amount = double.parse(tx["amount"]!);
        expenseMap[category] = expenseMap[category]! + amount;
      }
    }

    return expenseMap;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> groupedExpenses = getGroupedExpenses();
    List<double> amounts = groupedExpenses.values.toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Expenses by Category")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: screenHeight * 0.3,
          width: screenWidth * 0.9,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY:
                  amounts.reduce((a, b) => a > b ? a : b) +
                  100, // Set max value dynamically
              barGroups: List.generate(categories.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: amounts[index],
                      width: 30,
                      // color: Colors.purple,
                      gradient: LinearGradient(
                        colors: [Colors.cyanAccent, Colors.blueAccent],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(
                  // showTitles: false,
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toString(), // Numbers on Y-axis
                        style: TextStyle(
                          color:
                              Colors
                                  .white, // Set white color for Y-axis numbers
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 500, // Adjust based on your data range
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toString(), // Numbers on Y-axis
                        style: TextStyle(
                          color:
                              Colors
                                  .white, // Set white color for Y-axis numbers
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < categories.length) {
                        return Text(
                          categories[value.toInt()],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        );
                      }
                      return Text("");
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
