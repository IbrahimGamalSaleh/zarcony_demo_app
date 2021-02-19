import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/blend_mask.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zarconydemoapp/screens/category_screen.dart';
import 'package:zarconydemoapp/screens/favorite_screen.dart';
import 'package:zarconydemoapp/screens/orders_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: currentIndex == 0
            ? CategoryScreen()
            : currentIndex == 2
                ? FavoriteScreen()
                : currentIndex == 3
                    ? OrdersScreen()
                    : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffee6a61),
        onPressed: () {},
        child: Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance,
              ),
              label: 'Grocery'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none,
            ),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.favorite_border),
                Positioned(
                    top: 0,
                    child: Consumer(builder: (context, watch, build) {
                      final length = watch(orderModel).favoriteList.length;
                      return length > 0
                          ? Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "$length",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            )
                          : SizedBox.shrink();
                    }))
              ],
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(
                  Icons.wallet_giftcard,
                ),
                Positioned(
                    top: 0,
                    child: Consumer(builder: (context, watch, build) {
                      final length = watch(orderModel).ordersList.length;
                      return length > 0
                          ? Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "$length",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            )
                          : SizedBox.shrink();
                    }))
              ],
            ),
            label: 'Orders',
          ),
        ],
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        selectedItemColor: Color(0xffee6a61),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
