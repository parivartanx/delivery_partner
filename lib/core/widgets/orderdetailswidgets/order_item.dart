import 'package:flutter/material.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderItem(name: 'Chicken Biryani', quantity: '2 x ₹250'),
            _buildOrderItem(name: 'Cold Coffee', quantity: '1 x ₹100'),
            _buildOrderItem(name: 'Extra Napkins', quantity: '1 x Free'),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('₹750.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem({required String name, required String quantity}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 15)),
          Text(quantity, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
