import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/pages/locationService/getLiveLocation.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
// import 'package:CartOn/pages/modal/Shop.dart';
import 'package:CartOn/models/Shop.dart';
// import 'package:CartOn/pages/shops/detail/ShopDetailPage.dart';
import 'package:CartOn/util/Constant.dart';
// import 'package:CartOn/pages/modal/Shop.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/util/DefaultFunctions.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';

class ShopCard extends StatefulWidget {
  final Shop shop;
  final String forceCategoryName;
  ShopCard({this.shop,this.forceCategoryName});

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    print(widget.shop.shopCategories);
    return Container(
      width: 315,
      // color: Colors.black,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Container(
        // color: Colors.deepPurple,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          // color:Colors.red,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: ()=>{
            Navigator.of(context).pushNamed(Routers.SHOP_DETAILS,
            arguments: ParamTypeShop(shop: widget.shop, heroId: widget.shop.hashCode,forcedCategory: widget.forceCategoryName!=null?widget.forceCategoryName:""))
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                      width:100,
                      height: 130,
                      child: Hero(
                        tag: widget.shop.hashCode,
                        child: Image (
                          height: 150,
                          width: 150,
                          image: NetworkImage(
                              widget.shop.shopImage
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                ),
                // SizedBox(width: 5,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text (
                            widget.shop.shopName,
                            style: TextStyle(
                              color: Pallete.itemDescColor,
                              fontSize: Constant.TEXT_FONT,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            )
                        ),
                        Text (

                            widget.forceCategoryName!=null
                                ? widget.forceCategoryName
                                : widget.shop.shopMulCat==true
                                    ? widget.shop.shopCategories.join(' | ')
                                        : widget.shop.shopCategory.toLowerCase().capitalizeFirstofEach,

                            style: TextStyle(
                              color: Pallete.itemDescColor,
                              fontSize: Constant.TEXT_FONT,
                              fontWeight: FontWeight.w100,
                              fontFamily: Constant.ROBOTO_REGULAR,
                            )
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Feather.map_pin,
                              color: Pallete.itemDescColor,
                              size: Constant.TEXT_FONT - 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text (
                                widget.shop.distance,
                                  style: TextStyle(
                                    color: Pallete.itemDescColor,
                                    fontSize: Constant.TEXT_FONT - 1,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: Constant.ROBOTO_REGULAR,
                                  )
                              ),
                            )
                          ],
                        ),

                        //Check if shop is on promotions, if not check if shop is new else check if shop is verified.
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,8,0),
                          child: shopTag(widget.shop),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Widget shopTag( Shop currentShop)
  {
    print(currentShop.ispromoted);
    if(currentShop.ispromoted=="1"){
      return Container(
        width: 120,
        decoration: BoxDecoration(
            color: Colors.yellow[50],
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                  child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/sponsored.svg',height: 20,),
                ),
                SizedBox(width: 5,),
                TextWidget(text: 'In the Fame', fontColor: Colors.yellow[800],)
            ],
          ),
        ),
      );
    }
    else if(currentShop.isnew=="1"){
      return Container(
        width: 80,
        decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/new.svg',height: 20,),
              ),
              SizedBox(width: 5,),
              TextWidget(text: 'New', fontColor: Colors.orange[800],)
            ],
          ),
        ),
      );
    }
    // else if(currentShop.isVerified=="1"){
    //   return Container(
    //     width: 120,
    //     decoration: BoxDecoration(
    //         color: Colors.yellow[100],
    //         borderRadius: BorderRadius.all(Radius.circular(20))
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(2),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
    //             child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/verified.svg',height: 20,),
    //           ),
    //           SizedBox(width: 5,),
    //           TextWidget(text: 'Verified',)
    //         ],
    //       ),
    //     ),
    //   );
    // }
    else {
      return Text('');
    }

  }
  // convertDistance(distance)
  // {
  //   String distanceString = "1 Km";
  //   double doubleDistInMeters = double.parse(distance) * 1000;
  //   // "distance": "0.07944312656767934"
  //   print(doubleDistInMeters);
  //   if(doubleDistInMeters>1000.00)
  //   {
  //     var distance = doubleDistInMeters/1000.00;
  //     distanceString = distance.round().toString() + ' Km';
  //   }
  //   else
  //   {
  //     distanceString = doubleDistInMeters.round().toString() + ' Mtr.';
  //   }
  //
  //   return distanceString;
  //
  // }
}
