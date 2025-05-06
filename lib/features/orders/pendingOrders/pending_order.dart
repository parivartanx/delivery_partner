import 'package:delivery_app/data/models/model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingOrdersScreen extends StatefulWidget {
  const PendingOrdersScreen({super.key});

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  String sortBy = 'Nearest';
  String timeFilter = 'Today';
  String selectedTab = 'All';

  final OrderRepository orderRepository = OrderRepository();
  late List<Order> displayedOrders;

  @override
  void initState() {
    super.initState();
    displayedOrders = orderRepository.getPendingOrders();
  }

  void _filterOrders() {
    setState(() {
      List<Order> pendingOrders = orderRepository.getPendingOrders();

      switch (selectedTab) {
        case 'All':
          displayedOrders = pendingOrders;
          break;
        case 'Priority':
          displayedOrders =
              pendingOrders.where((order) => order.status == 'COD').toList();
          break;
        case 'Scheduled':
          // Fixed the time comparison logic
          displayedOrders = pendingOrders
              .where((order) => _isLaterTime(order.eta, '4:00 PM'))
              .toList();
          break;
      }
    });
  }

  // Helper method to compare time strings
  bool _isLaterTime(String time1, String time2) {
    final DateTime t1 = _parseTimeString(time1);
    final DateTime t2 = _parseTimeString(time2);
    return t1.isAfter(t2);
  }

  // Parse time strings like "4:00 PM" to DateTime objects
  DateTime _parseTimeString(String timeStr) {
    final List<String> parts = timeStr.split(' ');
    final List<String> timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    
    // Adjust for PM
    if (parts.length > 1 && parts[1] == 'PM' && hour < 12) {
      hour += 12;
    }
    // Adjust for AM
    if (parts.length > 1 && parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }
    
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  void _handlePickUp(Order order) {
    setState(() {
      orderRepository.markOrderAsPickedUp(order.id);
      _filterOrders();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order ${order.id} has been picked up'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleMarkAllPicked() {
    setState(() {
      orderRepository.markAllOrdersAsPickedUp();
      _filterOrders();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All orders have been marked as picked up'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchNavigation(String address) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch navigation'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showOrderDetails(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order ${order.id} Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer', order.customer),
              _buildDetailRow('Phone', order.phone),
              _buildDetailRow('Pickup', order.pickup),
              _buildDetailRow('Delivery', order.delivery),
              _buildDetailRow('ETA', order.eta),
              _buildDetailRow('Status', order.status),
              _buildDetailRow('Picked Up', order.isPicked ? 'Yes' : 'No'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 5),
            _buildFilters(),
            const SizedBox(height: 5),
            _buildTabs(),
            Expanded(
              child: _buildOrdersList(),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Pending Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 31, 21, 105),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 31, 21, 105)),
            onPressed: () {
              // Show search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search functionality coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              'Sort by $sortBy',
              () {
                // Show sort options
                _showSortOptions();
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildDropdown(
              timeFilter,
              () {
                // Show time filter options
                _showTimeFilterOptions();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Sort by Nearest'),
            onTap: () {
              setState(() {
                sortBy = 'Nearest';
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('Sort by ETA'),
            onTap: () {
              setState(() {
                sortBy = 'ETA';
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('Sort by Status'),
            onTap: () {
              setState(() {
                sortBy = 'Status';
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }

  void _showTimeFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Today'),
            onTap: () {
              setState(() {
                timeFilter = 'Today';
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('This Week'),
            onTap: () {
              setState(() {
                timeFilter = 'This Week';
                Navigator.pop(context);
              });
            },
          ),
          ListTile(
            title: const Text('All Time'),
            onTap: () {
              setState(() {
                timeFilter = 'All Time';
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String text, VoidCallback onTap) {
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

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab('All'),
          _buildTab('Priority'),
          _buildTab('Scheduled'),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    final bool isSelected = selectedTab == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
          _filterOrders();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? const Color.fromARGB(255, 31, 21, 105)
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color.fromARGB(255, 31, 21, 105)
                : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    if (displayedOrders.isEmpty) {
      return const Center(
        child: Text(
          'No pending orders',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: displayedOrders.length,
      itemBuilder: (context, index) {
        final order = displayedOrders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderHeader(order),
            const SizedBox(height: 8),
            _buildCustomerInfo(order),
            const SizedBox(height: 8),
            _buildLocationInfo('Pickup:', order.pickup),
            const SizedBox(height: 4),
            _buildLocationInfo('Delivery:', order.delivery),
            const SizedBox(height: 8),
            _buildOrderFooter(order),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Text(
      'Order ID: ${order.id}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A237E),
      ),
    );
  }

  Widget _buildCustomerInfo(Order order) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Customer: ${order.customer}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () async {
            // Launch phone call
            final Uri url = Uri.parse('tel:${order.phone}');
            if (!await launchUrl(url)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Could not launch phone app'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.blue[700]),
              const SizedBox(width: 4),
              Text(
                order.phone,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(String label, String location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(location),
        ),
      ],
    );
  }

  Widget _buildOrderFooter(Order order) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ETA: ${order.eta}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildStatusChip(order.status),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionChip('Pending', Colors.amber),
            InkWell(
              onTap: () => _launchNavigation(order.pickup),
              child: _buildButtonChip('Navigate', const Color.fromARGB(255, 26, 35, 126)),
            ),
            InkWell(
              onTap: () => _handlePickUp(order),
              child: _buildButtonChip('Picked Up', const Color.fromARGB(255, 26, 35, 126)),
            ),
            InkWell(
              onTap: () => _showOrderDetails(order),
              child: _buildButtonChip('Details', const Color.fromARGB(255, 26, 35, 126)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor = status == 'Paid' ? Colors.green : Colors.blue;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildActionChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildButtonChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Pending: ${displayedOrders.length} orders',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: displayedOrders.isNotEmpty ? _handleMarkAllPicked : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 25, 15, 161),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            child: const Text(
              'Mark All Picked',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


