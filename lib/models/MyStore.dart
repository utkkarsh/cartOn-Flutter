import 'dart:convert';

import 'package:CartOn/models/CampaignAd.dart';
import 'package:CartOn/models/ShopCategory.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/models/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/models/shopProd.dart';
import 'package:latlng/latlng.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/DefaultFunctions.dart';

class MyStore extends ChangeNotifier{

  List cartList = [];
  List categoryList = [];
  List campaignPromoList = [];
  List shopList = [];
  List shopItem = [];
  LatLng currentLocation = LatLng(27.1929868,77.9652066);
  String addressString = "";
  bool viewTypeBool=false;
  String viewTypeString="grid";
  // final List<ShopItem> _cartList = [];

  checkIteminCart(ShopItem item)
  {
    var contain = cartList.where((element) => element.productNo == item.productNo);

    if(contain.isNotEmpty)
    {
      return true;
    }
    else
      {
        return false;
      }
  }

  addtoCart(ShopItem item)
  {
    // Check item already in cart , If Yes, do not re-add only increment the count of qty.
    // If item is not present add the item to the cart.

    if(checkIteminCart(item))
      { var containIndex = getItemIndexInCart(item);
        // var currentQty = int.parse(cartList[containIndex].productQty);
        // currentQty+=1;
        // cartList[containIndex].productQty= currentQty.toString();
      print('Purchase Limit is'+ item.purchaseLimitOnQty);
        if( cartList[containIndex].itemCartQty < int.parse(item.purchaseLimitOnQty)){
          cartList[containIndex].itemCartQty += 1;
        }
        print(cartList[containIndex].productQty);
        print("Item Already Present");
      }
    else
      {
        cartList.add(item);
        // _cartList.add(item);
        // cartList.add(item.toJson());
      }

    notifyListeners();
  }

  getItemIndexInCart(ShopItem item) {
  return cartList.indexWhere((element) => element.productNo == item.productNo);
  }

  getItemsinCart()
  { return cartList.length; }

  getUniqueShopsFromCart(){

    List items=[];

    cartList.forEach((element) {
      print(element.toJson());
      items.add(element.toJson());
    });

    final uniqueShops = items.groupBy((m) => m["shopID"]);
    List listofShops = uniqueShops.keys.toList();
    return listofShops;
  }

  getItemsFromCart() => cartList.toList();

  gettotalItemsinCart() => cartList.fold(0, (previousValue, element) => previousValue + element.itemCartQty);

  clearCart() {
    cartList.length=0;
    notifyListeners();
  }

  modifyItemQtyinCart (index, type)
  {
    if(type =="ADD")
      {
        if( cartList[index].itemCartQty < int.parse(cartList[index].purchaseLimitOnQty))
        {
          cartList[index].itemCartQty+=1;
        }
      }
    else
      {
        if (type=="REMOVE")
          { cartList.removeAt(index); }
        else if(cartList[index].itemCartQty == 1)
          { cartList.removeAt(index); }
        else
          { cartList[index].itemCartQty-=1; }
      }
    notifyListeners();
  }

  //Method to Get qty for single item in cart.
  getItemQtyInCart (index) =>   cartList[index].itemCartQty;

  //This method calculates the total Value of cart.
  getCartTotal () => cartList.fold(0, (previousValue, element) => previousValue + element.itemCartQty* double.parse(element.productPrice));

  getDeliveryFee () => 0;


  getTotalPayValue() {
    return getCartTotal() + getDeliveryFee();
  }
  //  Category List
  
 // saveCategoryList(ShopCategory data)
 // {
 //   categoryList.add(data);
 //   notifyListeners();
 //   // print(categoryList.length);
 // }

 getCategoryList()=> categoryList;
 // getCategoryListLength()=> categoryList.length;
  getCategoryListLength()
  { return categoryList.length; }


  addtoCategoryList(List<ShopCategory> category)
  {
    // Check item already in cart , If Yes, do not re-add only increment the count of qty.
    // If item is not present add the item to the cart.
      categoryList.clear();
      print(categoryList.length);
      categoryList.addAll(category);
      // _cartList.add(item);
      // cartList.add(item.toJson());
    notifyListeners();
  }

  updateLocation (LatLng current) async
  {
    print('Saving Location ' +current.latitude.toString() +' , '+ current.longitude.toString());
    currentLocation.longitude = current.longitude;
    currentLocation.latitude = current.latitude;
    await addCustomerLocation(current);
    notifyListeners();
  }

