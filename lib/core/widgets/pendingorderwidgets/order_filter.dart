import 'package:flutter/material.dart';

class OrderFilters extends StatelessWidget {
  final String sortBy;
  final String timeFilter;
  final Function(String) onSortChanged;
  final Function(String) onTimeFilterChanged;

  const OrderFilters({
    super.key,
    required this.sortBy,
    required this.timeFilter,
    required this.onSortChanged,
    required this.onTimeFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              context,
              'Sort by $sortBy',
              () => _showSortOptions(context),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDropdown(
              context,
              timeFilter,
              () => _showTimeFilterOptions(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Sort by Nearest'),
            onTap: () {
              onSortChanged('Nearest');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sort by ETA'),
            onTap: () {
              onSortChanged('ETA');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sort by Status'),
            onTap: () {
              onSortChanged('Status');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showTimeFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Today'),
            onTap: () {
              onTimeFilterChanged('Today');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('This Week'),
            onTap: () {
              onTimeFilterChanged('This Week');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('All Time'),
            onTap: () {
              onTimeFilterChanged('All Time');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}