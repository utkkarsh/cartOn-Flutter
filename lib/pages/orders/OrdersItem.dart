import 'package:flutter/material.dart';
import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/pages/modal/Orders.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/pages/orders/OrderStatusView.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';
import 'package:CartOn/util/DefaultFunctions.dart';

class OrdersItem extends StatelessWidget {
  final Orders1 orders;

  OrdersItem({this.orders});



  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(Routers.ORDER_DETAILS,
          arguments:
              ParamType(title: orders.orderNumber, orders: this.orders)),
      child: Container(
        margin: EdgeInsets.fromLTRB(
            Constant.HALF_PADDING_VIEW,
            Constant.HALF_PADDING_VIEW / 3,
            Constant.HALF_PADDING_VIEW,
            Constant.HALF_PADDING_VIEW / 3),
        child: Card(
          elevation: Constant.CARD_ELEVATION,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                      Constant.PADDING_VIEW/2, Constant.PADDING_VIEW, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        TextWidget(
                        text: 'From ' + orders.shopName,
                          fontColor: Colors.black87,
                          fontSize: Constant.SUB_TEXT_FONT,
                          fontFamily: Constant.ROBOTO_MEDIUM,
                        ),

                      Card(
                        elevation: 0,
                        color: Colors.white60,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2,
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2),
                          child: TextWidget(
                            text: Constant.RUPEE +' '+orders.orderValue,
                            fontSize: Constant.SMALL_TEXT_FONT,
                            fontColor: Colors.black87,
                            fontFamily: Constant.ROBOTO_MEDIUM,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                DashSeperatorLine(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                      10, Constant.PADDING_VIEW,  2),
                  child: orderDetailLine2('# '+orders.orderNumber, '','none'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                      5, Constant.PADDING_VIEW,  2),
                  child: orderDetailLine2('ORDERED ON', DateTime.parse(orders.orderDate),'date'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                      5, Constant.PADDING_VIEW,  0),
                  child: orderDetailLine2('ITEMS', orders.orderItems,'items'),
                ),

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                //       Constant.PADDING_VIEW, Constant.PADDING_VIEW,  Constant.PADDING_VIEW),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //
                //       // SHOW BASIC ORDER INFORMATION SUCH AS ORDER-NO , PRICE & DELIVERING TO
                //       Expanded(
                //         child: Container(
                //           // color: Colors.green,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Expanded(
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     orderDetailLine('Order No    ',orders.orderNumber),
                //                     SizedBox(height: 3,),
                //                     orderDetailLine('Total Items',orders.orderItems),
                //                     SizedBox(height: 3,),
                //                     orderDetailLine('Order Total',orders.orderValue),
                //                   ],
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //       // SHOW CURRENT STATUS ICON AND STATUS MESSAGE
                //       Container(
                //         width: 130,
                //         // color: Colors.blue,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             // SvgPicture.asset('${Constant.PATH_IMAGE}/svg/${orders.status.iconAsset}',
                //             //   height: 60,
                //             //   width: 60,
                //             // ),
                //             OrderStatusView(
                //               status: orders.status.name,
                //               bgColor: orders.status.bgColor,
                //               textColor: orders.status.textColor,
                //             )
                //           ],
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),



                // Column(
                //   children: [
                //     TextWidget(
                //       text: DateFormat("dd-MMM-yyyy").format(DateTime.parse(orders.orderDate)),
                //       fontColor: Pallete.textSubTitle,
                //     )
                //   ],
                // ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                      Constant.PADDING_VIEW, Constant.PADDING_VIEW, Constant.PADDING_VIEW/2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrderStatusView(
                        status: orders.status.name,
                        bgColor: orders.status.bgColor,
                        textColor: orders.status.textColor,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.grey[50],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2,
                              Constant.HALF_PADDING_VIEW,
                              Constant.HALF_PADDING_VIEW / 2),
                          child: TextWidget(
                            text: orders.orderPayStatus=="paid"?'Paid ' + orders.orderPayType:'Unpaid',
                            fontSize: Constant.SMALL_TEXT_FONT,
                            fontColor: Colors.black87,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: orderDetailLine(Constant.DELIVERED_TO, orders.custAddress)
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     TextWidget(
                //       text: Constant.DELIVERED_TO,
                //       fontColor: Pallete.textSubTitle,
                //       fontSize: Constant.SMALL_TEXT_FONT,
                //       fontFamily: Constant.ROBOTO_MEDIUM,
                //     ),
                //     SizedBox(
                //       height: Constant.HALF_PADDING_VIEW / 2,
                //     ),
                //     TextWidget(
                //       text: orders.custAddress,
                //       fontColor: Pallete.textColor,
                //       fontSize: Constant.SUB_TEXT_FONT,
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDetailLine(key,value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextWidget(
            text: key + ' : ',
            fontColor: Pallete.textSubTitle,
            fontSize: Constant.SUB_TEXT_FONT,
            fontFamily: Constant.ROBOTO_MEDIUM,
          ),
        ),


        Expanded(
          child: TextWidget(
            text: key!="Order Total"?
                            key!="Total Items"?value:value +" Items"
                                      :Constant.RUPEE+" "+value,
            fontColor: Pallete.textSubTitle,
            fontSize: Constant.SUB_TEXT_FONT,
            fontFamily: Constant.ROBOTO_REGULAR,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget orderDetailLine2(key,value,type){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextWidget(
            text: type=="none"?key : key +' : ',
            fontColor: Pallete.textSubTitle,
            fontSize: Constant.SUB_TEXT_FONT,
            fontFamily: Constant.ROBOTO_MEDIUM,
          ),
        ),


        Expanded(
          child: TextWidget(
            text: type=='date'? DateFormat("dd-MMM-yyyy").format(value) + ' at ' + DateFormat("hh:mm aa").format(value) : type!="items"?value:value + " Items" ,
            fontColor: Colors.blueGrey[800],
            fontSize: Constant.SUB_TEXT_FONT,
            fontFamily: Constant.ROBOTO_MEDIUM,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
