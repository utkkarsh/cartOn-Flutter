import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GroceryProductDescription extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  GroceryProductDescription({this.title, this.description, this.icon}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constant.PADDING_VIEW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Icon(icon),
            SizedBox(
              width: Constant.HALF_PADDING_VIEW,
            ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.spa,
                children: [
                  TextWidget(
                    text: title,
                    fontSize: Constant.HINT_TEXT_FONT,
                    fontFamily: Constant.ROBOTO_MEDIUM,
                    fontColor: Pallete.textColor,
                  ),
                  Icon(MaterialIcons.keyboard_arrow_right),
                ],)
              ,
            ),
          )
          ],),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW,
          ),
          // TextWidget(
          //   text: description,
          //   fontSize: Constant.TEXT_FONT,
          //   fontFamily: Constant.ROBOTO_REGULAR,
          //   maxLines: 200,
          // )
        ],
      ),
    );
  }
}
