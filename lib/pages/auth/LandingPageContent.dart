import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        //   child: SvgPicture.asset('${Constant.PATH_IMAGE}/svg/shoppingBAGS.svg',height: 60,),
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //   child: Image.asset(
        //     '${Constant.PATH_IMAGE}/app_icon.jpg',
        //     width: 60,
        //     height: 60,
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
        //   child: TextWidget(
        //     text: Constant.WELCOME,
        //     fontSize: Constant.BIG_TEXT_FONT,
        //     fontColor: Pallete.textColor,
        //     fontFamily: Constant.ROBOTO_BOLD,
        //   ),
        // ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextWidget(
              text: Constant.APP_NAME,
              fontSize: Constant.BIG_TEXT_FONT+2,
              fontColor: Pallete.textColor,
              fontFamily: Constant.ROBOTO_BOLD,
            ),
          ),
        ),
        // Center(
        //   child: Padding(
        //     padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        //     child: TextWidget(
        //       text: Constant.WELCOME_TEXT,
        //       fontSize: Constant.TEXT_FONT,
        //       fontColor: Pallete.textSubTitle,
        //       maxLines: 2,
        //     ),
        //   ),
        // ),

        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Material(
                color: Colors.transparent,
              child: Text(
                Constant.WELCOME_TEXT,
                textAlign: TextAlign.center,
                maxLines: 2,
                textScaleFactor: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Pallete.textSubTitle,
                    fontSize: Constant.TEXT_FONT,
                    fontFamily:  Constant.ROBOTO_REGULAR
                        ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
