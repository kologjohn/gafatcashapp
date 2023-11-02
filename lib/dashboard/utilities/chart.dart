import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


Widget Pie(BuildContext context,double pending,double completed) {
  List<PieChartSectionData> paiChartSelectionData = [
    PieChartSectionData(
      color: Colors.orange,
      value: pending,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Colors.green[900],
      value: completed,
      showTitle: false,
      radius: 22,
    ),

  ];
  return SizedBox(
    height: 200,
    child: Stack(
      children: [
        PieChart(
          PieChartData(
            sectionsSpace: 0,
            centerSpaceRadius: 70,
            startDegreeOffset: -90,
            sections: paiChartSelectionData,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: defaultPadding),
              Text(
                "$completed",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 0.2,
                ),
              ),
              Text("of ${pending}",style: const TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ],
    ),
  );
}


