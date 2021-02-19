import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zarconydemoapp/models/order_card.dart';
import 'package:zarconydemoapp/services/mock_api_provider.dart';
import 'package:zarconydemoapp/services/orders_provider.dart';
import 'package:zarconydemoapp/tools/size_config.dart';
import 'package:zarconydemoapp/widgets/favorite_card_widget.dart';

final orderModel = ChangeNotifierProvider((ref) => OrderProvider());

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier * 2),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.heightMultiplier * 2),
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
            decoration: BoxDecoration(
                color: Color(0xfff5f7f9),
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.heightMultiplier * 2,
                vertical: SizeConfig.heightMultiplier * 2),
            child: Row(
              children: [
                Container(width: 30, child: Icon(Icons.search)),
                Text("Search in thousands of products",
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          Container(
            height: SizeConfig.heightScreenSize * 0.1,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: SizeConfig.widthScreenSize * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffd7d7d7))),
                  child: ListTile(
                    title: Text(
                      "Home Address",
                      style: TextStyle(fontSize: 10),
                    ),
//                    isThreeLine: true,
                    subtitle: Text(
                      "Moustafa St.No:2\nStreet x12",
                      style: TextStyle(fontSize: 10),
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffcccccc),
                          borderRadius: BorderRadius.circular(10)),
                      width: width / 6,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.widthScreenSize * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffd7d7d7))),
                  child: ListTile(
                    title: Text(
                      "Home Address",
                      style: TextStyle(fontSize: 10),
                    ),
//                    isThreeLine: true,
                    subtitle: Text(
                      "Moustafa St.No:2\nStreet x12",
                      style: TextStyle(fontSize: 10),
                    ),
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffcccccc),
                          borderRadius: BorderRadius.circular(10)),
                      width: width / 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Explor by Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "See All(36)",
                )
              ],
            ),
          ),
          Consumer(builder: (context, watch, build) {
            final categoryProvider = watch(mockFetchCategories(5));
            return Container(
              height: SizeConfig.heightScreenSize * 0.15,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: categoryProvider.when(
                  data: (categories) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildItem(
                            orderCardModel: categories[index],
                            context: context);
                      },
                      itemCount: categories.length,
                    );
                  },
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (error, stack) => Center(
                        child: Text('Error : $error'),
                      )),
            );
          }),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Deals of day",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Consumer(builder: (context, watch, build) {
              final dealsProvider = watch(mockFetchDeals(5));

              return dealsProvider.when(
                  data: (deals) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return FavoriteCard(
                          order: deals[index],
                        );
                      },
                      itemCount: deals.length,
                    );
                  },
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                  error: (error, stack) => Center(
                        child: Text('Error : $error'),
                      ));
            }),
          ),
        ],
      ),
    );
  }

  Widget buildItem({OrderCardModel orderCardModel, BuildContext context}) {
    return GestureDetector(
      onTap: () {
        context.read(orderModel).addOrder(orderCardModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: SizeConfig.heightMultiplier * 10,
              width: SizeConfig.widthScreenSize * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: orderCardModel.color,
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
            ),
            Text(orderCardModel.title)
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
