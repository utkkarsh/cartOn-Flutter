import 'dart:convert';

import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/pages/modal/Orders.dart';
import 'package:CartOn/pages/orders/OrdersItemOld.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/models/Order.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersPage extends StatefulWidget {
  final List<Orders> listOrders = [];

  @override
  _OrdersPageState createState() => _OrdersPageState();

}

class _OrdersPageState extends State<OrdersPage> {
 List <Orders> listOrder = [];

  @override
  Widget build(BuildContext context) {
    String parentPage = ModalRoute.of(context).settings.arguments;
    print(parentPage);
    // getOrders();
    if(parentPage==null){
      return orderPageData();
    }
    else
      {
        return
          Scaffold(
            appBar: NewAppBar(
              text: 'Orders',
              isCenterTitle: false,
              isHideSearch: true,
              showCartIcon:false,
              showHomeIcon:true,
              context: context,
              showBackButton:true,
            ),
            body: orderPageData(),
          );

      }
    // return orderPageData();
  }

  Widget orderPageData()
  {
    return Container(
      color: Pallete.appBgColor,
      child: FutureBuilder(
        future: getOrder(),
        builder: (BuildContext context, AsyncSnapshot snapshot ){
          if (snapshot.data == null)
          {
            return Container(
              child: SpinKitPulse(
                color: Colors.grey,
                size: 50.0,
              ),
            );
          }
          if (snapshot.data.length>0)
          {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrdersItem(orders: snapshot.data[index]);
                });
          }
          else
          {
            return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('${Constant.PATH_IMAGE}/svg/parcel.svg',
                        height: 180,
                      ),
                      SizedBox(height: 10,),
                      TextWidget(
                        text: 'No Orders Found in Warehouse',
                        fontColor: Pallete.textSubTitle,
                        fontSize: Constant.SMALL_TEXT_FONT + 3,
                        fontFamily: Constant.ROBOTO_MEDIUM,
                      )
                    ],
                  )
                  ,
                )
            );
          }
        },
      ),
    );
  }
}
