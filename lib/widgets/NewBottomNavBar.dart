import 'package:CartOn/models/MyStore.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ionicons/ionicons.dart';

import 'package:badges/badges.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function onTap;

  MainBottomNavBar({@required this.selectedIndex, @required this.onTap})
      : super();

  @override
  _MainBottomNavBarState createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     // borderRadius: BorderRadius.all(Radius.circular(100)),
        //     boxShadow: [
        //       BoxShadow(
        //           spreadRadius: -10,
        //           blurRadius: 60,
        //           color: Colors.black.withOpacity(.4),
        //           offset: Offset(0, 25))
        //     ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
          child: GNav(
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 900),
              tabs: [
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: Feather.home,
                  // textStyle: t.textStyle,
                  text: 'Home',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.pink,
                  iconColor: Colors.black,
                  textColor: Colors.pink,
                  backgroundColor: Colors.pink.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: Feather.shopping_bag,
                  leading: widget.selectedIndex == 1 || store.getItemsinCart() == 0
                      ? null
                      : Badge(
                      badgeColor: Colors.red.shade100,
                      elevation: 0,
                      position:
                      BadgePosition.topEnd(top:-12,end: -12),
                      badgeContent: Text(
                        store.gettotalItemsinCart().toString(),
                        style: TextStyle(color: Colors.red.shade900),
                      ),
                      child: Icon(
                        Feather.shopping_bag,
                        color: widget.selectedIndex == 1
                            ? Colors.pink
                            : Colors.black,
                      )),

// textStyle: t.textStyle,
                  text: 'Cart',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.amber[600],
                  iconColor: Colors.black,
                  textColor: Colors.amber[600],
                  backgroundColor: Colors.amber[600].withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: Feather.package,
// textStyle: t.textStyle,
                  text: 'Orders',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.teal,
                  iconColor: Colors.black,
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: Feather.user,
                  // leading: CircleAvatar(
                  //     radius: 12,
                  //     backgroundImage: NetworkImage(
                  //         "https://sooxt98.space/content/images/size/w100/2019/01/profile.png")),
// textStyle: t.textStyle,
                  text: 'Account',
                )
              ],

              selectedIndex: widget.selectedIndex,
              onTabChange: (index) {
                widget.onTap(index);
              },

              ),
        ),
      ),
    );
  }
}
