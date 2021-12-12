import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/shops/detail/shopRefData.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryNamePriceView.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryProductDescription.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewHorizontalList.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/pages/shops/NearbyShops.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemCardGrid.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemList.dart';
import 'package:CartOn/pages/shops/ShopItem/testCode.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/widgets/NameBottonButton.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:CartOn/util/DefaultFunctions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';

class ShopDetailPage extends StatefulWidget {
  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    ParamTypeShop paramType = ModalRoute.of(context).settings.arguments;
    List<ShopItem> tempItems = paramType.shop.items;
    List<ShopItem> forcedData =  [];
    // print(paramType.heroId);
    // print('Forced Category is ' + paramType.forcedCategory);

    // Copy the passed list of items to a list variable, and then check if shop has multiCategory or forcedCategory.
    //If any forcedCategory is present, filter the data based on forced category and only show the list of items belonging to forced Category.

    if(paramType.forcedCategory!="")
      {
        forcedData = tempItems.where((m) => m.productType == paramType.forcedCategory).toList();
        // print(forcedData.length);
      }


    return Scaffold(
      appBar: NewAppBar(
          showBackButton:true,
          showHomeIcon: true,
          context: context,
        text: 'Store',
        isCenterTitle: false,
        isHideSearch: true,
          showCartIcon:true
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: paramType.shop.shopName,
                              fontColor: Pallete.shopTitleText,
                              fontFamily: Constant.QS_SEMIBOLD,
                              fontSize: Constant.TEXT_FONT+6,
                              maxLines: 2,
                            ),
                            SizedBox(height: 7,),
                            TextWidget(
                              text:
                              paramType.forcedCategory!="" ?
                                      paramType.forcedCategory :
                                          paramType.shop.shopMulCat==true
                                              ? paramType.shop.shopCategories.join(' | ')
                                              : paramType.shop.shopCategory.toLowerCase().capitalizeFirstofEach,

                              fontColor: Pallete.textSubTitle,
                              fontFamily: Constant.QS_MEDIUM,
                              fontSize: Constant.TEXT_FONT,
                              maxLines: 2,
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                TextWidget(
                                  text: paramType.shop.shopLocality.toLowerCase().capitalizeFirstofEach,
                                  fontColor: Pallete.textSubTitle,
                                  fontFamily: Constant.QS_MEDIUM,
                                  fontSize: Constant.SMALL_TEXT_FONT+2,
                                ),
                                TextWidget(
                                  text: ' | ',
                                  fontColor: Pallete.textSubTitle,
                                  fontFamily: Constant.QS_MEDIUM,
                                  fontSize: Constant.SMALL_TEXT_FONT,
                                ),
                                TextWidget(
                                  text: paramType.shop.distance,
                                  fontColor: Pallete.textSubTitle,
                                  fontFamily: Constant.QS_MEDIUM,
                                  fontSize: Constant.SMALL_TEXT_FONT+1,
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            Container(
                              width: 210,
                              height: 2,
                              // color: Colors.red,
                              child: Divider(
                                height: 2,
                                thickness: 1,
                              ),
                            ),

                            Container(
                              // color: Colors.red,
                              width: 200,
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(AntDesign.star,size: 15,),
                                          SizedBox(width: 5,),
                                          TextWidget(
                                            text: double.parse(paramType.shop.avgRating).toString(),
                                            fontColor: Pallete.shopTitleText,
                                            fontFamily: Constant.QS_BOLD,
                                            fontSize: Constant.SMALL_TEXT_FONT+3,
                                          ),
                                        ],
                                      ),
                                      TextWidget(
                                        text: ' Ratings ',
                                        fontColor: Pallete.textSubTitle,
                                        fontFamily: Constant.QS_MEDIUM,
                                        fontSize: Constant.SMALL_TEXT_FONT+1,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(AntDesign.clockcircle,size: 15,),
                                          SizedBox(width: 5,),
                                          TextWidget(
                                            text: paramType.shop.shopDeliveryTime,
                                            fontColor: Pallete.shopTitleText,
                                            fontFamily: Constant.QS_BOLD,
                                            fontSize: Constant.SMALL_TEXT_FONT+3,
                                          ),
                                        ],
                                      ),
                                      TextWidget(
                                        text: ' Delivery Time ',
                                        fontColor: Pallete.textSubTitle,
                                        fontFamily: Constant.QS_MEDIUM,
                                        fontSize: Constant.SMALL_TEXT_FONT+1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 210,
                              height: 2,
                              child: Divider(
                                height: 2,
                                thickness: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SizedBox(
                          width:140,
                          height: 130,
                          child: Hero(
                              tag: paramType.heroId,
                              child: Image(
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                                image: NetworkImage(paramType.shop.shopImage),
                                // width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height / 3,
                                // fit: BoxFit.contain,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                // Divider(
                //   height: 20,
                //   thickness: 1,
                // ),
                SizedBox(height: 20,),

                paramType.shop.items.length > 0 ? (
                    Container(
                      child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                // color:Pallete.appBgColor,
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                  Text(
                                    'View Items as ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Constant.TEXT_FONT,
                                      color: Colors.black45,
                                    ),
                                  ),
                                SlidingSwitch(
                                  value: store.viewTypeBool,
                                  width: 140,
                                  height : 34,
                                  animationDuration : const Duration(milliseconds: 350),
                                  onTap:(){},
                                  onDoubleTap:(){},
                                  onSwipe:(){},
                                  textOff : "Grid",
                                  textOn : "List",
                                  colorOn : const Color(0xffdc6c73),
                                  colorOff : const Color(0xff6682c0),
                                  background : const Color(0xffe4e5eb),
                                  buttonColor : const Color(0xfff7f5f7),
                                  inactiveColor : const Color(0xff636f7b),
                                  onChanged: (value) {
                                    //   setState(() { // Callback (or null to disable)
                                    //   viewType = !viewType;
                                    // });
                                    Future.delayed(const Duration(milliseconds: 402), () {
                                      store.changeViewType();

                                    });

                                  } ,
                                ),
                                  // AdvancedSwitch(
                                  //   value: store.viewTypeBool, // Boolean
                                  //   activeColor: Colors.blue, // Color
                                  //   inactiveColor: Colors.lightBlueAccent, // Color
                                  //   // activeChild: Icon(Feather.image), // Widget
                                  //   // inactiveChild: Text('OFF'),  // Widget
                                  //   // borderRadius: BorderRadius.circular(5),
                                  //   activeChild: Icon(
                                  //       Feather.list
                                  //   ),
                                  //   inactiveChild: Icon(
                                  //       Feather.grid
                                  //   ),
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  //   // width: 76,
                                  //   width: 80,
                                  //   height: 34,
                                  //   onChanged: (value) {
                                  //     //   setState(() { // Callback (or null to disable)
                                  //     //   viewType = !viewType;
                                  //     // });
                                  //     store.changeViewType();
                                  //   } ,
                                  // ),
                                ],
                              )
                          ),
                          SizedBox(height: 10,),

                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color:Pallete.appBgColor,
                              ),
                              // color:Pallete.appBgColor,
                              child: ItemList(itemList : paramType.forcedCategory==""?tempItems:forcedData, listView: 'grid', isFromSearch: false,)
                          )
                        ],
                      ),
                    )
                )
                    :
                noShopItemsPage(),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                ShopRefData(shopData: paramType.shop,)
                // NearbyShopsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noShopItemsPage()
  {

    const ColorFilter greyscale = ColorFilter.matrix(<double>[
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0,      0,      0,      1, 0,
    ]);

    return Container(
      height: MediaQuery.of(context).size.height/2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColorFiltered(
                colorFilter: greyscale,
                child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/cargo.svg',
                  height: 180,
                ),
              ),
              SizedBox(height: 10,),
              TextWidget(
                text: 'Shop is under Maintenance.' ,
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              ),
              TextWidget(
                text: 'Owner is adding new products for you.',
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              )
            ],
          ),
        )
    );
  }
}