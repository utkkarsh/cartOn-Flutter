import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/list/FilterSortView.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewList.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/pages/shops/ShopItem/ItemList.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/shopItem.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/TextWidget.dart';
class GroceryListPage extends StatefulWidget {
  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override

  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    List<ShopItem> listData1 = [];
    store.shopItem.forEach((element) {
      listData1.add(element);
    });

    final ParamType data = ModalRoute.of(context).settings.arguments;
    // ParamTypeShop paramType = ModalRoute.of(context).settings.arguments;
    print(data.category);
    //Traverse the global item list and filter out products where subcategory is within the given items.
    List<ShopItem> filteredData = [];
    data.category.forEach((element) {
      var data = listData1.where((m) => m.productSubCategory == element.toString().toLowerCase()).toList();
      if(data.length>0){
        filteredData.addAll(data);
      }
    });
    // var filteredData = listData1.where((m) => m.productSubCategory == data.category[0].toLowerCase()).toList();

    return Scaffold(
      appBar: NewAppBar(
          context: context,
          showBackButton:true,
          showHomeIcon: true,
          text: data.title,
          isCenterTitle: false,
          isHideSearch: false,
          showCartIcon:true
      ),

      // MainAppBar(
      //   text: data.title,
      //   isCenterTitle: false,
      //   context: context,
      // ),
      body: SafeArea(
        child: filteredData.length==0?emptyStatePage():Container(
            color: Pallete.appBgColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // FilterSortView(),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color:Pallete.appBgColor,
                      ),
                      // color:Pallete.appBgColor,
                      child: ItemList(itemList : filteredData, listView: 'list', isFromSearch: true)
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget emptyStatePage()
  {
    return Container(
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
                text: 'Oops! Sellers are out of this item.',
                fontColor: Pallete.textSubTitle,
                fontSize: Constant.SMALL_TEXT_FONT + 3,
                fontFamily: Constant.ROBOTO_MEDIUM,
              ),
              TextWidget(
                text: '',
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

}
