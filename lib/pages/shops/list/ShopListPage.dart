import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/list/FilterSortView.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewList.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/pages/shops/list/ShopViewList.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/util/Helper.dart';

class ShopListPage extends StatefulWidget {
  @override
  _ShopListPageState createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  @override
  Widget build(BuildContext context) {
    final ParamType data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: NewAppBar(
        showBackButton:true,
        showHomeIcon: true,
        text: data.title,
        isCenterTitle: false,
        context: context,
        showCartIcon: true,
      ),
      body: SafeArea(
        child: Container(
            color: Pallete.appBgColor,
            // color:Colors.black45,
            child: Column(
              children: [
                // FilterSortView(),
                SizedBox(height: 10,),
                Expanded(
                    child:
                        ShopViewList())
              ],
            )),
      ),
    );
  }
}
