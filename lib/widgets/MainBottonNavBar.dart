import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';

class MainBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function onTap;

  MainBottomNavBar({@required this.selectedIndex, @required this.onTap})
      : super();

  @override
  _MainBottomNavBarState createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      items: <SalomonBottomBarItem>[
        SalomonBottomBarItem(
            icon: Icon(Ionicons.home),
            title: TextWidget(text: Constant.SHOP)),
        SalomonBottomBarItem(
            icon: Icon(Ionicons.cart),
            title: TextWidget(text: Constant.MY_CART)),
        SalomonBottomBarItem(
            icon: Icon(Ionicons.basket),
            title: TextWidget(text: Constant.ORDERS)),
        SalomonBottomBarItem(
            icon: Icon(Ionicons.person),
            title: TextWidget(text: Constant.ACCOUNT))
      ],
      currentIndex: widget.selectedIndex,
      // showSelectedLabels: true,
      // showUnselectedLabels: false,

      selectedItemColor: Pallete.primaryColor,
      // selectedLabelStyle: TextStyle(color: Pallete.primaryColor, fontSize: 12),
      // selectedIconTheme: IconThemeData(size: 30, color: Pallete.primaryColor),

      unselectedItemColor: Pallete.textSubTitle,
      // unselectedIconTheme: IconThemeData(size: 30, color: Colors.grey[400]),
      onTap: widget.onTap,
      // backgroundColor: Colors.white,
    );
  }
}
