import 'dart:async';
import 'package:CartOn/util/Pallete.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/util/StyleUtil.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Pallete.appBgColor,
      statusBarBrightness: Brightness.light,
    ));

    return ChangeNotifierProvider<MyStore>(
      create: (_)=>MyStore(),

      child: MaterialApp(
        title: Constant.APP_NAME,
        darkTheme: StyleUtil.themeData,
        theme: StyleUtil.themeData,
        home: SplashWidget(title: Constant.APP_NAME),
        routes: Routers.getRoutePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashWidget extends StatefulWidget {
  SplashWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  SplashWidgetState createState() => SplashWidgetState();
}

class SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
            context, Routers.LANDING, ModalRoute.withName(Routers.LANDING)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Hero(
              tag: 'logo',
                child:Image.asset(
                  '${Constant.PATH_IMAGE}/logo.png',
                  width: 180,
                  height: 180,
                )
              )
                  ,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                    child: TextWidget(
                      text: Constant.APP_NAME,
                      fontColor: Colors.white,
                      fontSize: Constant.BIG_TEXT_FONT,
                      fontFamily: Constant.ROBOTO_MEDIUM,
                    ),
                  ),
                  TextWidget(
                    text: Constant.SPLASH_TEXT,
                    fontColor: Colors.white,
                    fontSize: Constant.TEXT_FONT,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
