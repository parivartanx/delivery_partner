import 'package:delivery_app/features/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

class TrackOrdersPage extends StatelessWidget {
  const TrackOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 400;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.01),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.04,
                  horizontal: screenSize.width * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Row: Icon and Title
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                        child: const Icon(Icons.local_shipping,
                            color: Colors.white, size: 28),
                      ),
                      SizedBox(width: screenSize.width * 0.06),
                      const Text(
                        "Track orders",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  // Map Illustration
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/map.jpeg',
                      height: screenSize.height * 0.5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Efficient delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 22 : 27,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  // Subtitle
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Manage your deliveries, track orders in real-time, and optimize your delivery route for maximum efficiency…",
                      style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 20,
                          color: Colors.black87),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.03),
                  // Track now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ParivartanXDeliveryLogin()),
                        );
                      },
                      child: Text(
                        "Track now",
                        style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
