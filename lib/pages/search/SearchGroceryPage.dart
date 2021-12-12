import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewList.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
import 'package:CartOn/pages/search/SearchEmptyPage.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/widgets/SearchWidget.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemList.dart';

class SearchGroceryPage extends StatefulWidget {
  @override
  _SearchGroceryPageState createState() => _SearchGroceryPageState();
}

class _SearchGroceryPageState extends State<SearchGroceryPage> {
  final String textSearch = "";
  final List<Grocery> listGrocery = Helper.getVegetableList();
  List<Grocery> listData = [];
  List<ShopItem> listItems = [];

  void onSearchPackPress() {
    Navigator.of(context).pop();
  }

  void onSearchTyping(String data) {
    // print(data);
    listData.clear();
    if (data != '') {
      List<Grocery> listData1 = [];
      for (Grocery item in listGrocery) {
        if (item.name.toLowerCase().contains(data.toLowerCase())) {
          print(item.name);
          listData1.add(item);
        }
      }
      setState(() {
        listData.addAll([]);
        listData.addAll(listData1);
      });
    } else {
      setState(() {
        listData.addAll([]);
      });
    }
  }

  void onSearchTyping2(String data, storeItemList) {
    // print(data);
    listItems.clear();
    if (data != '') {
      List<ShopItem> listData1 = [];
      for (ShopItem item in storeItemList) {
        if (item.productName.toLowerCase().contains(data.toLowerCase())) {
          print(item.productName);
          listData1.add(item);
        }
      }
      setState(() {
        listItems.addAll([]);
        listItems.addAll(listData1);
      });
    } else {
      setState(() {
        listItems.addAll([]);
      });
    }
  }

  void onSearchClear() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: SearchWidget(
        textSearch: textSearch,
        onPress: onSearchPackPress,
        onClear: onSearchClear,
        onSearch: onSearchTyping2,
        context: context,
      ),
      body: listItems.length == 0
          ? SearchEmptyPage()
          : SingleChildScrollView(child: ItemList(itemList: listItems,listView: 'list',isFromSearch: true,)),
    );
  }
}
