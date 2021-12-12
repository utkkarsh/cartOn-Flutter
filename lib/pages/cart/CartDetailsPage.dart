import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/HomeAppBar.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/cart/CartView.dart';
import 'package:CartOn/pages/modal/Cart.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CartDetailsPage extends StatefulWidget {
  @override
  _CartDetailsPageState createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final List<Cart> cartList = Helper.getCartDetails();
  final List<Cart> cartArray = Helper.getCartDetails();


  @override
  Widget build(BuildContext context) {
    final bool loadAppBar = ModalRoute.of(context).settings.arguments;
    var store = Provider.of<MyStore>(context);
    // print(store.cartList.length);
    if(loadAppBar==null)
      {
        return store.getItemsinCart() > 0 ? CartPage() :  EmptyCart();
      }
    else
      {
        return Scaffold(
          appBar: NewAppBar(
            text: 'My Cart',
            isCenterTitle: false,
            isHideSearch: true,
            showCartIcon:false,
            showHomeIcon: true,
            showBackButton: true,
            context: context,
          ),
          body: store.getItemsinCart() > 0 ? CartPage() : EmptyCart(),
        );
      }
  }

  Widget EmptyCart()
  {
    return Container(
      color: Pallete.appBgColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('${Constant.PATH_IMAGE}/svg/open.svg',
                height: 180,
              ),
              SizedBox(height: 10,),
              TextWidget(
                text: 'No Items in your Cart.',
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              ),
              TextWidget(
                text: 'Please Add Items to Continue.',
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              )
            ],
          )
          ,
        )
    );
  }

  Widget CartPage() {
    return Container(
      color: Pallete.appBgColor,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 0, 0, Constant.MARGIN_50),
            child: Column(
              children: [
                CartView(
                  listCart: cartArray,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: ()=>{
            Navigator.of(context).pushNamed(
              Routers.CHECKOUT,
              arguments: true
              )
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Divider(
                //   thickness: 2,
                //   height: 2,
                // ),
                Container(
                  color: Pallete.checkoutBarColor1,
                  // color: Pallete.countViewColor, //0xFFFAFAFA
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
                              text: '',
                              // text: '${Constant.TOTAL} : ',
                              fontColor: Pallete.textSubTitle,
                              fontSize: Constant.HINT_TEXT_FONT,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            ),
                            TextWidget(
                              text: '',
                              // text: '${Constant.RUPEE} ${getTotalPrice()}',
                              fontColor: Colors.black,
                              fontSize: Constant.APP_BAR_TEXT_FONT,
                              fontFamily: Constant.ROBOTO_BOLD,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: '${Constant.CHECKOUT}',
                            fontColor: Colors.white,
                            // fontColor: Colors.black,
                            fontSize: Constant.HINT_TEXT_FONT,
                            fontFamily: Constant.ROBOTO_BOLD,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
