import 'package:flutter/cupertino.dart';
import 'package:zarconydemoapp/models/order_card.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderCardModel> _ordersList = [];
  List<OrderCardModel> _favoriteList = [];

  double _totalPrice = 0;

  get totalPrice => _totalPrice;
  List<OrderCardModel> get ordersList => _ordersList;
  List<OrderCardModel> get favoriteList => _favoriteList;

  addOrder(OrderCardModel value) {
    final found = _ordersList.indexOf(value);
    if (found != -1) {
      incrementQuantity(value);
    } else {
      _ordersList.add(value);
      _totalPrice += value.price;

      print('_totalPrice :$_totalPrice,value :$value');
      notifyListeners();
    }
  }

  addToFavorite(OrderCardModel value) {
    final found = _favoriteList.indexOf(value);
    if (found == -1) {
      value.isFavorite = true;
      _favoriteList.add(value);
      notifyListeners();
    }
  }

  removeFromFavorite(OrderCardModel value) {
    final found = _favoriteList.indexOf(value);
    if (found != -1) {
      _favoriteList.remove(value);
      notifyListeners();
    }
  }

  incrementQuantity(element) {
    int index = _ordersList.indexOf(element);
    OrderCardModel orderCardModel = _ordersList[index];
    _ordersList[index].quantity += 1;

    _totalPrice += orderCardModel.price;
    notifyListeners();
  }

  decrementQuantity(element) {
    int index = _ordersList.indexOf(element);
    OrderCardModel orderCardModel = _ordersList[index];
    if (orderCardModel.quantity > 1) {
      _ordersList[index].quantity -= 1;
    } else {
      _ordersList.remove(orderCardModel);
    }
    _totalPrice -= orderCardModel.price;
    notifyListeners();
  }
}
