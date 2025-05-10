import 'package:delivery_app/features/orders/deliveryhistory/screens/delivery_history_screen.dart';
import 'package:delivery_app/features/profile/profile_setting.dart';
import 'package:flutter/material.dart';

class FourButtons extends StatelessWidget {
  const FourButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOrderButton(
              icon: Icons.inventory,
              label: "All Orders",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onTap: () {},
            ),
            _buildOrderButton(
              icon: Icons.money,
              label: "Earning",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOrderButton(
              icon: Icons.history,
              label: "Delivery History",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryHistoryScreen(),
                  ),
                );
              },
            ),
            _buildOrderButton(
              icon: Icons.settings,
              label: "Setting",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileSettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderButton({
    required IconData icon,
    required String label,
    required double screenWidth,
    required double screenHeight,
    required VoidCallback onTap,
  }) {
    final buttonWidth = screenWidth * 0.43;
    final buttonHeight = screenHeight * 0.15;
    final iconSize = screenWidth * 0.08;
    final fontSize = screenWidth * 0.04;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
        decoration: BoxDecoration(
          color: const Color(0xFFD5EEF8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
          child: Column(
            children: [
              Icon(icon, size: iconSize, color: Colors.blue),
              SizedBox(height: screenHeight * 0.01),
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
