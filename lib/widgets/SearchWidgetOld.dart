import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/StyleUtil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';

class SearchWidget extends AppBar {
  final Function onPress, onSearch, onClear;
  final String textSearch;
  final BuildContext context;

  SearchWidget({this.textSearch, this.onPress, this.onSearch, this.onClear,@required this.context,})
      : super();

  @override
  Color get backgroundColor => Pallete.primaryColor;

  @override
  Widget get leading => IconButton(
        icon: Icon(Feather.chevron_left),
        color: Pallete.textColor,
        onPressed: () {
          onPress();
        },
        iconSize: 36,
      );

  @override
   get elevation => 0;

  @override
  Widget get title {
    var store = Provider.of<MyStore>(context);
    var storeItemList = store.shopItem;
    return Container(
      child: Center(
        child: TextFormField(
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
    );
  }

  @override
  List<Widget> get actions => [
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
      ];
}
