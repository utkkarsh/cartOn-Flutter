import 'package:flutter/cupertino.dart';
import 'package:CartOn/models/shopItem.dart';

class MyBasket extends ChangeNotifier{
List cartList = [];

addtoCart(ShopItem product)
{  cartList.add(product);
   notifyListeners();
}

getCart()
{
  print(cartList.toString()) ;
}

}