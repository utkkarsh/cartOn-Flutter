import 'package:flutter/material.dart';
import 'package:CartOn/pages/home/GroceryTypeItem.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:ionicons/ionicons.dart';

var category_list = [
  {
    "shop_id": 1,
    "shop_name": "Shyama Kirana Store",
    "shop_cat" : "Grocery",
    "image": "https://gumlet.assettype.com/bloombergquint%2F2019-09%2Fe36614c3-373f-4c9a-8242-9704bc99d14d%2FJumbotail_Kirana_Customer_1.jpg?rect=0%2C0%2C3585%2C2581&auto=format%2Ccompress&w=1200",
  },
  {
    "shop_id": 2,
    "shop_name": "Apna Store",
    "shop_cat" : "Grocery",
    "image": "https://bsmedia.business-standard.com/_media/bs/img/article/2020-04/24/full/1587749293-324.jpg",
  },
  {
    "shop_id": 3,
    "shop_name": "The Smoke Shop",
    "shop_cat" : "Grocery",
    "image": "https://images.jdmagicbox.com/comp/bangalore/k9/080pxx80.xx80.190517124333.g1k9/catalogue/the-smoke-shop-btm-layout-2nd-stage-bangalore-hookah-dealers-swdkwfimrj.jpg",
  },
  {
    "shop_id": 4,
    "shop_name": "Agra Computer Shop",
    "shop_cat" : "Electronics",
    "image": "https://content3.jdmagicbox.com/comp/agra/dc/0562px562.x562.1227241675n3s1u7.dc/catalogue/agra-computer-centre-sanjay-place-agra-computer-repair-and-services-1lic9e7.jpg",
  },
  {
    "shop_id": 5,
    "shop_name": "Verma Stationary",
    "shop_cat" : "Stationary",
    "image": "https://content.jdmagicbox.com/comp/agra/99/0562p562stdf000199/catalogue/verma-stationery-sanjay-place-agra-stationery-shops-hhg4mgu5ui.jpg",
  }
];

class NearbyItemsView extends StatefulWidget {
  @override
  _NearbyItemsViewState createState() => _NearbyItemsViewState();
}


class _NearbyItemsViewState extends State<NearbyItemsView> {



  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.fromLTRB(Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
        child: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: Constant.ITEMS_NEAR_BY,
                  fontSize: Constant.HINT_TEXT_FONT,
                  fontColor: Pallete.textColor,
                  fontFamily: Constant.ROBOTO_BOLD,
                ),

                GestureDetector(
                  onTap: () => print('See All Clicked'),
                  child: Row(
                    children: [
                      Text(
                        Constant.SEE_ALL,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Constant.HINT_TEXT_FONT,
                          color: Pallete.primaryColor,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Ionicons.arrow_forward_circle,color: Pallete.primaryColor,)
                    ],
                  ),
                ),
              ],
            ),
            Container (
                height: 158,
                // color: Colors.blue,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category_list.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        width: 280,
                        // color: Colors.red,
                        margin: EdgeInsets.fromLTRB(0, 15, 10, 15),
                        child: Container(
                          // color: Colors.deepPurple,
                          child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              color:Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: SizedBox(
                                        width:100,
                                        height: 120,
                                        child: Image (
                                          height: 150,
                                          width: 150,
                                          image: NetworkImage('${category_list[index]["image"]}'),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                  // SizedBox(width: 5,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text (
                                            '${category_list[index]["shop_name"]}',
                                            style: TextStyle(
                                              color: Pallete.itemDescColor,
                                              fontSize: Constant.TEXT_FONT,
                                              fontFamily: Constant.ROBOTO_MEDIUM,
                                            )
                                        ),
                                        Text (
                                            '${category_list[index]["shop_cat"]}',
                                            style: TextStyle(
                                              color: Pallete.itemDescColor,
                                              fontSize: Constant.TEXT_FONT,
                                              fontWeight: FontWeight.w100,
                                              fontFamily: Constant.ROBOTO_REGULAR,
                                            )
                                        ),

                                      ],
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      );
                    })
            )
          ],
        ),
      );
  }
}

