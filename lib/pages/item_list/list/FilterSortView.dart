import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';

class FilterSortView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(Constant.HALF_PADDING_VIEW),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.filter_list),
                SizedBox(width: Constant.HALF_PADDING_VIEW),
                TextWidget(
                    text: Constant.FILTER,
                    fontColor: Pallete.textColor,
                    fontSize: Constant.TEXT_FONT)
              ],
            ),
          )),
          Container(
              height: 50,
              width: 1,
              child: VerticalDivider(color: Colors.grey[400])),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(Constant.HALF_PADDING_VIEW),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sort),
                SizedBox(width: Constant.HALF_PADDING_VIEW),
                TextWidget(
                    text: Constant.SORT,
                    fontColor: Pallete.textColor,
                    fontSize: Constant.TEXT_FONT)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
