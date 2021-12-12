import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/Cart.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/pages/cart/CartItem.dart';
import 'package:CartOn/pages/modal/Cart.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewHorizontalList2.dart';

class CartView extends StatefulWidget {
  final List<Cart> listCart; 
  // final Function modifyQuantity;

  CartView({this.listCart}) : super();

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    return Column(
      children:[
        Container(
          child: ListView.builder(
            // padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
            shrinkWrap: true,
            primary: false,
            // itemExtent: 240,
            itemBuilder: (BuildContext context, int index) => Container(
              child: CartItem(
                  cart: store.cartList[index],
                  shopName: store.getShopName(store.cartList[index].shopID),
                  // ShopItem.fromJson(store.cartList[index]),
                  // modifyQuantity: widget.modifyQuantity,
                  index: index
              ),
            ),
            // itemCount: widget.listCart.length,
            itemCount: store.cartList.length,
          ),
        ),
        ClipPath(
            clipper: MovieTicketClipper(),
            child: Container(
                height: 80,
                // color: Colors.green,
                child: Container(
                  color: Colors.white, //0xFFFAFAFA
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(Constant.HALF_PADDING_VIEW + 5,
                      Constant.HALF_PADDING_VIEW, 0, Constant.HALF_PADDING_VIEW),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: '${Constant.TOTAL} : ',
                              fontColor: Pallete.textSubTitle,
                              fontSize: Constant.HINT_TEXT_FONT,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            ),

                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: '${Constant.RUPEE} ${store.getCartTotal().toString()}',
                            fontColor: Colors.black,
                            fontSize: Constant.APP_BAR_TEXT_FONT,
                            fontFamily: Constant.ROBOTO_BOLD,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                          )
                        ],
                      )
                    ],
                  ),
                )
            )
        ),
        // GroceryViewHorizontalList(
        //   listGrocery: Helper.getVegetableList(),
        // )
      ]
    );
  }
}
