import 'package:flutter/material.dart';
import 'package:delivery_app/data/models/model.dart';
import 'package:intl/intl.dart';

class OrderDetailsDialog extends StatelessWidget {
  final OrderDisplayModel order;

  const OrderDetailsDialog({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return AlertDialog(
      title: Text(
        'Order Details: #${order.id}',
        style: TextStyle(fontSize: size.width * 0.045),
      ),
      content: SizedBox(
        width: size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow(
                context,
                'Customer', 
                order.customerName,
                textSize: size.width * 0.035,
              ),
              _buildDetailRow(
                context,
                'Date & Time',
                DateFormat('dd MMM yyyy, h:mm a').format(order.dateTime),
                textSize: size.width * 0.035,
              ),
              _buildDetailRow(
                context,
                'Address', 
                order.address,
                textSize: size.width * 0.035,
              ),
              _buildDetailRow(
                context,
                'Order Type', 
                order.orderType,
                textSize: size.width * 0.035,
              ),
              _buildDetailRow(
                context,
                'Status', 
                _getStatusText(order.status),
                textSize: size.width * 0.035,
              ),
              _buildDetailRow(
                context,
                'Earnings', 
                '₹${order.earnings}',
                textSize: size.width * 0.035,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(fontSize: size.width * 0.035),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, {double? textSize}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontSize: textSize,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: textSize),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.returned:
        return 'Returned';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
