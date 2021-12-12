import 'package:flutter/material.dart';
import 'package:CartOn/pages/shops/list/ShopCard.dart';
import 'package:CartOn/pages/shops/list/ShopCard.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';

// ignore: must_be_immutable
class ShopViewHorizontalList extends StatefulWidget {
  List<Shop> listShop = [];
  bool isFromHome = false;

  ShopViewHorizontalList({this.listShop, this.isFromHome}) : super();

  @override
  _ShopViewHorizontalListState createState() =>
      _ShopViewHorizontalListState();
}

class _ShopViewHorizontalListState extends State<ShopViewHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: ListView.builder(
              // physics: widget.isFromHome == null
              //     ? AlwaysScrollableScrollPhysics()
              //     : widget.isFromHome
              //         ? NeverScrollableScrollPhysics()
              //         : AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemExtent: 220,
              itemBuilder: (BuildContext context, int index) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ShopCard(shop: widget.listShop[index]),
                ),
              ),
              itemCount: widget.listShop.length,
            ),
    );
  }
}
