import 'package:delivery_app/data/models/model.dart';

class OrderSorter {
  static List<Order> sort(List<Order> orders, String sortOption) {
    final sortedOrders = List<Order>.from(orders);
    
    switch (sortOption) {
      case 'Nearest Drop':
        sortedOrders.sort((a, b) => a.eta.compareTo(b.eta));
        break;
      case 'ETA':
        sortedOrders.sort((a, b) => a.eta.compareTo(b.eta));
        break;
      case 'Time Picked':
        sortedOrders.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        break;
    }
    
    return sortedOrders;
  }
}