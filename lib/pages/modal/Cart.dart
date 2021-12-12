import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/modal/Grocery.dart';

class Cart {
  Grocery grocery;
  int quantity;

  Cart({this.grocery, this.quantity});
}

class Carts {
  ShopItem grocery;
  int quantity;
  Carts({this.grocery, this.quantity});
}

