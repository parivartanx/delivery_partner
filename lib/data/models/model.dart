class Order {
  final String id;
  final String customer;
  final String phone;
  final String pickup;
  final String delivery;
  final String eta;
  final String status;
  final DateTime dateTime; 
  final double earnings;
  bool isPicked;

  Order({
    required this.id,
    required this.customer,
    required this.phone,
    required this.pickup,
    required this.delivery,
    required this.eta,
    required this.status,
    required this.dateTime,
    this.earnings = 0.0,
    this.isPicked = false,
  });

  Order copyWith({
    String? id,
    String? customer,
    String? phone,
    String? pickup,
    String? delivery,
    String? eta,
    String? status,
    DateTime? dateTime,
    double? earnings,
    bool? isPicked,
  }) {
    return Order(
      id: id ?? this.id,
      customer: customer ?? this.customer,
      phone: phone ?? this.phone,
      pickup: pickup ?? this.pickup,
      delivery: delivery ?? this.delivery,
      eta: eta ?? this.eta,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      earnings: earnings ?? this.earnings,
      isPicked: isPicked ?? this.isPicked,
    );
  }
}

// Repository class to manage orders
class OrderRepository {
  // Singleton pattern
  static final OrderRepository _instance = OrderRepository._internal();
  
  factory OrderRepository() {
    return _instance;
  }
  
  OrderRepository._internal() {
    // Initialize with sample data
    _initializeData();
  }

  List<Order> getPendingOrders() {
    return _orders.where((order) => !order.isPicked).toList();
  }

  void markAllOrdersAsPickedUp() {
    for (int i = 0; i < _orders.length; i++) {
      _orders[i] = _orders[i].copyWith(isPicked: true);
    }
  }

  void markOrderAsPickedUp(String orderId) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(isPicked: true);
    }
  }


  List<Order> _orders = [];

  void _initializeData() {
    _orders = [
      Order(
        id: 'DLV-8721',
        customer: 'Rahul Sharma',
        phone: '123-456-7890',
        pickup: 'Warehouse A',
        delivery: '123 MG Road, Bengaluru',
        eta: '7:51 PM',
        dateTime: DateTime(2025, 4, 28, 10, 30),
        status: 'Delivered',
        earnings: 150,
        isPicked: true,
      ),
      Order(
        id: 'DLV-8722',
        customer: 'Anjali Verma',
        phone: '987-654-3210',
        pickup: 'Warehouse B',
        delivery: '456 Park Street, Mumbai',
        eta: '3:13 PM',
        dateTime: DateTime(2025, 4, 28, 15, 0),
        status: 'Returned',
        earnings: 0,
        isPicked: true,
      ),
      Order(
        id: 'DLV-8723',
        customer: 'Vikram Singh',
        phone: '555-123-4567',
        pickup: 'Warehouse A',
        delivery: '789 Main Road, Chennai',
        eta: '1:47 PM',
        dateTime: DateTime(2025, 4, 28, 11, 0),
        status: 'Cancelled',
        earnings: 0,
        isPicked: false,
      ),
      Order(
        id: 'DLV-8724',
        customer: 'Priya Patel',
        phone: '222-333-4444',
        pickup: 'Warehouse C',
        delivery: '567 Lake View, Delhi',
        eta: '4:21 PM',
        dateTime: DateTime.now().subtract(const Duration(hours: 3)),
        status: 'Delivered',
        earnings: 200,
        isPicked: true,
      ),
      Order(
        id: 'DLV-8725',
        customer: 'Aditya Kumar',
        phone: '888-777-6666',
        pickup: 'Warehouse B',
        delivery: '890 Hill Road, Pune',
        eta: '5:28 PM',
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Delivered',
        earnings: 120,
        isPicked: true,
      ),
    ];
  }

  // Get all orders
  List<Order> getAllOrders() {
    return List.from(_orders);
  }
  
  // Filter orders by date range
  List<Order> filterByDateRange(DateTime startDate, DateTime endDate) {
    return _orders.where((order) => 
      order.dateTime.isAfter(startDate) && 
      order.dateTime.isBefore(endDate.add(const Duration(days: 1)))
    ).toList();
  }
  
  // Filter orders by status
  List<Order> filterByStatus(String status) {
    if (status == 'All') return List.from(_orders);
    return _orders.where((order) => order.status == status).toList();
  }
  
  // Search orders
  List<Order> searchOrders(String query) {
    if (query.isEmpty) return List.from(_orders);
    
    final lowercaseQuery = query.toLowerCase();
    return _orders.where((order) => 
      order.id.toLowerCase().contains(lowercaseQuery) ||
      order.customer.toLowerCase().contains(lowercaseQuery) ||
      order.delivery.toLowerCase().contains(lowercaseQuery) ||
      order.pickup.toLowerCase().contains(lowercaseQuery)
    ).toList();
  }
  
  // Update an order
  void updateOrder(Order updatedOrder) {
    final index = _orders.indexWhere((order) => order.id == updatedOrder.id);
    if (index != -1) {
      _orders[index] = updatedOrder;
    }
  }
  
  // Add a new order
  void addOrder(Order order) {
    _orders.add(order);
  }
  
  // Delete an order
  void deleteOrder(String orderId) {
    _orders.removeWhere((order) => order.id == orderId);
  }
}

class OrderDisplayModel {
  final String id;
  final String customerName;
  final DateTime dateTime;
  final String address;
  final String orderType;
  final double earnings;
  final OrderStatus status;

  OrderDisplayModel({
    required this.id,
    required this.customerName,
    required this.dateTime,
    required this.address,
    required this.orderType,
    required this.earnings,
    required this.status,
  });
}

enum OrderStatus {
  delivered,
  returned,
  cancelled,
}