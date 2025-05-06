import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> statusFilters;
  final String selectedStatusFilter;
  final Function(String) onApply;

  const FilterBottomSheet({
    super.key,
    required this.statusFilters,
    required this.selectedStatusFilter,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String tempStatusFilter;

  @override
  void initState() {
    super.initState();
    tempStatusFilter = widget.selectedStatusFilter;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Orders',
            style: TextStyle(
              fontSize: size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            'Status',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size.width * 0.04,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Wrap(
            spacing: size.width * 0.02,
            runSpacing: size.height * 0.01,
            children: widget.statusFilters.map((status) {
              return ChoiceChip(
                label: Text(status, style: TextStyle(fontSize: size.width * 0.035)),
                selected: tempStatusFilter == status,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      tempStatusFilter = status;
                    });
                  }
                },
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.indigo.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: tempStatusFilter == status
                      ? Colors.indigo
                      : Colors.black,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                  vertical: size.height * 0.005,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: size.width * 0.035),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(tempStatusFilter);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.01,
                  ),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
