import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/ShopCategory.dart';
import 'package:CartOn/pages/category_wid/CategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/home/GroceryTypeItem.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/util/pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:flutter_svg/flutter_svg.dart';

var category_list = [
  {
    "cat_id": 1,
    "cat_name": "Grocery",
    "image": "https://www.jiomart.com/images/category/141/thumb/fruits-vegetables-20200520.png",
  },
  {
    "cat_id": 2,
    "cat_name": "Electrical",
    "image": "https://www.macworld.co.uk/cmsdata/features/3659434/apple_mail_thumb800.png",
  },
  {
    "cat_id": 3,
    "cat_name": "Wooden",
    "image": "http://trinity.000webhostapp.com/images/IMG_1270-removebg-preview.png",
  },
  {
    "cat_id": 4,
    "cat_name": "Home & Living",
    "image": "https://www.decorist.com/static/cache-thumbnail/7e/50/7e50954989346b531afdf8a76cabd19a.png",
  }
  ];

class CategoryTypesView extends StatefulWidget {
  @override
  _CategoryTypesViewState createState() => _CategoryTypesViewState();
}


class _CategoryTypesViewState extends State<CategoryTypesView> {
  // Future getDatafromAPI () async {
  //   var store = Provider.of<MyStore>(context);
  //
  //   if(store.getCategoryListLength()>0)
  //     {
  //       return store.categoryList;
  //     }
  //   else
  //     {
  //
  //       List<ShopCategory> catg = await getCategories('CATEGORY_TYPE_VIEW');
  //       List<Shop> shops = await getShopsFromDB('CATEGORY_TYPE_VIEW');
  //
  //       if(catg.length>0)
  //       {
  //         if(shops.length > 0 )
  //         {
  //           store.addtoShopList(shops);
  //         }
  //         store.addtoCategoryList(catg);
  //       }
  //       return catg;
  //     }
  // }

  Future getDatafromAPI() async {
    var store = Provider.of<MyStore>(context);

    if(store.getCategoryListLength()>0)
    {
      return store.categoryList;
    }
    else
    {
      List<ShopCategory> catg = await getCategories('CATEGORY_LIST');
      // List<Shop> shops = await getShopsFromDB();

      if(catg.length>0 )
      {
        //   if(shops.length>0 )
        // {
        //   store.addtoShopList(shops);
        // }
        store.addtoCategoryList(catg);
      }
      return catg;
    }
  }

  @override
  Widget build(BuildContext context) {

    var store = Provider.of<MyStore>(context);
    // print('Current Location is -> ' + currentLocation.latitude.toString() + ',' + currentLocation.latitude.toString());

    return
      Container(
        // padding: EdgeInsets.all(Constant.PADDING_VIEW),
        child: Column(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,Constant.PADDING_VIEW,Constant.PADDING_VIEW,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                      child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/clipboard.svg',height: 30,),
                    ),
                    SizedBox(width: 5,),
                    TextWidget(
                      text: Constant.SHOP_CATEGORY,
                      fontSize: Constant.HINT_TEXT_FONT,
                      fontColor: Pallete.textColor,
                      fontFamily: Constant.ROBOTO_BOLD,
                    ),

                  ],
                ),


                GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(Routers.CATEGORY_LIST,
                      arguments: ParamType(title: 'Categories')),
                  child: Row(
                    children: [
                      Text(
                        Constant.SEE_ALL,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Constant.HINT_TEXT_FONT,
                          color: Pallete.seeAllButtonColor,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Ionicons.arrow_forward_circle,color: Pallete.seeAllButtonColor,)
                    ],
                  ),
                ),
              ],
            ),
          ),

          FutureBuilder(
            future: getDatafromAPI() ,
            builder: (BuildContext context, AsyncSnapshot snapshot ){
              if (snapshot.data == null)
              {
                return Container(
                  child: SpinKitPulse(
                    color: Colors.grey,
                    size: 50.0,
                  ),
                );
              }
              if (snapshot.data.length>0)
              {
                // store.addtoCategoryList(snapshot.data);
                // print(snapshot.data.length);
                return Container (
                    height: 200.0,
                    // color: Colors.blue,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index){

                          return CategoryCard(category: snapshot.data[index],isGridList: false,);
                          //   GestureDetector(
                          //   onTap: () => Navigator.of(context).pushNamed(Routers.CATEGORY_DETAIL,
                          //       arguments: category_list[index]["cat_name"]),
                          //   child: Container(
                          //     width: 200,
                          //     // color: Colors.red,
                          //     margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          //     child: Stack(
                          //       alignment: Alignment.topLeft,
                          //       children: [
                          //         Column(
                          //           children: [
                          //             Card(
                          //                 elevation: 0,
                          //                 shape: RoundedRectangleBorder(
                          //                     borderRadius: BorderRadius.circular(8)
                          //                 ),
                          //                 color:Colors.white,
                          //                 child: Column(
                          //                   mainAxisAlignment: MainAxisAlignment.start,
                          //                   crossAxisAlignment: CrossAxisAlignment.center,
                          //                   children: [
                          //                     SizedBox(height: 5),
                          //                     Text (
                          //                         '${snapshot.data[index].categoryName}',
                          //                         style: TextStyle(
                          //                           color: Pallete.itemDescColor,
                          //                           fontSize: Constant.TEXT_FONT,
                          //                           fontFamily: Constant.ROBOTO_MEDIUM,
                          //                         )
                          //                     ),
                          //                     SizedBox(height: 110,width: 115,),
                          //                   ],
                          //                 )
                          //             )
                          //           ],
                          //         ),
                          //         Image (
                          //           height: 180,
                          //           width: 180,
                          //           image: NetworkImage('${snapshot.data[index].categoryImage}'),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // );
                        })
                );
              }
              else
              {
                return Container();
              }
            },
          ),

        ],
    ),
      );
  }
}

