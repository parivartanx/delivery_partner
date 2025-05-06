import 'package:delivery_app/data/models/model.dart';

class DeliveryHistoryController {
  String selectedTimeFilter = 'Today';
  DateTime? startDate;
  DateTime? endDate;
  final List<String> statusFilters = ['All', 'Delivered', 'Returned', 'Cancelled'];
  String selectedStatusFilter = 'All';
  String searchQuery = '';
  
  final OrderRepository _orderRepository = OrderRepository();
  
  List<OrderDisplayModel> getOrdersForDisplay() {
    List<Order> filteredOrders = _getFilteredOrdersFromRepository();
    
    return filteredOrders.map((order) => OrderDisplayModel(
      id: order.id,
      customerName: order.customer,
      dateTime: order.dateTime,
      address: order.delivery,
      orderType: order.status == 'Paid' ? 'Paid' : 'COD',
      earnings: order.earnings,
      status: _convertStatusString(order.status),
    )).toList();
  }
  
  OrderStatus _convertStatusString(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return OrderStatus.delivered;
      case 'returned':
        return OrderStatus.returned;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.delivered;
    }
  }
  
  List<Order> _getFilteredOrdersFromRepository() {
    List<Order> orders = _orderRepository.getAllOrders();
    
    if (startDate != null && endDate != null) {
      orders = _orderRepository.filterByDateRange(startDate!, endDate!);
    }
    
    if (selectedStatusFilter != 'All') {
      orders = orders.where((order) => 
        order.status.toLowerCase() == selectedStatusFilter.toLowerCase()
      ).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      orders = orders.where((order) =>
        order.id.toLowerCase().contains(searchQuery.toLowerCase()) ||
        order.customer.toLowerCase().contains(searchQuery.toLowerCase()) ||
        order.delivery.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return orders;
  }

  void applyDateFilter(String filter) {
    selectedTimeFilter = filter;
    final now = DateTime.now();
    
    if (filter == 'Today') {
      startDate = DateTime(now.year, now.month, now.day);
      endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
    } else if (filter == 'This Week') {
      startDate = now.subtract(Duration(days: now.weekday - 1));
      startDate = DateTime(startDate!.year, startDate!.month, startDate!.day);
      endDate = startDate!.add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
    }
  }

  void setCustomDateRange(DateTime start, DateTime end) {
    startDate = start;
    endDate = end;
    selectedTimeFilter = 'Custom';
  }
}