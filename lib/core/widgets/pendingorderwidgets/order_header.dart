import 'package:flutter/material.dart';

class OrderHeader extends StatelessWidget {
  final VoidCallback onSearchPressed;

  const OrderHeader({
    super.key,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          IconButton(onPressed: () {
            Navigator.pop(context) ;
          }, icon: const Icon(Icons.arrow_back_ios)),
          const Text(
            'Pending Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 31, 21, 105),
            ),
          ),
          const SizedBox(
            width: 120,
          ),
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 31, 21, 105)),
            onPressed: onSearchPressed,
          ),
        ],
      ),
    );
  }
}

class OrderFooter extends StatelessWidget {
  final int totalOrders;
  final VoidCallback? onMarkAllPicked;

  const OrderFooter({
    super.key,
    required this.totalOrders,
    required this.onMarkAllPicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Pending: $totalOrders orders',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: onMarkAllPicked,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 15, 161),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text(
              'Mark All Picked',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
