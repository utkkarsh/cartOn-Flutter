import 'package:CartOn/util/Pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchEmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.appBgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('${Constant.PATH_IMAGE}/svg/telescope.svg',height: 100,),
            SizedBox(
              height: Constant.HALF_PADDING_VIEW,
            ),
            TextWidget(
              text: "Item Not Found",
              fontColor: Colors.grey[500],
              fontSize: 20,
              fontFamily: Constant.ROBOTO_MEDIUM,
            )
          ],
        ),
      ),
    );
  }
}
