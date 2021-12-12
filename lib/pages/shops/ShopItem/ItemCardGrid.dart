import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/pages/grocery_list/detail/AddQuatityView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:provider/provider.dart';

class ItemCardGrid extends StatefulWidget {
  final ShopItem item;

  ItemCardGrid({this.item});

  @override
  _ItemCardGridState createState() => _ItemCardGridState();
}

class _ItemCardGridState extends State<ItemCardGrid> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    widget.item.shopName=store.getShopName(widget.item.shopID);
    widget.item.shopAddress= store.getShopAddress(widget.item.shopID);

    return Card(
      borderOnForeground:true,
      elevation: Constant.CARD_ELEVATION,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(Routers.ITEM_DETAIL,
            arguments: ParamTypeItem(
                item: widget.item, heroId: widget.item.hashCode)),
        child: Container(
          padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW/2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Hero(
                          tag: widget.item.hashCode,
                          child:
                          Image (
                            height: 90,
                            width: 100,
                            image: NetworkImage(widget.item.productImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),


                    // Hero(
                    //   tag: widget.item.hashCode,
                    //   child: Image(
                    //     image: NetworkImage(widget.item.productImage),
                    //     width: 100,
                    //     height: 90,
                    //     fit: BoxFit.cover,
                    //   )
                    //
                    //   // Image.asset(
                    //   //   widget.item.productImage,
                    //   //   width: 100,
                    //   //   height: 90,
                    //   //   fit: BoxFit.contain,
                    //   // ),
                    // ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    // height: 30,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constant.BORDER_RADIUS))),
                      elevation: Constant.CARD_ELEVATION,
                      // margin: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                      color: Pallete.countViewColor,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2,
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2),
                          child: TextWidget(
                            text: widget.item.productQty +' '+widget.item.productUnit,
                            fontColor: Pallete.itemSizeColor,
                            fontFamily: Constant.ROBOTO_MEDIUM,
                            fontSize: Constant.SUB_TEXT_FONT,
                          )),
                    ),
                  ),
                ],
              ),



              Expanded(
                // flex: 1,
                child: TextWidget(
                  text: widget.item.productName,
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
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [TextWidget(
                    text: "${Constant.RUPEE} ${widget.item.productPrice}",
                    fontColor: Pallete.itemPriceColor,
                    fontSize: Constant.TEXT_FONT,
                    fontFamily: Constant.ROBOTO_MEDIUM,
                  ),

                  // TextWidget(
                  //   text: widget.item.productQty +' '+widget.item.productUnit,
                  //   fontColor: Pallete.itemSizeColor,
                  //   fontFamily: Constant.ROBOTO_MEDIUM,
                  //   fontSize: Constant.SUB_TEXT_FONT,
                  // )
                ],),
                ),
              SizedBox(
                height: 3,
              ),

              Center(
                child: SizedBox(
                  height: 35,
                  width: 105,

                  child: store.checkIteminCart(widget.item) ? AddQuantityView(
                      modifyQuantity: null,
                      viewSize: 35,
                      isFromCart:false,
                      index: store.getItemIndexInCart(widget.item)) :
                  FlatButton(
                      child: Text(
                        'Add Item',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize:  Constant.BUTTON_FONT - 1,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                        ),
                      ),
                      // highlightedBorderColor: Colors.green,
                      color: Pallete.addItemButtonColor1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color:Colors.transparent)),
                      onPressed: () {
                        store.addtoCart(widget.item);

                        // store.getCart();
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
