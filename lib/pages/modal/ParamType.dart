import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
// import 'package:CartOn/pages/modal/Orders.dart';
// import 'package:CartOn/pages/modal/Shop.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/models/ShopProd.dart';

class ParamType {
  String title = "";
  List category = [];
  Grocery grocery = Grocery();
  // ignore: missing_required_param
  Orders1 orders = Orders1();
  int heroId = 0;

  ParamType({this.title, this.grocery, this.heroId, this.orders, this.category});
}

class ParamTypeShop {
  String forcedCategory = "";
  Shop shop = Shop();
  // ignore: missing_required_param
  Orders1 orders = Orders1();
  int heroId = 0;
  ParamTypeShop({this.forcedCategory, this.shop, this.heroId, this.orders});
}

class ParamTypeItem {
  String title = "";
  ShopItem item = ShopItem();
  // ignore: missing_required_param
  Orders1 orders = Orders1();
  int heroId = 0;
  ParamTypeItem({this.title, this.item, this.heroId, this.orders});
}

class ParamTypeProduct {
  String title = "";
  Product item = Product();
  // ignore: missing_required_param
  Orders1 orders = Orders1();
  int heroId = 0;
  ParamTypeProduct({this.title, this.item, this.heroId, this.orders});
}
