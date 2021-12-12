import 'package:flutter/material.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';

class GroceryTypeItem extends StatefulWidget {
  final String image;
  final String text;
  final List associatedCategory;

  GroceryTypeItem({this.image, this.text, this.associatedCategory}) : super();

  @override
  _GroceryTypeItemState createState() =>
      _GroceryTypeItemState(image: image, text: text, associatedCategory: associatedCategory);
}

class _GroceryTypeItemState extends State<GroceryTypeItem> {
  final String image;
  final String text;
  final List associatedCategory;
  _GroceryTypeItemState({this.image, this.text, this.associatedCategory}) : super();

  @override
  Widget build(BuildContext context) {
    print('Associated Category' + associatedCategory.toString());

    return Container(
      child: Expanded(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routers.GROCERY_LIST,
                  arguments: ParamType(title: text, category: associatedCategory)),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Constant.PADDING_VIEW - 5),
                  child: Image.asset(
                      image,
                    // height: 80,
                    // width: 50,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TextWidget(
              text: text,
              fontColor: Pallete.textSubTitle,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }
}
