import 'package:flutter/material.dart';

class EarningsCard extends StatelessWidget {
  final double todayEarnings;
  final List<BarData> barData;
  final double maxBarWidth = 100.0;
  const EarningsCard({
    super.key,
    required this.todayEarnings,
    required this.barData,
  });
  double get maxValue {
    if (barData.isEmpty) return 1.0;
    return barData.map((data) => data.value).reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              'Today: €${todayEarnings.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Stack(
              children: [
                // Vertical line
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1,
                    color: Colors.black87,
                  ),
                ),
                // Bar chart
                Column(
                  children: barData.isEmpty
                      ? []
                      : barData.map((data) {
                          // Calculate width proportional to value
                          final barWidth =
                              (data.value / maxValue) * maxBarWidth;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Container(
                                  height: 24,
                                  width: 12,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(width: 2),
                                Container(
                                  height: 24,
                                  width: barWidth,
                                  color: Colors.blue[400],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarData {
  final double value;

  BarData({required this.value});
}
