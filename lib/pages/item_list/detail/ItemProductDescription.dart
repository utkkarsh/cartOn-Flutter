import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';

class ItemProductDescription extends StatelessWidget {
  final String title;
  final String description;

  ItemProductDescription({this.title, this.description}) : super();

  var desc = "Rear Camera - 4K Video Recording at 24 fps, 30 fps or 60 fps, 1080p HD Video Recording at 30 fps or 60 fps, 720p HD Video Recording at 30 fps, Extended Dynamic Range for Video upto 60 fps, Slow-motion Video Support for 1080p at 120 fps or 240 fps | True Depth Camera - 4K Video Recording at 24 fps, 30 fps or 60 fps, 1080p HD Video Recording at 30 fps or 60 fps, Slow-motion Video Support for 1080p at 120 fps, Extended Dynamic Range for Video at 30 fps fps      ";
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(Constant.PADDING_VIEW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: title,
            fontSize: Constant.HINT_TEXT_FONT,
            fontFamily: Constant.ROBOTO_MEDIUM,
            fontColor: Pallete.textColor,
          ),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW,
          ),
          TextWidget(
            text: description,
            fontSize: Constant.TEXT_FONT,
            fontFamily: Constant.ROBOTO_REGULAR,
            maxLines: 200,
          )
        ],
      ),
    );
  }
}
