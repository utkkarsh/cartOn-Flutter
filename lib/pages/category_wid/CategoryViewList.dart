import 'package:flutter/material.dart';
import 'package:CartOn/pages/home/GroceryTypeItem.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:ionicons/ionicons.dart';

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

class CategoryListView extends StatefulWidget {
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}


class _CategoryListViewState extends State<CategoryListView> {



  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(Constant.PADDING_VIEW),
        child: Column(
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: Constant.SHOP_CATEGORY,
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
                height: 200.0,
                // color: Colors.blue,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category_list.length,
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                        width: 200,
                        // color: Colors.red,
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Column(
                              children: [


                                Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    color:Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 5),
                                        Text (
                                            '${category_list[index]["cat_name"]}',
                                            style: TextStyle(
                                              color: Pallete.itemDescColor,
                                              fontSize: Constant.TEXT_FONT,
                                              fontFamily: Constant.ROBOTO_MEDIUM,
                                            )
                                        ),
                                        SizedBox(height: 110,width: 115,),
                                      ],
                                    )
                                )
                              ],
                            ),
                            Image (
                              height: 180,
                              width: 180,
                              image: NetworkImage('${category_list[index]["image"]}'),
                            ),
                          ],
                        ),
                      );
                    })
            )
          ],
        ),
      );
  }
}

