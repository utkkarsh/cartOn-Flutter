import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/StyleUtil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';



class SearchWidget extends StatelessWidget with PreferredSizeWidget {

  @override
  final Size preferredSize;
  final Function onPress, onSearch, onClear;
  final String textSearch;
  final BuildContext context;


  SearchWidget({this.textSearch, this.onPress, this.onSearch, this.onClear,@required this.context,})
      : preferredSize = Size.fromHeight(56.0),
        super();

  @override
  Widget build(context) {
    var store = Provider.of<MyStore>(context);
    var storeItemList = store.shopItem;
    return AppBar(
      elevation: 0,
      title: Container(
        child: Center(
          child: TextFormField(
            // style: TextStyle(color: Colors.red),

            style: StyleUtil.textSearchStyle,
            decoration: InputDecoration(
              hintText: " Search",
              hintStyle: StyleUtil.textSearchHintStyle,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            cursorColor: Pallete.searchColor1,
            autofocus: true,
            onChanged: (data) {
              onSearch(data, storeItemList);
            },
          ),
        ),
      ),
      backgroundColor: Pallete.toolbarColor,

      leading: IconButton(
        icon: Icon(Feather.chevron_left),
        color: Pallete.textColor,
        onPressed: () {
          onPress();
        },
        iconSize: 36,
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.all(Constant.HALF_PADDING_VIEW),
          child: IconButton(
            icon: Icon(Feather.x),
            color: Pallete.textColor,
            onPressed: () {
              onClear();
            },
            iconSize: 26,
          ),
        )
      ],
    );
  }

}

