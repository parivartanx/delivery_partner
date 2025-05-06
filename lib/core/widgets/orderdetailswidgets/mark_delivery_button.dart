import 'package:flutter/material.dart';

class MarkDeliveredButton extends StatelessWidget {
  const MarkDeliveredButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 200,
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.check, color: Colors.white),
          label: const Text(
            'Mark as Delivered',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }
}
