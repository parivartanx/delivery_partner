import 'package:delivery_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class ParivartanXDeliveryLogin extends StatefulWidget {
  const ParivartanXDeliveryLogin({super.key});

  @override
  State<ParivartanXDeliveryLogin> createState() => _ParivartanXDeliveryLoginState();
}

class _ParivartanXDeliveryLoginState extends State<ParivartanXDeliveryLogin> {
  @override
  Widget build(BuildContext context) {
    // Dynamic sizing
    final size = MediaQuery.of(context).size;
    final double padding = size.width * 0.08;
    final double imageSize = size.width * 0.3;
    final double buttonHeight = size.height * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Network image
                  Container(
                    height: imageSize,
                    width: imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade50,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2016/04/01/09/28/delivery-1296230_1280.png', // Replace with your image URL
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: imageSize * 0.6, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    'ParivartanX Delivery',
                    style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Password',
                      style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerRight,
                      ),
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(fontSize: size.width * 0.035, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: size.width * 0.05, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
