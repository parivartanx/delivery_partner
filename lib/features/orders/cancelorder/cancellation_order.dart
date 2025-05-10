import 'package:flutter/material.dart';

class CancelDeliveryApp extends StatelessWidget {
  const CancelDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cancel Delivery',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CancelDeliveryDialog(),
        ),
      ),
    );
  }
}

class CancelDeliveryDialog extends StatefulWidget {
  const CancelDeliveryDialog({super.key});

  @override
  State<CancelDeliveryDialog> createState() => _CancelDeliveryDialogState();
}

class _CancelDeliveryDialogState extends State<CancelDeliveryDialog> {
  String? _selectedReason;

  final List<String> _reasons = [
    'Customer Unavailable',
    'Wrong Address',
    'Customer Refused Delivery',
    'Weather or Traffic Issue',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Cancel Delivery – Reason Required',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          ..._reasons.map(
            (reason) => RadioListTile<String>(
              title: Text(reason),
              value: reason,
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Cancel action
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Confirm action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Confirm Cancellation'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
