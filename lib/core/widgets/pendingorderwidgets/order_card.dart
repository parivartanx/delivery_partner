import 'package:delivery_app/core/widgets/pendingorderwidgets/chips/action_chips.dart';
import 'package:delivery_app/core/widgets/pendingorderwidgets/chips/status_chips.dart';
import 'package:delivery_app/data/models/model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onNavigate;
  final VoidCallback onPickUp;
  final VoidCallback onShowDetails;

  const OrderCard({
    super.key,
    required this.order,
    required this.onNavigate,
    required this.onPickUp,
    required this.onShowDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(),
            const SizedBox(height: 8),
            _buildCustomerInfo(context),
            const SizedBox(height: 8),
            _buildLocationInfo('Pickup:', order.pickup),
            const SizedBox(height: 4),
            _buildLocationInfo('Delivery:', order.delivery),
            const SizedBox(height: 8),
            _buildOrderFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Text(
      'Order ID: ${order.id}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A237E),
      ),
    );
  }

  Widget _buildCustomerInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Customer: ${order.customer}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () async {
            final Uri url = Uri.parse('tel:${order.phone}');
            if (!await launchUrl(url)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not launch phone app'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.blue[700]),
              const SizedBox(width: 4),
              Text(
                order.phone,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(String label, String location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(location),
        ),
      ],
    );
  }

  Widget _buildOrderFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ETA: ${order.eta}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            StatusChip(status: order.status),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ActionChipswidget(
              label: 'Pending',
              color: Colors.amber,
              onTap: null,
            ),
            ActionChipswidget(
              label: 'Navigate',
              color: const Color.fromARGB(255, 26, 35, 126),
              onTap: onNavigate,
            ),
            ActionChipswidget(
              label: 'Picked Up',
              color: const Color.fromARGB(255, 26, 35, 126),
              onTap: onPickUp,
            ),
            ActionChipswidget(
              label: 'Details',
              color: const Color.fromARGB(255, 26, 35, 126),
              onTap: onShowDetails,
            ),
          ],
        ),
      ],
    );
  }
}