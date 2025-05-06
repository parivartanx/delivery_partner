import 'package:delivery_app/core/widgets/profileswidget/cart.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<Cart> carts = [
    Cart(
        customer: "John Doe",
        pickup: "123 Main St, NYC",
        delivery: "456 Elm St, NYC",
        status: "Pending",
        estDelivery: "30 mins"),
    Cart(
        customer: "Jane Smith",
        pickup: "456 Oak St, NYC",
        delivery: "789 Pine St, NYC",
        status: "In Transit",
        estDelivery: "20 mins"),
    Cart(
        customer: "David Lee",
        pickup: "789 Maple St, NYC",
        delivery: "101 Cedar St, NYC",
        status: "Delivered",
        estDelivery: "40 mins"),
    Cart(
        customer: "Sarah Johnson",
        pickup: "101 Pine St, NYC",
        delivery: "1212 Oak St, NYC",
        status: "Pending",
        estDelivery: "25 mins"),
    Cart(
        customer: "Michael Brown",
        pickup: "1212 Cedar St, NYC",
        delivery: "1414 Maple St, NYC",
        status: "In Transit",
        estDelivery: "15 mins"),
    Cart(
        customer: "Linda Davis",
        pickup: "1414 Oak St, NYC",
        delivery: "1616 Pine St, NYC",
        status: "Delivered",
        estDelivery: "35 mins"),
    Cart(
        customer: "Kevin Wilson",
        pickup: "1616 Maple St, NYC",
        delivery: "1818 Cedar St, NYC",
        status: "Pending",
        estDelivery: "30 mins"),
    Cart(
        customer: "Ashley Garcia",
        pickup: "1818 Pine St, NYC",
        delivery: "2020 Oak St, NYC",
        status: "In Transit",
        estDelivery: "22 mins"),
    Cart(
        customer: "Brian Rodriguez",
        pickup: "2020 Cedar St, NYC",
        delivery: "2222 Maple St, NYC",
        status: "Delivered",
        estDelivery: "45 mins"),
    Cart(
        customer: "Jessica Williams",
        pickup: "2222 Oak St, NYC",
        delivery: "2424 Pine St, NYC",
        status: "Pending",
        estDelivery: "28 mins"),
    Cart(
        customer: "Christopher Jones",
        pickup: "2424 Maple St, NYC",
        delivery: "2626 Cedar St, NYC",
        status: "In Transit",
        estDelivery: "18 mins"),
  ];

  int visibleCartCount = 1;
  int defaultVisibleCount = 1;

  void _viewCart(Cart cart) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cart Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${cart.customer}'),
            Text('Pickup: ${cart.pickup}'),
            Text('Delivery: ${cart.delivery}'),
            Text('Status: ${cart.status}'),
            Text('Est. Delivery: ${cart.estDelivery}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToDelivery(Cart cart) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to ${cart.delivery}...')),
    );
  }

  void _updateStatus(Cart cart) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Pending'),
              onTap: () {
                setState(() {
                  int index = carts.indexOf(cart);
                  carts[index] = Cart(
                    customer: cart.customer,
                    pickup: cart.pickup,
                    delivery: cart.delivery,
                    status: "Pending",
                    estDelivery: cart.estDelivery,
                  );
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('In Transit'),
              onTap: () {
                setState(() {
                  int index = carts.indexOf(cart);
                  carts[index] = Cart(
                    customer: cart.customer,
                    pickup: cart.pickup,
                    delivery: cart.delivery,
                    status: "In Transit",
                    estDelivery: cart.estDelivery,
                  );
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delivered'),
              onTap: () {
                setState(() {
                  int index = carts.indexOf(cart);
                  carts[index] = Cart(
                    customer: cart.customer,
                    pickup: cart.pickup,
                    delivery: cart.delivery,
                    status: "Delivered",
                    estDelivery: cart.estDelivery,
                  );
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: visibleCartCount < carts.length
                ? visibleCartCount
                : carts.length,
            itemBuilder: (context, index) {
              final cart = carts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                color: Colors.grey[200],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer: ${cart.customer}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Pickup: ${cart.pickup}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Delivery: ${cart.delivery}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _getStatusColor(cart.status),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              cart.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => _viewCart(cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('View'),
                          ),
                          ElevatedButton(
                            onPressed: () => _navigateToDelivery(cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Navigate'),
                          ),
                          ElevatedButton(
                            onPressed: () => _updateStatus(cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Update Status'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Est. Delivery: ${cart.estDelivery}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (visibleCartCount < carts.length)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      visibleCartCount = carts.length;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('See Full List'),
                ),
              if (visibleCartCount > defaultVisibleCount)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        visibleCartCount = defaultVisibleCount;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('See Less'),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.blue;
      case 'In Transit':
        return Colors.orange;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}