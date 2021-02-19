import 'dart:ui';

class OrderCardModel {
  double price;
  String title;
  String subtitle;
  bool isFavorite;
  Color color;
  int quantity;
  OrderCardModel(
      {this.color,
      this.subtitle,
      this.title,
      this.price,
      this.quantity,
      this.isFavorite = false});
}
