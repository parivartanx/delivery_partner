import 'package:flutter/material.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(
          children: [
            _buildInfoRow(
                title: 'Payment Type:',
                value: 'COD',
                valueColor: Colors.blue,
                showValueBadge: true),
            _buildInfoRow(
                title: 'Order Status:',
                value: 'Picked Up',
                valueColor: const Color.fromARGB(255, 25, 157, 30),
                showValueBadge: true),
            _buildInfoRow(title: 'ETA:', value: '45 mins'),
            _buildInfoRow(title: 'Time Picked:', value: '3:05 PM'),
            _buildInfoRow(
              title: 'Delivery Location:',
              value: '456 Elm Street, NYC',
              prefix:
                  const Icon(Icons.location_on, color: Colors.brown, size: 18),
            ),
            _buildInfoRow(title: 'Delivery Time:', value: 'Estimated: 3:50 PM'),
            _buildInfoRow(
              title: 'Delivery Instructions:',
              value: 'Leave at gate',
              suffix: Container(
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.navigation, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    InkWell(
                      child: Container(
                        width: 60,
                        height: 20,
                        child: const Text('Navigate',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String title,
    required String value,
    Color valueColor = Colors.black,
    bool showValueBadge = false,
    Widget? prefix,
    Widget? suffix,
  }) {
    Color getBadgeColor(Color color) {
      if (color == Colors.blue) return const Color.fromARGB(255, 215, 229, 241);
      if (color == Colors.green)
        return const Color.fromARGB(255, 190, 235, 194);
      if (color == Colors.red) return Colors.red.shade50;
      return Colors.grey.shade200;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Row(
            children: [
              if (prefix != null) ...[prefix, const SizedBox(width: 4)],
              showValueBadge
                  ? Container(
                      decoration: BoxDecoration(
                          color: getBadgeColor(valueColor),
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      child: Text(value,
                          style: TextStyle(
                              color: valueColor, fontWeight: FontWeight.w500)),
                    )
                  : Text(value,
                      style: TextStyle(
                          color: valueColor, fontWeight: FontWeight.w500)),
              if (suffix != null) ...[const SizedBox(width: 8), suffix],
            ],
          ),
        ],
      ),
    );
  }
}
