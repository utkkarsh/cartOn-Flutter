import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_icons/flutter_icons.dart';

// Shop Reference Data contains individual shop description, address and GSTIN details.
class ShopRefData extends StatefulWidget {
  final Shop shopData;
  ShopRefData({this.shopData});

  @override
  _ShopRefDataState createState() => _ShopRefDataState();
}

class _ShopRefDataState extends State<ShopRefData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color:Pallete.appBgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'GSTIN : ' + widget.shopData.shopGSTIN,
            fontColor: Pallete.textSubTitle,
            fontFamily: Constant.QS_MEDIUM,
            fontSize: Constant.TEXT_FONT,
          ),

          Divider(
            height: 20,
            thickness: 1,
          ),
          TextWidget(
            text: widget.shopData.shopName,
            fontColor: Pallete.textSubTitle,
            fontFamily: Constant.QS_SEMIBOLD,
            fontSize: Constant.TEXT_FONT+4,
          ),
          SizedBox(height: 7,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Feather.map_pin,size: 15,color: Pallete.textSubTitle,),
              SizedBox(width: 5,),
              Expanded(
                child: TextWidget(
                  text: widget.shopData.shopCompleteAddress,
                  fontColor: Pallete.textSubTitle,
                  fontFamily: Constant.QS_MEDIUM,
                  fontSize: Constant.SMALL_TEXT_FONT+2,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          widget.shopData.shopPhone!="" ?   Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Feather.phone_call,size: 15,color: Pallete.textSubTitle,),
              SizedBox(width: 5,),
              TextWidget(
                text: widget.shopData.shopPhone,
                fontColor: Pallete.textSubTitle,
                fontFamily: Constant.QS_MEDIUM,
                fontSize: Constant.SMALL_TEXT_FONT,
              ),
            ],
          ): Container()
        ],
      ),
    );
  }
}
