import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zarconydemoapp/models/order_card.dart';
import 'package:zarconydemoapp/screens/category_screen.dart';
import 'package:zarconydemoapp/widgets/order_card_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffeb6363)),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            'Moustafa st.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cart",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Consumer(builder: (context, watch, build) {
                    final ordermodel = watch(orderModel);
                    return ordermodel.totalPrice > 0
                        ? Text(
                            "tatal price : \$${ordermodel.totalPrice}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        : SizedBox.shrink();
                  }),
                ],
              ),
            ),
            Consumer(builder: (context, watch, build) {
              final ordermodel = watch(orderModel);
              return Column(
                children: [
                  ...ordermodel.ordersList.map((e) {
                    return OrderCard(order: e);
                  })
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
