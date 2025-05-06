import 'package:flutter/material.dart';

class SummaryFooter extends StatelessWidget {
  final int orderCount;
  final String estimatedTime;

  const SummaryFooter(
      {super.key, required this.orderCount, required this.estimatedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.indigo,
      width: double.infinity,
      child: Text(
        '$orderCount Orders In Transit • Estimated Time: $estimatedTime',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
