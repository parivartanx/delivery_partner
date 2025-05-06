import 'package:delivery_app/data/models/model.dart';
import 'package:flutter/material.dart';

class OrderDetailsSheet extends StatelessWidget {
  final Order order;

  const OrderDetailsSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Order Details',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          _detailRow('Order ID:', order.id),
          _detailRow('Customer:', order.customer),
          _detailRow('Phone:', order.phone),
          _detailRow('Pickup:', order.pickup),
          _detailRow('Delivery:', order.delivery),
          _detailRow('ETA:', order.eta),
          _detailRow('Status:', order.status),
          _detailRow('Earnings:', '₹${order.earnings.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
