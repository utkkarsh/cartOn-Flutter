import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';

class GroceryItem extends StatefulWidget {
  final Grocery grocery;

  GroceryItem({this.grocery});

  @override
  _GroceryItemState createState() => _GroceryItemState();
}

class _GroceryItemState extends State<GroceryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground:true,
      elevation: Constant.CARD_ELEVATION,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(Routers.GROCERY_DETAIL,
            arguments: ParamType(
                grocery: widget.grocery, heroId: widget.grocery.hashCode)),
        child: Container(
          padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Hero(
                    tag: widget.grocery.hashCode,
                    child: Image.asset(
                      widget.grocery.image,
                      width: 100,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextWidget(
                  text: widget.grocery.name,
                  fontColor: Pallete.itemDescColor,
                  fontSize: Constant.TEXT_FONT,
                  fontFamily: Constant.ROBOTO_MEDIUM,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Expanded(
                flex: 2,
                child: TextWidget(
                  text: "${Constant.RUPEE} ${widget.grocery.price}",
                  fontColor: Pallete.itemPriceColor,
                  fontSize: Constant.TEXT_FONT,
                  fontFamily: Constant.ROBOTO_MEDIUM,
                ),
              ),
              SizedBox(
                height: 1,
              ),

              Expanded(
                flex: 2,
                child: TextWidget(
                  text: widget.grocery.size,
                  fontColor: Pallete.textSubTitle,
                  fontSize: Constant.SUB_TEXT_FONT,
                  fontFamily: Constant.ROBOTO_REGULAR,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
