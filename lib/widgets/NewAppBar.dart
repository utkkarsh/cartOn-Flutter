import 'package:CartOn/models/Cart.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/pages/cart/CartDetailsPage.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';


class NewAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String text;
  final bool isCenterTitle;
  final bool isHideSearch;
  final bool showCartIcon;
  final bool showHomeIcon;
  final bool showBackButton;


  final BuildContext context;

  NewAppBar(
      {
        this.text,
        this.isCenterTitle,
        this.isHideSearch,
        this.showCartIcon,
        this.showHomeIcon,
        this.showBackButton,
        @required this.context,
}): preferredSize = Size.fromHeight(56.0),
      super();

  @override
  Widget build(context) {
    var store = Provider.of<MyStore>(context);
    return AppBar(
      elevation: 0,
      title: TextAppBar(text: text),
      automaticallyImplyLeading: false,
      backgroundColor: Pallete.toolbarColor,
      centerTitle: isCenterTitle,
      leading: showBackButton!=false?IconButton(
        icon: Icon(
          Feather.chevron_left,
          color: Pallete.toolbarItemColor,
        ),
        onPressed: () {
          // print(Navigator.of(context));
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pop();
          });
        },
        iconSize: 36,
      ):null,

      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: isHideSearch != null && isHideSearch
                ? Colors.transparent
                : Pallete.toolbarItemColor,
          ),
          highlightColor: isHideSearch != null && isHideSearch
              ? Colors.transparent
              : Pallete.toolbarItemColor,
          splashColor: isHideSearch != null && isHideSearch
              ? Colors.transparent
              : Pallete.toolbarItemColor,
          onPressed: () {
            isHideSearch ? null :{if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH)};
            // if (context != null) Navigator.of(context).pushNamed(Routers.SEARCH);
          },
          iconSize: 26,
        ),

        showHomeIcon ? IconButton(
          icon: Icon(
            Feather.home,
            color: Pallete.toolbarItemColor,
          ),
          onPressed: () {
            if (context != null)
              Navigator.popUntil(context, ModalRoute.withName(Routers.TABS));
          },
          iconSize: 26,
        ) : Container(),
        showCart(store,showCartIcon),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget showCart(store,showCartIcon)
  {
    if (showCartIcon == true)
    {
      return Stack(
        fit: StackFit.passthrough,
        children: <Widget>[

          Badge(
              badgeColor: Colors.white,
              elevation: 1,
              position:
              BadgePosition.topEnd(top:4,end: 0),
              badgeContent: Text(
                store.gettotalItemsinCart().toString(),
                style: TextStyle(color: Colors.black),
              ),
              child: IconButton(

                icon: Icon(
                  Feather.shopping_bag,
                  color: Pallete.toolbarItemColor,
                ),
                onPressed: () {
                  if (context != null)
                    Navigator.of(context).pushNamed(
                        Routers.CART_DETAILS,
                        arguments: true
                    );
                },
                iconSize: 26,
              )),
        ],
      );
  }
    else
      {
        return Container();
      }

  }
}

