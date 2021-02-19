import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zarconydemoapp/models/order_card.dart';
import 'package:zarconydemoapp/screens/category_screen.dart';
import 'package:zarconydemoapp/tools/size_config.dart';

class FavoriteCard extends StatelessWidget {
  OrderCardModel order;
  FavoriteCard({this.order});
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      alignment: Alignment.centerLeft,
      width: SizeConfig.widthScreenSize * 0.8,
      height: SizeConfig.heightScreenSize * 0.1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: order.color,
                    borderRadius: BorderRadius.circular(10)),
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: -5,
                      left: -5,
                      child: Consumer(builder: (context, watch, build) {
                        final orderProvider = watch(orderModel);
                        return GestureDetector(
                          onTap: () {
                            print('sdfdsf ');
                            if (order.isFavorite) {
                              order.isFavorite = false;
                              orderProvider.removeFromFavorite(order);
                            } else {
                              order.isFavorite = true;
                              orderProvider.addToFavorite(order);
                            }
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              order.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 10,
                              color:
                                  order.isFavorite ? Colors.red : Colors.black,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${order.title}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${order.subtitle}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                        ),
                        Text(" 15 Minute Away"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "\$${order.price} ",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "\$15",
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                    ])),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
