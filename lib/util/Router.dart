import 'package:CartOn/pages/account/faq.dart';
import 'package:CartOn/pages/category_wid/CategoryDetailPage.dart';
import 'package:CartOn/pages/checkout/checkout.dart';
import 'package:CartOn/pages/checkout/checkoutComplete.dart';
import 'package:CartOn/pages/orders/ProcessTimeline.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/account/AccountsPage.dart';
import 'package:CartOn/pages/account/ModifyAddress.dart';
import 'package:CartOn/pages/account/faq.dart';
import 'package:CartOn/pages/auth/LandingPage.dart';
import 'package:CartOn/pages/auth/LoginPage.dart';
import 'package:CartOn/pages/auth/SignupPage.dart';
import 'package:CartOn/pages/auth/VerifyOTPPage.dart';
import 'package:CartOn/pages/cart/CartDetailsPage.dart';
import 'package:CartOn/pages/category_wid/CategoryList.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryDetailPage.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryListPage.dart';
import 'package:CartOn/pages/home/HomePage.dart';
import 'package:CartOn/pages/home/TabHomePage.dart';
import 'package:CartOn/pages/item_list/detail/ItemDetailPage.dart';
import 'package:CartOn/pages/orders/OrderDetailsPage.dart';
import 'package:CartOn/pages/orders/OrdersPage.dart';
import 'package:CartOn/pages/search/SearchGroceryPage.dart';
import 'package:CartOn/pages/shops/detail/ShopDetailPage.dart';
import 'package:CartOn/pages/shops/list/ShopListPage.dart';

class Routers {
  static const LANDING = "./landing";
  static const LOGIN = "./login";
  static const OTP = "./otp";
  static const TABS = "./tabs";
  static const SEARCH = "./search";
  static const HOME = "./home";
  static const GROCERY_LIST = "./groceryList";
  static const GROCERY_DETAIL = "./groceryDetail";
  static const ORDERS = "./orders";
  static const ORDER_DETAILS = "./orderDetail";
  static const CART_DETAILS = "./cartDetail";
  static const ACCOUNTS = "./accounts";
  static const SIGN_UP = "./sign-up";
  static const MAP_ADDRESS = "./address";
  static const CATEGORY_LIST = "./categoryList";
  static const SHOP_LIST = "./shopList";
  static const SHOP_DETAILS = "./shopDetails";
  static const ITEM_DETAIL = "./itemDetail";
  static const CATEGORY_DETAIL = "./categoryDetail";
  static const CHECKOUT = "./checkout";
  static const CHECKOUT_COMPLETED = "./checkoutCompleted";
  static const FAQ = "./faq";


  static Map<String, WidgetBuilder> getRoutePage() {
    return <String, WidgetBuilder>{
      Routers.LANDING: (BuildContext context) => LandingPage(),
      Routers.LOGIN: (BuildContext context) => LoginPage(),
      Routers.SIGN_UP: (BuildContext context) => RegistrationPage(),
      Routers.OTP: (BuildContext context) => VerifyOTPPage(),
      Routers.TABS: (BuildContext context) => TabHomePage(),
      Routers.SEARCH: (BuildContext context) => SearchGroceryPage(),
      Routers.HOME: (BuildContext context) => HomePage(),
      Routers.GROCERY_LIST: (BuildContext context) => GroceryListPage(),

      Routers.CATEGORY_LIST: (BuildContext context) => CategoryListPage(),
      Routers.CATEGORY_DETAIL: (BuildContext context) => CategoryDetailPage(),

      Routers.SHOP_LIST: (BuildContext context) => ShopListPage(),
      Routers.SHOP_DETAILS: (BuildContext context) => ShopDetailPage(),
      Routers.ITEM_DETAIL: (BuildContext context) => ItemDetailPage(),
      Routers.GROCERY_DETAIL: (BuildContext context) => GroceryDetailPage(),
      Routers.ORDERS: (BuildContext context) => OrdersPage(),
      Routers.ORDER_DETAILS: (BuildContext context) => OrderDetailsPage(),
      Routers.CART_DETAILS: (BuildContext context) => CartDetailsPage(),
      Routers.ACCOUNTS: (BuildContext context) => AccountsPage(),
      Routers.MAP_ADDRESS: (BuildContext context) => ModifyAddress(),
      Routers.CHECKOUT: (BuildContext context) => Checkout(),
      Routers.CHECKOUT_COMPLETED: (BuildContext context) => CheckoutComplete(),
      Routers.FAQ: (BuildContext context) => FAQs(),
    };
  }
}
