import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox,
            size: size.width * 0.15,
            color: Colors.grey[400],
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'No orders found',
            style: TextStyle(
              fontSize: size.width * 0.045,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Try changing your filters',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: size.width * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}