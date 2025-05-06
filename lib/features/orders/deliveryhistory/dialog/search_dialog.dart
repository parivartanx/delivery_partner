import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  final String initialQuery;
  final Function(String) onSearch;

  const SearchDialog({
    super.key,
    required this.initialQuery,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String tempQuery = initialQuery;
    
    return AlertDialog(
      title: Text(
        'Search Orders', 
        style: TextStyle(fontSize: size.width * 0.045),
      ),
      content: SizedBox(
        width: size.width * 0.8,
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Order ID, customer name, or address',
            prefixIcon: Icon(Icons.search, size: size.width * 0.05),
            contentPadding: EdgeInsets.all(size.width * 0.03),
          ),
          onChanged: (value) {
            tempQuery = value;
          },
          controller: TextEditingController(text: initialQuery),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: TextStyle(fontSize: size.width * 0.035)),
        ),
        ElevatedButton(
          onPressed: () {
            onSearch(tempQuery);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04, 
              vertical: size.height * 0.01
            ),
          ),
          child: Text('Search', style: TextStyle(fontSize: size.width * 0.035 , color: Colors.white)),
        ),
      ],
    );
  }
}
