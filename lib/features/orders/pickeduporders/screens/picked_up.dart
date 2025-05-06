import 'package:delivery_app/core/widgets/pickeduporderwidgets/formatter.dart';
import 'package:delivery_app/core/widgets/pickeduporderwidgets/order_card.dart';
import 'package:delivery_app/core/widgets/pickeduporderwidgets/order_sorter.dart';
import 'package:delivery_app/core/widgets/pickeduporderwidgets/sort_bar.dart';
import 'package:delivery_app/core/widgets/pickeduporderwidgets/summary_footer.dart';
import 'package:delivery_app/data/models/model.dart';
import 'package:flutter/material.dart';

class PickedUpOrdersScreen extends StatefulWidget {
  const PickedUpOrdersScreen({super.key});

  @override
  State<PickedUpOrdersScreen> createState() => _PickedUpOrdersScreenState();
}

class _PickedUpOrdersScreenState extends State<PickedUpOrdersScreen> {
  final OrderRepository _repository = OrderRepository();
  List<Order> _pickedOrders = [];
  bool _isLoading = true;
  String _sortBy = 'Nearest Drop';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPickedOrders();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadPickedOrders() {
    setState(() {
      _isLoading = true;
    });

    _pickedOrders =
        _repository.getAllOrders().where((order) => order.isPicked).toList();
    _sortOrders();

    setState(() {
      _isLoading = false;
    });
  }

  void _sortOrders() {
    _pickedOrders = OrderSorter.sort(_pickedOrders, _sortBy);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _onSortSelected(String sortOption) {
    setState(() {
      _sortBy = sortOption;
      _sortOrders();
    });
  }

  void _markAsDelivered(String orderId) {
    final index = _pickedOrders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final updatedOrder = _pickedOrders[index].copyWith(status: 'Delivered');
      _repository.updateOrder(updatedOrder);

      setState(() {
        _pickedOrders[index] = updatedOrder;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order $orderId marked as delivered')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picked Up Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SortBar(
                  currentSort: _sortBy,
                  onSortSelected: _onSortSelected,
                ),
                Expanded(
                  child: _pickedOrders.isEmpty
                      ? const Center(
                          child: Text('No picked up orders found'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: _pickedOrders.length,
                          itemBuilder: (context, index) {
                            final order = _pickedOrders[index];
                            return OrderCard(
                              order: order,
                              onMarkAsDelivered: _markAsDelivered,
                            );
                          },
                        ),
                ),
                SummaryFooter(
                  orderCount: _pickedOrders.length,
                  estimatedTime:
                      TimeFormatter.calculateTotalEstimatedTime(_pickedOrders),
                ),
              ],
            ),
    );
  }
}
