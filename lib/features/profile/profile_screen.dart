import 'package:delivery_app/core/widgets/profileswidget/earning_card.dart';
import 'package:delivery_app/core/widgets/profileswidget/list_screen.dart';
import 'package:delivery_app/core/widgets/profileswidget/order_buttons.dart';
import 'package:delivery_app/core/widgets/profileswidget/setting.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String userName = "Alex";
  final int noOfOrder = 5;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    color: Colors.blue,
                    size: 30,
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    'ParivartanX Delivery',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500 , fontSize: screenWidth * 0.04),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Color.fromARGB(255, 77, 75, 75),
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Color.fromARGB(255, 77, 75, 75),
                      size: 26,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning, $userName",
                  style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.001),
                Text(
                  'You have $noOfOrder active deliveries today',
                  style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: const Color.fromARGB(255, 117, 114, 114)),
                ),
                SizedBox(height: screenHeight * 0.02),
                const OrderButtons(),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Task List",
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  height: screenHeight * 0.4, // Adjust height as needed
                  child: const CartList(),
                ),
                SizedBox(height: screenHeight * 0.01),
                const Text(
                  'Earnings',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                EarningsCard(
                  todayEarnings: 8782,
                  barData: [
                    BarData(value: 150),
                    BarData(value: 100),
                    BarData(value: 30),
                    BarData(value: 300),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                const FourButtons(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: 'Locations'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
