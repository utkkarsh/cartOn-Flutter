import 'package:CartOn/widgets/TextAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/StyleUtil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';



class PrimaryAppBar extends StatelessWidget with PreferredSizeWidget {

  @override
  final Size preferredSize;
  final String title;
  final BuildContext context;


  PrimaryAppBar({this.title,@required this.context,})
      : preferredSize = Size.fromHeight(56.0),
        super();

  @override
  Widget build(context) {
    var store = Provider.of<MyStore>(context);
    var storeItemList = store.shopItem;
    return AppBar(
      elevation: 0,
      title:
        TextAppBar(text: title),
      backgroundColor: Pallete.toolbarColor,

      leading: IconButton(
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
      ),

    );
  }

}

