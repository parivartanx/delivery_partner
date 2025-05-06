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
                Icons.inventory, "All Orders", screenWidth, screenHeight),
            _buildOrderButton(Icons.money, "Earning",
                screenWidth, screenHeight),
          ],
        ),
        const SizedBox(height: 10,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOrderButton(
                Icons.history, "Delivery History", screenWidth, screenHeight),
            _buildOrderButton(Icons.settings, "Setting",
                screenWidth, screenHeight),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderButton(
      IconData icon, String label, double screenWidth, double screenHeight) {
    final buttonWidth = screenWidth * 0.43;
    final buttonHeight = screenHeight * 0.15;
    final iconSize = screenWidth * 0.08;
    final fontSize = screenWidth * 0.04;

    return InkWell(
      onTap: () {},
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
