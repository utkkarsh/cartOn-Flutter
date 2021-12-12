import 'package:CartOn/pages/grocery_list/detail/AddQuatityView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/Cart.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/pages/modal/Grocery.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/ShopProd.dart';

class ItemSearchCardList extends StatefulWidget {
  final ShopItem item;      // Details of specific item which needs to be rendered in ItemCard
  final bool isFromSearch;  // if list is called from search view then shop name needs to be displayed in ItemCard

  ItemSearchCardList({this.item, this.isFromSearch});
  @override
  _ItemSearchCardListState createState() => _ItemSearchCardListState();
}

class _ItemSearchCardListState extends State<ItemSearchCardList> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    widget.item.shopName=store.getShopName(widget.item.shopID);
    widget.item.shopAddress= store.getShopAddress(widget.item.shopID);
    return Container(
      height: 140,
      child: Card(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox(
                        width:150,
                        height: 130,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)
                          ),
                          child: Hero(
                            tag: widget.item.hashCode,
                            child:
                            // Image.asset(
                            //                 widget.item.productImage,
                            //                 width: 200,
                            //                 height: 100,
                            //                 fit: BoxFit.fitHeight,
                            //               ),
                            Image (
                              height: 200,
                              width: 100,
                              image: NetworkImage(widget.item.productImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ),
                  ),
                  // SizedBox(width: 5,),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            flex: 1,
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
                          widget.isFromSearch==true ?
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Constant.BORDER_RADIUS))),
                            elevation: Constant.CARD_ELEVATION,
                            // margin: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                            color: Colors.blue[100],
                            child: Container(
                                padding: EdgeInsets.fromLTRB(
                                    Constant.HALF_PADDING_VIEW,
                                    Constant.HALF_PADDING_VIEW / 2,
                                    Constant.HALF_PADDING_VIEW,
                                    Constant.HALF_PADDING_VIEW / 2),
                                child: TextWidget(
                                  text: 'From : ' + store.getShopName(widget.item.shopID).toString() ,
                                  fontColor: Pallete.itemSizeColor,
                                  fontFamily: Constant.ROBOTO_MEDIUM,
                                  fontSize: Constant.SUB_TEXT_FONT,
                                )),
                          ): Container(),
                          SizedBox(
                            height: 1,
                          ),

                          SizedBox(
                            height: 1,
                          ),
                          Expanded(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: "${Constant.RUPEE} ${widget.item.productPrice}",
                                  fontColor: Pallete.itemPriceColor,
                                  fontSize: Constant.TEXT_FONT,
                                  fontFamily: Constant.ROBOTO_MEDIUM,
                                ),
                                Card(
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
                                        text: widget.item.productQty + ' ' + widget.item.productUnit ,
                                        fontColor: Pallete.itemSizeColor,
                                        fontFamily: Constant.ROBOTO_MEDIUM,
                                        fontSize: Constant.SUB_TEXT_FONT,
                                      )),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 2,
                          ),
                          // SizedBox(
                          //   height: 35,
                          //   width: 100,
                          //   child:
                          //   store.checkIteminCart(widget.item) ? AddQuantityView(
                          //       modifyQuantity: null,
                          //       isFromCart:false,
                          //       viewSize: 30,
                          //       index: store.getItemIndexInCart(widget.item)) :
                          //   FlatButton(
                          //       child: Text(
                          //         'Add Item',
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize:  Constant.BUTTON_FONT - 1,
                          //           fontFamily: Constant.ROBOTO_MEDIUM,
                          //         ),
                          //       ),
                          //       // highlightedBorderColor: Colors.green,
                          //       color: Pallete.primaryColor,
                          //       shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
                          //       onPressed: () {
                          //         store.addtoCart(widget.item);
                          //         // store.getCart();
                          //       }
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
