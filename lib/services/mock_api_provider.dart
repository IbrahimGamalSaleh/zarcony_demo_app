import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zarconydemoapp/models/order_card.dart';

final colors = [
  0xff21114b,
  0xfffec8bd,
  0xffd93e11,
  0xff000000,
  0xff000000,
  0xff28d193,
  0xffff9dc2,
  0xfffad96d,
  0xffe0e0e0,
  0xff929294,
];

class MockApi {
  Future<List<OrderCardModel>> getOrderCardModel(int length) async {
    await Future.delayed(Duration(seconds: 1));
    List<OrderCardModel> orderList = [];

    for (int i = 0; i < length; i++) {
      int value = (i + length) % 10;
      orderList.add(OrderCardModel(
          quantity: 1,
          price: 41,
          subtitle: "steak subtitle $i ",
          title: "Steak $i",
          color: Color(colors[value])));
    }
    return orderList;
  }

  Future<List<OrderCardModel>> getFavoriteCardModel(int length) async {
    await Future.delayed(Duration(seconds: 1));
    List<OrderCardModel> orderList = [];

    for (int i = 0; i < length; i++) {
      int value = (i + length) % 10;
      orderList.add(OrderCardModel(
          quantity: 1,
          price: 41,
          subtitle: "Pieces $i ",
          title: "Sammer sun ice cream back $i",
          color: Color(colors[value])));
    }
    return orderList;
  }
}

final mockFetchCategories = FutureProvider.autoDispose
    .family<List<OrderCardModel>, int>((ref, length) async {
  return MockApi().getOrderCardModel(length);
});

final mockFetchDeals = FutureProvider.autoDispose
    .family<List<OrderCardModel>, int>((ref, length) async {
  return MockApi().getFavoriteCardModel(length);
});
