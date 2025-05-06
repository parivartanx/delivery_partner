// File: lib/widgets/order_card.dart
import 'package:delivery_app/core/widgets/pickeduporderwidgets/formatter.dart';
import 'package:delivery_app/core/widgets/pickeduporderwidgets/order_detail_sheet.dart';
import 'package:delivery_app/data/models/model.dart';
import 'package:delivery_app/features/orders/orderdetails/order_detail2.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function(String) onMarkAsDelivered;

  const OrderCard({
    super.key,
    required this.order,
    required this.onMarkAsDelivered,
  });

  void _navigateToMap(BuildContext context, String address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to: $address')),
    );
  }

  void _callCustomer(BuildContext context, String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling customer: $phone')),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showModalBottomSheet(
      context: context,
      builder: (context) => OrderDetailsSheet(order: order),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPaid = order.status == 'Delivered' || order.earnings > 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${TextFormatter.getFormattedOrderId(order.id)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Picked Up',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Customer: ${order.customer}'),
            InkWell(
              onTap: () => _callCustomer(context, order.phone),
              child: Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    order.phone,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            Text('Address: ${order.delivery}'),
            Text('ETA: ${TimeFormatter.getEstimatedMinutes(order.eta)}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatusBadge(isPaid),
                const SizedBox(width: 8),
                _buildActionButton(
                  label: 'Navigate',
                  onTap: () => _navigateToMap(context, order.delivery),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  label: 'Delivery',
                  onTap: () => onMarkAsDelivered(order.id),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  label: 'Details',
                  onTap: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderDetailsWithoutId()),
                        );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPaid ? Colors.green : Colors.blue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        isPaid ? 'Paid' : 'COD',
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Widget _buildActionButton({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 48, 22, 138),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}