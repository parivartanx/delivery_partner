// File: lib/widgets/sort_bar.dart
import 'package:flutter/material.dart';

class SortBar extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortSelected;

  const SortBar(
      {super.key, required this.currentSort, required this.onSortSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSortOption('Nearest Drop'),
          const SizedBox(width: 16),
          _buildSortOption('ETA'),
          const SizedBox(width: 16),
          _buildSortOption('Time Picked'),
        ],
      ),
    );
  }

  Widget _buildSortOption(String option) {
    final isSelected = currentSort == option;
    return InkWell(
      onTap: () => onSortSelected(option),
      child: Text(
        option,
        style: TextStyle(
          color: isSelected ? Colors.indigo : Colors.black54,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
