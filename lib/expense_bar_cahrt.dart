import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseBarChart extends StatefulWidget {
  final List<Map<String, String>> transactions;
  ExpenseBarChart({required this.transactions});
  @override
  _ExpenseBarChartState createState() => _ExpenseBarChartState();
}

class _ExpenseBarChartState extends State<ExpenseBarChart> {
  List<String> categories = ["Food", "Education", "Entertainment", "Miscellaneous", "Health"];

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
        double amount = double.tryParse(tx["amount"]!) ?? 0;
        if (expenseMap.containsKey(category)) {
          expenseMap[category] = expenseMap[category]! + amount;
        }
      }
    }

    return expenseMap;
  }

  List<PieChartSectionData> _getChartSections(Map<String, double> categoryExpenses) {
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
        color: colors[categoryExpenses.keys.toList().indexOf(entry.key) % colors.length],
        title: '${entry.key}\n${entry.value.toStringAsFixed(2)}',
        radius: 60,
        titleStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> groupedExpenses = getGroupedExpenses();
    List<double> amounts = groupedExpenses.values.toList();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Expenses Overview"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Bar Chart
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.9,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: amounts.isNotEmpty ? amounts.reduce((a, b) => a > b ? a : b) + 100 : 0,
                    barGroups: List.generate(categories.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: amounts[index],
                            width: 30,
                            gradient: LinearGradient(
                              colors: [Colors.cyanAccent, Colors.blueAccent],
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 500,
                          getTitlesWidget: (value, _) => Text(
                            value.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            if (value.toInt() >= 0 && value.toInt() < categories.length) {
                              return Text(
                                categories[value.toInt()].substring(0, 3),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Text("");
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Pie Chart
              Container(
                height: screenHeight * 0.4,
                width: screenWidth * 0.9,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 80,
                    sectionsSpace: 2,
                    sections: _getChartSections(groupedExpenses),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
