import 'package:flutter/material.dart';
import 'package:CartOn/pages/home/GroceryTypeItem.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
// import 'package:CartOn/pages/modal/Shop.dart';
import 'package:CartOn/pages/shops/list/ShopCard.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/util/pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/Shop.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var category_list = [
  {
    "shop_id": 1,
    "shop_name": "Shyama Kirana Store",
    "shop_cat" : "Grocery",
    "image": "https://gumlet.assettype.com/bloombergquint%2F2019-09%2Fe36614c3-373f-4c9a-8242-9704bc99d14d%2FJumbotail_Kirana_Customer_1.jpg?rect=0%2C0%2C3585%2C2581&auto=format%2Ccompress&w=1200",
    "shop_coordinates_lat" : 27.1973232,
    "shop_coordinates_long" : 77.9560503
  },
  {
    "shop_id": 2,
    "shop_name": "Apna Store",
    "shop_cat" : "Grocery",
  "image": "https://bsmedia.business-standard.com/_media/bs/img/article/2020-04/24/full/1587749293-324.jpg",
    "shop_coordinates_lat" : 27.1973232,
    "shop_coordinates_long" : 77.9560503
  },
  {
    "shop_id": 3,
    "shop_name": "The Smoke Shop",
    "shop_cat" : "Grocery",
    "image": "https://images.jdmagicbox.com/comp/bangalore/k9/080pxx80.xx80.190517124333.g1k9/catalogue/the-smoke-shop-btm-layout-2nd-stage-bangalore-hookah-dealers-swdkwfimrj.jpg",
    "shop_coordinates_lat" : 27.1973232,
    "shop_coordinates_long" : 77.9560503
  },
  {
    "shop_id": 4,
    "shop_name": "Agra Computer Shop",
    "shop_cat" : "Electronics",
    "image": "https://content3.jdmagicbox.com/comp/agra/dc/0562px562.x562.1227241675n3s1u7.dc/catalogue/agra-computer-centre-sanjay-place-agra-computer-repair-and-services-1lic9e7.jpg",
    "shop_coordinates_lat" : 27.1973232,
    "shop_coordinates_long" : 77.9560503
  },
  {
    "shop_id": 5,
    "shop_name": "Verma Stationary",
    "shop_cat" : "Stationary",
    "image": "https://content.jdmagicbox.com/comp/agra/99/0562p562stdf000199/catalogue/verma-stationery-sanjay-place-agra-stationery-shops-hhg4mgu5ui.jpg",
    "shop_coordinates_lat" : 27.1973232,
    "shop_coordinates_long" : 77.9560503
  }
  ];

class NearbyShopsView extends StatefulWidget {
  @override
  _NearbyShopsViewState createState() => _NearbyShopsViewState();
}


class _NearbyShopsViewState extends State<NearbyShopsView> {

  Future getShopDatafromAPI() async {
    var store = Provider.of<MyStore>(context);
    // store.clearShopList();
    if(store.getShopListLength() > 0)
    {
      return store.shopList;
    }
    else
    {
      List coordinatesData= await store.getSavedLocationFromStore();
      print(coordinatesData.toString());
      List<Shop> shops = await getShopsFromDB('NEARBY_SHOPS',coordinatesData);
        if(shops.length > 0 )  // data fetched from API
        {
          store.addtoShopList(shops);
        }
      return shops;
    }
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    return
      Container(
        // color: Colors.black45,
        // padding: EdgeInsets.fromLTRB(Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
        child: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,0,Constant.PADDING_VIEW,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                        child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/shoppings.svg',height: 30,),
                      ),
                      SizedBox(width: 5,),
                      TextWidget(
                        text: Constant.SHOPS_NEAR_BY,
                        fontSize: Constant.HINT_TEXT_FONT,
                        fontColor: Pallete.textColor,
                        fontFamily: Constant.ROBOTO_BOLD,
                      ),

                    ],
                  ),
                  GestureDetector(
                    onTap: () => {
                      print('NEAR_BY_SHOPS : See all clicked'),

                      Navigator.of(context).pushNamed(Routers.SHOP_LIST,
                          arguments: ParamType(title: 'Shops'))
                    },
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
              future: getShopDatafromAPI() ,
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
                  print('NEAR_BY_SHOPS Shops Length : ' + snapshot.data.length.toString());
                  return Container (
                      height: 140,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      // color: Colors.blue,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length > 5 ? 6 : snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return ShopCard(shop: snapshot.data[index]);
                          })
                  );
                }
                else
                {
                  return Container();
                }
              },
            ),
            // Container (
            //     height: 140,
            //     margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            //     // color: Colors.blue,
            //     child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: store.shopList.length,
            //         itemBuilder: (BuildContext context, int index){
            //           // return Container(
            //           //   width: 280,
            //           //   // color: Colors.red,
            //           //   margin: EdgeInsets.fromLTRB(0, 15, 10, 15),
            //           //   child: Container(
            //           //     // color: Colors.deepPurple,
            //           //     child: Card(
            //           //         elevation: 0,
            //           //         shape: RoundedRectangleBorder(
            //           //             borderRadius: BorderRadius.circular(10)
            //           //         ),
            //           //         color:Colors.white,
            //           //         child: Row(
            //           //           mainAxisAlignment: MainAxisAlignment.start,
            //           //           crossAxisAlignment: CrossAxisAlignment.start,
            //           //           children: [
            //           //             ClipRRect(
            //           //               borderRadius: BorderRadius.circular(8.0),
            //           //               child: SizedBox(
            //           //                 width:100,
            //           //                 height: 120,
            //           //                 child: Image (
            //           //                         height: 150,
            //           //                         width: 150,
            //           //                         image: NetworkImage('${category_list[index]["image"]}'),
            //           //                         fit: BoxFit.cover,
            //           //                         )
            //           //               ),
            //           //             ),
            //           //             // SizedBox(width: 5,),
            //           //             Padding(
            //           //               padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            //           //               child: Column(
            //           //                 mainAxisAlignment: MainAxisAlignment.start,
            //           //                 crossAxisAlignment: CrossAxisAlignment.start,
            //           //                 children: [
            //           //                   Text (
            //           //                       '${category_list[index]["shop_name"]}',
            //           //                       style: TextStyle(
            //           //                         color: Pallete.itemDescColor,
            //           //                         fontSize: Constant.TEXT_FONT,
            //           //                         fontFamily: Constant.ROBOTO_MEDIUM,
            //           //                       )
            //           //                   ),
            //           //                   Text (
            //           //                       '${category_list[index]["shop_cat"]}',
            //           //                       style: TextStyle(
            //           //                         color: Pallete.itemDescColor,
            //           //                         fontSize: Constant.TEXT_FONT,
            //           //                         fontWeight: FontWeight.w100,
            //           //                         fontFamily: Constant.ROBOTO_REGULAR,
            //           //                       )
            //           //                   ),
            //           //
            //           //                 ],
            //           //               ),
            //           //             )
            //           //
            //           //           ],
            //           //         )
            //           //     ),
            //           //   ),
            //           // );
            //           return ShopCard(shop: store.shopList[index]);
            //         })
            // )
          ],
        ),
      );
  }
}

