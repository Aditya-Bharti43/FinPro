import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DoughnutChartExample extends StatefulWidget {
  const DoughnutChartExample({super.key});

  @override
  State<DoughnutChartExample> createState() => _DoughnutChartExampleState();
}

class _DoughnutChartExampleState extends State<DoughnutChartExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doughnut Chart Example')),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2, // Space between sections
              centerSpaceRadius: 60, // Creates the "hole" (Doughnut effect)
              sections: getChartSections(),
            ),
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> getChartSections() {
  return [
    PieChartSectionData(
      color: Color.fromARGB(255, 39, 28, 190),
      value: 30,
      title: '30%',
      radius: 50,
      titleStyle: TextStyle(color:  Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      color: Color.fromARGB(255, 221, 129, 9),
      value: 20,
      title: '20%',
      radius: 50,
      titleStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      color: Color.fromARGB(255, 28, 190, 71),
      value: 25,
      title: '25%',
      radius: 50,
      titleStyle: TextStyle(color:  Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
     color: Color.fromARGB(255, 233, 11, 11),
      value: 15,
      title: '15%',
      radius: 50,
      titleStyle: TextStyle(color:  Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    ),
    PieChartSectionData(
      color: Color.fromARGB(255, 233, 7, 210),
      value: 10,
      title: '10%',
      radius: 50,
      titleStyle: TextStyle(color:  Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
    ),
  ];
}
