import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double getFont(double size) => size * screenWidth / 375;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          Text(
            'Order Details',
            style: TextStyle(
              fontSize: getFont(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            '#DLV-2098',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: getFont(14),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.share),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
