import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/list/FilterSortView.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewList.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/util/Helper.dart';

class GroceryListPage extends StatefulWidget {
  @override
  _GroceryListPageState createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  @override
  Widget build(BuildContext context) {
    final ParamType data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: NewAppBar(
          context: context,
          showBackButton:true,
          showHomeIcon: true,
          text: data.title,
          isCenterTitle: false,
          isHideSearch: true,
          showCartIcon:true
      ),

      // MainAppBar(
      //   text: data.title,
      //   isCenterTitle: false,
      //   context: context,
      // ),

      body: SafeArea(
        child: Container(
            color: Pallete.appBgColor,
            child: Column(
              children: [
                FilterSortView(),
                Expanded(
                    child:
                        GroceryViewList(listGrocery: Helper.getVegetableList()))
              ],
            )),
      ),
    );
  }
}
