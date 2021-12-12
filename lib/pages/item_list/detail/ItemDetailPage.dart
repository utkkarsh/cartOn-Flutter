import 'dart:ui';

import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryNamePriceView.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryProductDescription.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewHorizontalList.dart';
import 'package:CartOn/pages/item_list/detail/ItemNamePriceView.dart';
import 'package:CartOn/pages/item_list/detail/ItemProductDescription.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/widgets/NameBottonButton.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  Color primaryGreen = Color(0xff416d6d);
  List<BoxShadow> shadowList = [
    BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
  ];

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    ParamTypeItem paramType = ModalRoute.of(context).settings.arguments;

    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Positioned.fill(
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   child:
    //                   ClipRRect(
    //                     borderRadius: BorderRadius.circular(8.0),
    //                     child: Hero(
    //                       tag: paramType.item.hashCode,
    //                       child: Image.asset(
    //                         paramType.item.image,
    //                         width: MediaQuery.of(context).size.width,
    //                         height: MediaQuery.of(context).size.height / 3,
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //
    //               Expanded(
    //                 child: Container(
    //                   margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
    //                   child: ItemProductDescription(
    //                     title: Constant.PRODUCT_DETAIL,
    //                     description: paramType.item.description,
    //                   ),
    //                 ),
    //               )
    //             ],
    //           )),
    //       Container(
    //         margin:EdgeInsets.only(top: 40),
    //         child: Align(
    //           alignment: Alignment.topCenter,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
    //                 Navigator.pop(context);
    //               }),
    //               IconButton(icon: Icon(Icons.share), onPressed: (){
    //
    //               })
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //       Align(
    //         alignment: Alignment.center,
    //         child: Container(
    //           child: Column(
    //             children: [
    //               ItemNamePriceView(
    //                 item: paramType.item,
    //               )
    //             ],
    //           ),
    //           height: 100,
    //           margin: EdgeInsets.symmetric(horizontal: 20),
    //           decoration: BoxDecoration(
    //               color: Colors.white,
    //               boxShadow: shadowList,
    //               borderRadius: BorderRadius.circular(20)),
    //
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Container(
    //           // margin: EdgeInsets.symmetric(horizontal: 20),
    //           padding: EdgeInsets.symmetric(horizontal: 15),
    //           height: 120,
    //           child: Row(
    //             children: [
    //               // Container(
    //               //   height: 60,
    //               //   width: 70,
    //               //   decoration: BoxDecoration(
    //               //       color: primaryGreen,
    //               //
    //               //       borderRadius: BorderRadius.circular(20)),
    //               //   child: Icon(Icons.favorite_border,color: Colors.white,),
    //               // ),
    //               // SizedBox(width: 5,),
    //               Expanded(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: SizedBox(
    //                     height: 50,
    //                     child: FlatButton(
    //                         child: Text(
    //                           store.checkIteminCart(paramType.item) ?
    //                           'Added' : 'Buy Now',
    //                           style: TextStyle(
    //                             color: Colors.black,
    //                             fontSize:  Constant.BUTTON_FONT - 1,
    //                             fontFamily: Constant.ROBOTO_MEDIUM,
    //                           ),
    //                         ),
    //                         // highlightedBorderColor: Colors.green,
    //                         color: Pallete.primaryColor,
    //                         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
    //                         onPressed: () {
    //                           store.addtoCart(paramType.item);
    //                         }
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           )
    //           ,
    //           decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40), )
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Scaffold(
      // extendBody: true,
      appBar: NewAppBar(
        context: context,
        text: "Product",
        showHomeIcon: true,
        isCenterTitle: false,
        isHideSearch: true,
        showCartIcon: true,
        showBackButton:true,

      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: paramType.item.hashCode,
                        child: Image(
                          image: NetworkImage(paramType.item.productImage),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Constant.BORDER_RADIUS))),
                      elevation: Constant.CARD_ELEVATION,
                      margin: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                      // color: Colors.grey[50],
                      child:   new ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: new BackdropFilter(
                          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100.withOpacity(0.1),
                            ),
                            child:   Container(
                                padding: EdgeInsets.fromLTRB(
                                    Constant.HALF_PADDING_VIEW,
                                    Constant.HALF_PADDING_VIEW / 2,
                                    Constant.HALF_PADDING_VIEW,
                                    Constant.HALF_PADDING_VIEW / 2),
                                child: TextWidget(
                                  text: paramType.item.productQty + ' ' +paramType.item.productUnit,
                                  fontColor: Pallete.textColor,
                                  fontFamily: Constant.ROBOTO_MEDIUM,
                                  fontSize: Constant.SUB_TEXT_FONT,
                                )),
                          ),
                        ),
                      ),


                    ),
                  ],
                ),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              ItemNamePriceView(
                item: paramType.item,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  height: 2,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,8,8,0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Constant.BORDER_RADIUS))),
                  elevation: Constant.CARD_ELEVATION,
                  // margin: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                  color: Colors.blue[50],
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          Constant.HALF_PADDING_VIEW,
                          Constant.HALF_PADDING_VIEW / 2,
                          Constant.HALF_PADDING_VIEW,
                          Constant.HALF_PADDING_VIEW / 2),
                      child: TextWidget(
                        text: 'Ordering From : ' + store.getShopName(paramType.item.shopID).toString() ,
                        fontColor: Pallete.itemSizeColor,
                        fontFamily: Constant.ROBOTO_MEDIUM,
                        fontSize: Constant.SUB_TEXT_FONT,
                      )),
                ),
              ),
              ItemProductDescription(
                title: Constant.PRODUCT_DETAIL,
                description: paramType.item.productDescription,
              )
              // Container(
              //   color: Pallete.appBgColor,
              //   child: GroceryViewHorizontalList(
              //     listGrocery: Helper.getVegetableList(),
              //     isFromHome: true,
              //   ),
              // )
            ],
          ),
        ),
      ),


      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            color:Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: FlatButton(
                    child: Text(
                      store.checkIteminCart(paramType.item) ?
                      'Added' : 'Add Item',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:  Constant.BUTTON_FONT - 1,
                        fontFamily: Constant.ROBOTO_MEDIUM,
                      ),
                    ),
                    // highlightedBorderColor: Colors.green,
                    color: Pallete.addItemButtonColor2,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0),    side: BorderSide(color:Colors.transparent)),
                    onPressed: () {
                      store.addtoCart(paramType.item);
                    }
                ),
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: NameBottonButton(
      //   name: "Add to Cart",
      //   onTabPress:
      //     null
      //   ,
      // ),
    );
  }



}
