import 'package:flutter/material.dart';
import 'package:CartOn/pages/auth/LandingButton.dart';
import 'package:CartOn/pages/auth/LandingPageContent.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/Router.dart';
import 'package:flutter_svg/flutter_svg.dart';
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void getToken () async{
      var data = await getTokens();
      if (data != null)
        {
          Navigator.pushNamedAndRemoveUntil(
              context, Routers.TABS, ModalRoute.withName(Routers.TABS));
        }
    }
    getToken();

    return Container(
      color: Pallete.appBgColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Stack(
              children: <Widget>[
                Image.asset(
                  '${Constant.PATH_IMAGE}/app_icon.jpg',
                  width: 425,
                  height: MediaQuery.of(context).size.height / 2.9,
                  color: Colors.transparent,
                ),
                Positioned(
                  right: -(MediaQuery.of(context).size.width / 2),
                  child: Hero(
                    tag: 'logo',
                    child :
                    Image.asset(
                          '${Constant.PATH_IMAGE}/logo.png',
                          width: MediaQuery.of(context).size.width + 150,
                          height: MediaQuery.of(context).size.height / 3,
                  ),
                )
                ),
              ],
            ),
            LandingPageContent(),
            LandingButton(),
            Column(children: [
              Padding(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 0, 2),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  Constant.VocalforLocal,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  textScaleFactor: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Pallete.textSubTitle,
                      fontSize: Constant.SMALL_TEXT_FONT,
                      fontFamily:  Constant.ROBOTO_REGULAR,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )


            ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 0, 0, Constant.HALF_PADDING_VIEW),
                child: TextWidget(
                  text: Constant.TnC,
                  fontColor: Pallete.textSubTitle,
                  fontSize: Constant.SMALL_TEXT_FONT,
                ),
              ),],)
          ],
        ),
      ),
    );
  }
}
