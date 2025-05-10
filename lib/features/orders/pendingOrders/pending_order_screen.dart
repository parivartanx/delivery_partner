import 'package:delivery_app/core/widgets/pendingorderwidgets/order_card.dart';
import 'package:delivery_app/core/widgets/pendingorderwidgets/order_filter.dart';
import 'package:delivery_app/core/widgets/pendingorderwidgets/order_header.dart';
import 'package:delivery_app/core/widgets/pendingorderwidgets/order_tabs.dart';
import 'package:delivery_app/core/widgets/pendingorderwidgets/time_utils.dart';
import 'package:delivery_app/data/models/model.dart';
import 'package:delivery_app/features/orders/pendingOrders/dialogs/order_detail_dialogs.dart';
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
          displayedOrders = pendingOrders
              .where((order) => TimeUtils.isLaterTime(order.eta, '4:00 PM'))
              .toList();
          break;
      }
    });
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

  void _onSortChanged(String newValue) {
    setState(() {
      sortBy = newValue;
    });
  }

  void _onTimeFilterChanged(String newValue) {
    setState(() {
      timeFilter = newValue;
    });
  }

  void _onTabSelected(String tab) {
    setState(() {
      selectedTab = tab;
      _filterOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OrderHeader(
              onSearchPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Search functionality coming soon'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            OrderFilters(
              sortBy: sortBy,
              timeFilter: timeFilter,
              onSortChanged: _onSortChanged,
              onTimeFilterChanged: _onTimeFilterChanged,
            ),
            const SizedBox(height: 5),
            OrderTabs(
              selectedTab: selectedTab,
              onTabSelected: _onTabSelected,
            ),
            Expanded(
              child: _buildOrdersList(),
            ),
            OrderFooter(
              totalOrders: displayedOrders.length,
              onMarkAllPicked: displayedOrders.isNotEmpty ? _handleMarkAllPicked : null,
            ),
          ],
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
        return OrderCard(
          order: order,
          onNavigate: () => _launchNavigation(order.pickup),
          onPickUp: () => _handlePickUp(order),
          onShowDetails: () => OrderDetailsDialog.show(context, order),
        );
      },
    );
  }
}