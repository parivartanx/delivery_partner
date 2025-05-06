import 'package:delivery_app/data/models/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderDisplayModel order;
  final VoidCallback onViewDetails;

  const OrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Color statusColor;
    String statusText;

    switch (order.status) {
      case OrderStatus.delivered:
        statusColor = Colors.green;
        statusText = 'Delivered';
        break;
      case OrderStatus.returned:
        statusColor = Colors.amber[800]!;
        statusText = 'Returned';
        break;
      case OrderStatus.cancelled:
        statusColor = Colors.red;
        statusText = 'Cancelled';
        break;
    }

    return Card(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.width * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: #${order.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.025,
                    vertical: size.height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(size.width * 0.03),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.035,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.015),
            _buildOrderCardDetail(context, 'Customer', order.customerName),
            _buildOrderCardDetail(
              context,
              'Date & Time',
              DateFormat('dd MMM, h:mm a').format(order.dateTime),
            ),
            _buildOrderCardDetail(context, 'Address', order.address),
            _buildOrderCardDetail(context, 'Order Type', order.orderType),
            _buildOrderCardDetail(context, 'Earnings', '₹${order.earnings}'),
            SizedBox(height: size.height * 0.012),
            ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: Size(size.width * 0.3, size.height * 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size.width * 0.02),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.005,
                ),
              ),
              child: Text(
                'View Details',
                style: TextStyle(fontSize: size.width * 0.035),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCardDetail(BuildContext context, String label, String value) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: size.width * 0.035,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: size.width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
