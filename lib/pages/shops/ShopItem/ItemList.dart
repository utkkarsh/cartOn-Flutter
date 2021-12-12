import 'dart:convert';
import 'dart:io';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemCardGrid.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemCardList.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemCardListSearch.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/DefaultFunctions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:CartOn/models/ShopProd.dart';

class ItemList extends StatefulWidget {
  final itemList;       // contains list of items which needs to be rendered
  final listView;       // contains type of view which needs to be rendered - list View / grid View
  final isFromSearch;   // if list is called from search view shop name needs to be displayed in ItemCard
  ItemList({this.itemList,this.listView, this.isFromSearch});
  @override
  _ItemListState createState() => _ItemListState(itemList,listView,isFromSearch);
}

class _ItemListState extends State<ItemList> {
  final List<ShopItem> ItemList;
  final String listView;
  final bool isFromSearch;

  _ItemListState(this.ItemList,this.listView, this.isFromSearch);
  int selectedIndex = 0;
  ItemScrollController _scrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();


  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    // print('ITEM_LIST : printing item in format = ' + store.viewTypeString);
    final releaseDateMap = ItemList.groupBy((m) => m.productSubCategory);
    var listofKeys = releaseDateMap.keys.toList();
    // print(jsonEncode(releaseDateMap));

    return listofKeys.length>0?Container(
        child: Column(
          children: [
            SizedBox(height: 5,),
            SizedBox(
              height:45,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemScrollController: _scrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: listofKeys.length,
                  itemBuilder: (BuildContext context, int index) => shopCategoryTab(index,listofKeys)
              ),
            ),

            isFromSearch==true ? Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW/2),
                shrinkWrap: true, // Important else view disappears
                itemBuilder: (BuildContext context, int index) => Container(
                  child: ItemSearchCardList(item: releaseDateMap[listofKeys[selectedIndex]][index],isFromSearch: isFromSearch,),
                ),
                itemCount: releaseDateMap[listofKeys[selectedIndex]].length,
              ),
            ):
            (   store.viewTypeString == "grid" ? (
                    Container(
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW/2),
                        shrinkWrap: true, // Important else view disappears
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,   // number of items in a list
                            crossAxisSpacing: Constant.HALF_PADDING_VIEW / 2,
                            mainAxisSpacing: Constant.HALF_PADDING_VIEW / 1,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height /
                                    (Platform.isIOS ? 1.35 : 1.30))
                        ),
                        itemBuilder: (BuildContext context, int index) => Container(
                          child: ItemCardGrid(item: releaseDateMap[listofKeys[selectedIndex]][index]),
                        ),
                        itemCount: releaseDateMap[listofKeys[selectedIndex]].length,
                      ),
                    )
                ) :
                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW/2),
                    shrinkWrap: true, // Important else view disappears
                    itemBuilder: (BuildContext context, int index) => Container(
                      child: ItemCardList(item: releaseDateMap[listofKeys[selectedIndex]][index],isFromSearch: isFromSearch,),
                    ),
                    itemCount: releaseDateMap[listofKeys[selectedIndex]].length,
                  ),
                )
            )






          ],
        )
    ):noShopItemsPage();
  }

  Widget shopCategoryTab(int index, var listofkey) {
    return GestureDetector(
      onTap: () {
        _scrollController.scrollTo(index: index,
            duration: Duration(seconds: 1),
            curve: Curves.ease
        );
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,0,0),
        child: Container(
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0,10,20,0),
                child: Text(
                  listofkey[index].toString().capitalizeFirstofEach,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Constant.TEXT_FONT,
                    color: selectedIndex == index ? Color(0xFF535353) : Color(0xFFACACAC),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0 / 4), //top padding 5
                height: 3,
                width: 30,
                color: selectedIndex == index ? Colors.black : Colors.transparent,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shopCategoryTabhistory(int index, var listofkey) {
    return GestureDetector(

      onTap: () {
        _scrollController.scrollTo(index: index,
            duration: Duration(seconds: 1),
            curve: Curves.ease
        );
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              listofkey[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Constant.TEXT_FONT,
                color: selectedIndex == index ? Color(0xFF535353) : Color(0xFFACACAC),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0 / 4), //top padding 5
              height: 3,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }


  Widget noShopItemsPage()  {

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


