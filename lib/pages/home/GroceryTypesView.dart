import 'package:flutter/material.dart';
import 'package:CartOn/pages/home/GroceryTypeItem.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroceryTypesView extends StatefulWidget {
  @override
  _GroceryTypesViewState createState() => _GroceryTypesViewState();
}

class _GroceryTypesViewState extends State<GroceryTypesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constant.PADDING_VIEW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: Constant.HALF_PADDING_VIEW,
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
                child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/mymind.svg',height: 30,),
              ),
              SizedBox(width: 5,),
              TextWidget(
                text: Constant.LOOKING_FOR,
                fontSize: Constant.HINT_TEXT_FONT,
                fontColor: Pallete.textColor,
                fontFamily: Constant.ROBOTO_BOLD,
              ),
            ],
          ),

          SizedBox(height: 16),
          Row(
            children: [
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/main_items/veggies.png",
                  text: Constant.VEGATABLES,
                  associatedCategory: ['vegetable'],
              ),
              SizedBox(width: Constant.HALF_PADDING_VIEW),
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/main_items/fruits.png",
                  text: Constant.FRUITS,
                  associatedCategory: ['fruit'],
              ),
              SizedBox(width: Constant.HALF_PADDING_VIEW),
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/main_items/milk.png",
                  text: Constant.MILK_EGG,
                associatedCategory: ['dairy','milk','eggs'],),
            ],
          ),
          SizedBox(height: Constant.HALF_PADDING_VIEW),
          Row(
            children: [
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/main_items/bread.png",
                  text: Constant.BREAD,
                associatedCategory: ['bread','bulbs'],),
              SizedBox(width: Constant.HALF_PADDING_VIEW),
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/main_items/frozenfood.png",
                  text: Constant.FROZEN,
                associatedCategory: ['frozen'],),
              SizedBox(width: Constant.HALF_PADDING_VIEW),
              GroceryTypeItem(
                  image: "${Constant.PATH_IMAGE}/organic.png",
                  text: Constant.ORGANIC,
                associatedCategory: ['organic'],),
            ],
          )
        ],
      ),
    );
  }
}
