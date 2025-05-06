import 'package:delivery_app/core/widgets/orderdetailswidgets/app_bar.dart';
import 'package:delivery_app/core/widgets/orderdetailswidgets/customer_card.dart';
import 'package:delivery_app/core/widgets/orderdetailswidgets/mark_delivery_button.dart';
import 'package:delivery_app/core/widgets/orderdetailswidgets/order_info.dart';
import 'package:delivery_app/core/widgets/orderdetailswidgets/order_item.dart';
import 'package:flutter/material.dart';

class OrderDetailsWithoutId extends StatelessWidget {
  const OrderDetailsWithoutId({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: ProfileAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerCard(),
            SizedBox(height: 20),
            OrderInfoCard(),
            SizedBox(height: 20),
            OrderItemsCard(),
            SizedBox(height: 30),
            MarkDeliveredButton(),
          ],
        ),
      ),
    );
  }
}
