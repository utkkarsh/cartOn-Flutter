import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';

class LandingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueAccent,
      child: Column(
        children: [
          ButtonWidget(
            text: Constant.LOGIN,
            fontSize: Constant.BUTTON_FONT,
            fontColor: Colors.white,
            buttonColor: Pallete.secondaryButtonColor,
            buttonShadowColor: Pallete.secondaryButtonColorShadow,
           buttonBackgroundColor: Pallete.appBgColor,
            isBorder: false,
            onPress: () {
              Navigator.of(context).pushNamed(Routers.LOGIN,
                  arguments: ParamType(title: Constant.LOGIN));
            },
          ),
          SizedBox(
            height: 20,
          ),
          ButtonWidget(
            text: Constant.CREATE_ACCOUNT,
            fontSize: Constant.BUTTON_FONT,
            fontColor: Pallete.textColor,
            buttonColor: Pallete.quadButtonColor,
            buttonShadowColor: Colors.white,
            buttonBackgroundColor: Pallete.appBgColor,
            isBorder: false,
            onPress: () {
              Navigator.of(context).pushNamed(Routers.SIGN_UP,
                  arguments: ParamType(title: Constant.CREATE_ACCOUNT));
            },
          )
        ],
      ),
    );
  }
}
