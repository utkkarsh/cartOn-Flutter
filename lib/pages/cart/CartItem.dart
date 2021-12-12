import 'package:flutter/material.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/grocery_list/detail/AddQuatityView.dart';
import 'package:CartOn/pages/modal/Cart.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:ionicons/ionicons.dart';

class CartItem extends StatefulWidget {
  final ShopItem cart;
  final String shopName;
  final Function modifyQuantity;
  final int index;

  CartItem({this.cart, this.modifyQuantity, this.index, this.shopName}) : super();

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    print(widget.index);
    void modifyQuantity(type, numOfItems, index) {
    }

    return GestureDetector(
      // onTap: () => Navigator.of(context).pushNamed(Routers.GROCERY_DETAIL,
      //     arguments: ParamTypeShop(
      //         heroId: widget.cart.grocery.hashCode,
      //         shop: widget.cart.grocery)),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: widget.cart.hashCode,
                      child: Image(
                        image: NetworkImage('${widget.cart.productImage}'),
                        width: 100,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        Constant.HALF_PADDING_VIEW / 2,
                        4,
                        Constant.HALF_PADDING_VIEW,
                        4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // color: Colors.green,
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               TextWidget(
                                    text: widget.cart.productName,
                                    fontColor: Pallete.textColor,
                                    fontSize: Constant.TEXT_FONT,
                                    fontFamily: Constant.ROBOTO_REGULAR,
                                  ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Constant.BORDER_RADIUS))),
                                elevation: 0,
                                margin: EdgeInsets.fromLTRB(Constant.HALF_PADDING_VIEW,0,0,0),
                                color: Colors.grey[50],
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        Constant.HALF_PADDING_VIEW,
                                        Constant.HALF_PADDING_VIEW / 2,
                                        Constant.HALF_PADDING_VIEW,
                                        Constant.HALF_PADDING_VIEW / 2),
                                    child: TextWidget(
                                      text: widget.cart.productQty+ ' ' + widget.cart.productUnit,
                                      fontColor: Pallete.itemPriceColor,
                                      fontFamily: Constant.ROBOTO_MEDIUM,
                                      fontSize: Constant.SUB_TEXT_FONT,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        TextWidget(
                          text: 'From : ' + widget.cart.shopName,
                          fontColor: Pallete.itemSizeColor,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                          fontSize: Constant.SUB_TEXT_FONT,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                                child: TextWidget(
                                  text:
                                  '${Constant.RUPEE} ${widget.cart.productPrice}',
                                  fontColor: Pallete.itemDescColor,
                                  fontSize: Constant.HINT_TEXT_FONT,
                                  fontFamily: Constant.ROBOTO_MEDIUM,
                                )),

                            AddQuantityView(
                                modifyQuantity: widget.modifyQuantity,
                                isFromCart:true,
                                viewSize: 30,
                                index: widget.index),
                          ],
                        )

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding (
              padding: const EdgeInsets.fromLTRB(30,0,30,0),
              child:Divider(
                thickness: 1,
                height: 0,
              )
          )
        ],
      ),
    );
  }
}