  getSavedLocationFromStore() async{
    return await getCustomerLocation();
  }

  updateAddress (String inputaddressString, Address address) async
  {
    print('Saving Address ' + inputaddressString);
    addressString=inputaddressString;
    await addCustomerAddress(jsonEncode(address.toJson()));
    // await getCustomerAddress();
    await addCustomerLocation(LatLng(double.parse(address.lat),double.parse(address.long)));
    notifyListeners();
  }

  getAddressString() async{
    return addressString!=""?addressString: await getCustomerAddressInString();
  }

  addtoShopList(List<Shop> shops)
  {
    // Check item already in cart , If Yes, do not re-add only increment the count of qty.
    // If item is not present add the item to the cart.
    shopList.clear();
    print(shopList.length);
    shopList.addAll(shops);
    addtoItemList(shops);
    print('Item Length');
    print(shopItem.length);
    notifyListeners();
  }

  clearShopList() {
    shopList.clear();
    notifyListeners();
  }

  clearItemList() {
    shopItem.clear();
    notifyListeners();
  }

  getShopListLength()
  { return shopList.length; }

  getShopList()=> shopList;

  getShopName(String shopId) {
    // print(shopId);
   var contain = shopList.where((element) => element.shopId == shopId.toString()).toList();
   Shop shop = contain[0];
    // var contain = shopList.where((element) => element.shopID == shopId);
   return shop.shopName;
  }

  getShopDeliveryLimit(String shopId)
  {
    var contain = shopList.where((element) => element.shopId == shopId.toString()).toList();
    Shop shop = contain[0];
    // var contain = shopList.where((element) => element.shopID == shopId);
    return shop.minDeliveryPrice;
  }

  getShopAddress(String shopId) {
    // print(shopId);
    var contain = shopList.where((element) => element.shopId == shopId.toString()).toList();
    Shop shop = contain[0];
    // var contain = shopList.where((element) => element.shopID == shopId);
    return shop.shopCompleteAddress;
  }

  addtoItemList(List<Shop> shops)
  {
    shopItem.clear();
    shops.forEach((element) {
      shopItem.addAll(element.items);
    });
    // notifyListeners();
  }

  changeViewType()
  {
    if(viewTypeBool==true)
      {
        viewTypeBool=false;
        viewTypeString='grid';
      }
    else{
      viewTypeBool=true;
      viewTypeString='list';
    }
    print('MY_STORE: View Type Changed to ' + viewTypeString);
    notifyListeners();
  }

  getCustomerName() async{
    var list = <String>[];
    String custName = "";
    list = await getCustomerDetails();
    print(list);
    if ( list.length > 1)
    {
      custName = list[0];
    }
    return custName;
  }

  getCampaignList()=> campaignPromoList;
  // getCategoryListLength()=> categoryList.length;
  getCampaignListLength()
  { return campaignPromoList.length; }


  addtoCampaignList(List<CampaignAd> promos)
  {
    // Check item already in cart , If Yes, do not re-add only increment the count of qty.
    // If item is not present add the item to the cart.
    campaignPromoList.clear();
    print(campaignPromoList.length);
    campaignPromoList.addAll(promos);
    // _cartList.add(item);
    // cartList.add(item.toJson());
    notifyListeners();
  }

  priceAtShopLevel() {

    List items=[];
      cartList.forEach((element) {
        print('I am in');
        print(element.toJson());
        items.add(element.toJson());
      });

      final uniqueShops = items.groupBy((m) => m["shopID"]);
      List listofShops = uniqueShops.keys.toList();
      List listofShopItems = uniqueShops.values.toList();
      print('Debugging - MET testMethod');
      print(listofShops);

      // Temporary Variable For Calculating Price by Shop Level.
      Map<String,double> priceShopLevel = {};
      for( var data in listofShopItems) {
        var orderSplitTotal = data.fold(0, (previousValue, element) =>
        previousValue + int.parse(element["itemCartQty"]) *
            double.parse(element["productPrice"]));
        print(orderSplitTotal);
        priceShopLevel[data[0]["shopID"]]=orderSplitTotal;
      }

      return priceShopLevel;
  }

  checkValidityofPrices() {
    Map<String,String> errorMsg={};
    Map<String,double> priceShopLevel = priceAtShopLevel();
    priceShopLevel.forEach((key, value) {
      if(value<int.parse(getShopDeliveryLimit(key)))
        {
             errorMsg[getShopName(key)]=getShopDeliveryLimit(key);
        }
    });
    // print(errorMsg);
    return errorMsg;
  }
}