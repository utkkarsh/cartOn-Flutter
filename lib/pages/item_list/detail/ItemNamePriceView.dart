import 'package:CartOn/models/MyStore.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/grocery_list/detail/AddQuatityView.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ItemNamePriceView extends StatefulWidget {
  final ShopItem item;

  ItemNamePriceView({this.item}) : super();

  @override
  _ItemNamePriceViewState createState() => _ItemNamePriceViewState();
}

class _ItemNamePriceViewState extends State<ItemNamePriceView> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(
          Constant.PADDING_VIEW,
          Constant.HALF_PADDING_VIEW,
          Constant.PADDING_VIEW,
          Constant.HALF_PADDING_VIEW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  text: widget.item.productName,
                  fontColor: Pallete.textColor,
                  fontSize: Constant.APP_BAR_TEXT_FONT,
                  fontFamily: Constant.ROBOTO_MEDIUM,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                height: Constant.HALF_PADDING_VIEW,
              ),
            ],
          ),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW / 2,
          ),
          Row(
            children: [
              Expanded(
                child: TextWidget(
                  text: "₹ ${widget.item.productPrice}",
                  fontColor: Pallete.itemDescColor,
                  fontSize: Constant.PRICE_TEXT_FONT,
                  fontFamily: Constant.ROBOTO_MEDIUM,
                ),
              ),
              store.checkIteminCart(widget.item) ?
              AddQuantityView(
                modifyQuantity: null,
                viewSize: 30,
                  isFromCart:false,
                  index: store.getItemIndexInCart(widget.item)
              ) : Container()
            ],
          ),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW,
          ),
        ],
      ),
    );
  }
}
