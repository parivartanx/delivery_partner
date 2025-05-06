import 'package:flutter/material.dart';

class FliteredChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const FliteredChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      hoverColor: Colors.white,
      highlightColor: Colors.white,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.008,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.04),
          border: Border.all(
            color: isSelected ? Colors.indigo : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: size.width * 0.035,
              color: Colors.indigo,
            ),
            SizedBox(width: size.width * 0.01),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.indigo : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: size.width * 0.033,
              ),
            ),
          ],
        ),
      ),
    );
  }
}