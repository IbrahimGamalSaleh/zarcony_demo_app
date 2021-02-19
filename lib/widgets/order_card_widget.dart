import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zarconydemoapp/models/order_card.dart';
import 'package:zarconydemoapp/screens/category_screen.dart';
import 'package:zarconydemoapp/tools/size_config.dart';

class OrderCard extends ConsumerWidget {
  OrderCardModel order;
  OrderCard({this.order});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final orderProvider = watch(orderModel);
    return Container(
      height: SizeConfig.heightScreenSize * 0.13,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: order.color,
                        borderRadius: BorderRadius.circular(10)),
                    height: double.infinity,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(order.subtitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey)),
                          Text(
                            "\$${order.price}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        orderProvider.decrementQuantity(order);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffb0eafd),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.remove,
//                        size: 50,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      height: 50,
                      child: Text("${order.quantity}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                    GestureDetector(
                      onTap: () {
                        orderProvider.incrementQuantity(order);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xffb0eafd),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.add,
//                        size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
