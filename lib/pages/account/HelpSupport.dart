import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/callAPI.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupport extends StatefulWidget {
  @override
  _HelpSupportState createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {

  _launchCaller(type) async {

    var url = "tel: +91-8527680114";
    if (type == 'mail')
      {
        final Uri params = Uri(
          scheme: 'mailto',
          path: 'support@cart-on.com',
          query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
        );

        url = params.toString();
      }

    if (await canLaunch(url)) {
      Navigator.pop(context);
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 250,
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Pallete.accountPageBottomSheetOverhead,
              child: Container(
                // color: Colors.green,
                height: 50,
                width: 500,
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset('${Constant.PATH_IMAGE}/svg/customer-support.svg',
                    //   height: 80,
                    // ),
                    TextWidget(
                      text: "CartOn - Help & Support",
                      fontSize: Constant.PRICE_TEXT_FONT,
                      fontColor: Colors.white,
                      fontFamily: Constant.ROBOTO_MEDIUM,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
                padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW, 50, Constant.PADDING_VIEW, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              // SizedBox(
              //   width: 150,
              //   child: OutlineButton.icon(
              //       highlightedBorderColor: Colors.white12,
              //       color: Colors.white24,
              //       shape: StadiumBorder(),
              //       onPressed: () async=> {_launchCaller('call')},
              //       icon: Icon(Ionicons.call_outline),
              //       label: Text('Call')
              //   )
              // ),
                  SizedBox(
                      width: 300,
                      child:
                      OutlineButton.icon(
                          highlightedBorderColor: Colors.white12,
                          onPressed: () async=> {_launchCaller('mail')} ,
                          icon: Icon(Ionicons.mail_unread_outline),
                          label: Text('support@cart-on.com')
                      )

                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
