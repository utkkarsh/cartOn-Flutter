import 'dart:io';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/shops/list/ShopCard.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/Shop.dart';

// ignore: must_be_immutable
class ShopViewList extends StatefulWidget {
  List listShop = [];
  bool isFromHome = false;
  final String category;
  ShopViewList({this.listShop, this.isFromHome, this.category}) : super();

  @override
  _ShopViewListState createState() => _ShopViewListState();
}

class _ShopViewListState extends State<ShopViewList> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    List extractedData = store.shopList;
    if (widget.category!=null)
      {
        extractedData = widget.listShop;
            // store.shopList.where((element) => element.shopCategory.toLowerCase() == widget.category.toLowerCase()).toList();
      }
    return  Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: extractedData.length,
            itemBuilder: (BuildContext context, int index) {
              return ShopCard(shop: extractedData[index],forceCategoryName: widget.category,);
            }
        )
    );
  }
}
