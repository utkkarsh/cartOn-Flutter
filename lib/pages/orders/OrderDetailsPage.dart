import 'package:CartOn/models/Items.dart';
import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/NewAppBar.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryProductDescription.dart';
import 'package:CartOn/pages/modal/Orders.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/pages/orders/OrderCurrentStatus.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/MainAppBar.dart';
import 'package:CartOn/pages/orders/OrderTimeline.dart';
import 'package:CartOn/pages/orders/ProcessTimeline.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:CartOn/util/DefaultFunctions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ParamType paramType = ModalRoute.of(context).settings.arguments;
    Orders1 orders = paramType.orders;
    print(orders.shopAddress);
    return Scaffold(
      appBar: NewAppBar(
          showBackButton:true,
          showHomeIcon: true,
          context: context,
          text: 'Order Summary',
          isCenterTitle: false,
          isHideSearch: true,
          showCartIcon:true
      ),


      // MainAppBar(
      //   context: context,
      //   text: 'Order Summary',
      //   isHideSearch: true,
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW, Constant.PADDING_VIEW, Constant.PADDING_VIEW, Constant.PADDING_VIEW),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Order Number : '+paramType.title,
                  fontSize: Constant.ORDER_HEADING_MAIN,
                  fontFamily: Constant.QS_MEDIUM,
                  maxLines: 200,
                ),

                SizedBox(height: 15,),
                // Divider(
                //   thickness: 1,
                //   height: 1,
                // ),
                TextWidget(
                  text: 'Delivery Information',
                  fontSize: Constant.ORDER_HEADING_PRIMARY1,
                  fontFamily: Constant.ROBOTO_BOLD,
                  maxLines: 200,
                ),
                Divider(
                  thickness: 1,
                ),
                _showAddressData(orders),
                //Shop Details
                //Order Timeline
                TextWidget(
                  text: 'Order Status',
                  fontSize: Constant.ORDER_HEADING_PRIMARY1,
                  fontFamily: Constant.ROBOTO_BOLD,
                  maxLines: 200,
                ),
                Divider(
                  thickness: 1,
                ),
                _createOrderTimeline(orders.orderStatus),

                //Item Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Your Order - Bill Details',
                      fontSize: Constant.ORDER_HEADING_PRIMARY1,
                      fontFamily: Constant.ROBOTO_BOLD,
                      maxLines: 200,
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
                ListView.builder(
                  // padding: EdgeInsets.all(Constant.HALF_PADDING_VIEW),
                  shrinkWrap: true,
                  primary: false,
                  // itemExtent: 240,
                  itemBuilder: (BuildContext context, int index) => Container(
                    child: _itemDetails(orders.items[index]),

                  ),
                  // itemCount: widget.listCart.length,
                  itemCount: orders.items.length,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,5,0,2),
                  child: DashSeperatorLine(color: Colors.grey),
                ),

                _orderDetailItemBox('Item Total', orders.orderValue,false,true),
                _orderDetailItemBox('Delivery Fee', orders.orderDeliveryCharge,false,true),
                _orderDetailItemBox('Bill Total ('+orders.orderPayStatus.toUpperCase()+')', orders.orderValue,true,true),
                SizedBox(height: 20,),
                TextWidget(
                  text: 'Payment Details',
                  fontSize: Constant.ORDER_HEADING_PRIMARY1,
                  fontFamily: Constant.ROBOTO_BOLD,
                  maxLines: 200,
                ),
                Divider(
                  thickness: 1,
                ),
                _orderDetailItemBox('Payment Mode', orders.orderPayType.toLowerCase().capitalizeFirstofEach, false,false),
                _orderDetailItemBox('Payment Status', orders.orderPayStatus.toLowerCase().capitalizeFirstofEach, false,false)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shopDetails(shopName, shopAddress)  {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: shopName,
            fontSize: Constant.ORDER_HEADING_PRIMARY1,
            fontFamily: Constant.ROBOTO_MEDIUM,
            fontColor: Pallete.textColor,
            maxLines: 2,
          ),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW/3,
          ),
          Text(
              shopAddress,
              softWrap: true,
              maxLines: 2,
          )

        ],
      ),
    );
  }
  Widget _itemDetails(OrderItem itemLevelData)  {
    return Container(
      padding: EdgeInsets.fromLTRB(Constant.PADDING_VIEW,5,Constant.PADDING_VIEW,5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Product Name
          // TextWidget(
          //   text: itemLevelData.productName+' x ' + itemLevelData.itemCartQty.toString(),
          //   fontSize: Constant.ORDER_HEADING_PRIMARY1,
          //   fontFamily: Constant.ROBOTO_MEDIUM,
          //   fontColor: Pallete.textColor,
          // ),
          // SizedBox(
          //   height: Constant.HALF_PADDING_VIEW/2,
          // ),
          // //Product Qty * Product Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Product Total
              TextWidget(
                text: itemLevelData.productName+' x ' + itemLevelData.itemCartQty.toString(),
                fontSize: Constant.ORDER_HEADING_SECONDARY,
                fontFamily: Constant.ROBOTO_REGULAR,
                maxLines: 200,
              ),
              TextWidget(
                text: Constant.RUPEE +' '+(itemLevelData.itemCartQty*itemLevelData.productPrice).toStringAsFixed(2),
                fontSize: Constant.ORDER_HEADING_SECONDARY,
                fontFamily: Constant.ROBOTO_REGULAR,
                maxLines: 200,
              ),
            ],
          )

        ],
      ),
    );
  }
  Widget _orderDetailItemBox(key,value,isBold,rupeeSign){
    return Container(
      padding: EdgeInsets.fromLTRB(Constant.PADDING_VIEW,4,Constant.PADDING_VIEW,4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: key,
            fontSize: Constant.ORDER_HEADING_PRIMARY3,
            fontFamily: isBold?Constant.ROBOTO_MEDIUM:Constant.ROBOTO_REGULAR,
            maxLines: 200,
          ),
          SizedBox(
            height: Constant.HALF_PADDING_VIEW/2,
          ),
          TextWidget(
            text: ( rupeeSign?Constant.RUPEE:'') +' '+ value.toString(),
            fontSize: Constant.ORDER_HEADING_PRIMARY3,
            fontFamily: isBold?Constant.ROBOTO_MEDIUM:Constant.ROBOTO_REGULAR,
            maxLines: 200,
          ),
        ],
      ),
    );
  }
  Widget _showAddressData(Orders1 order){
    return CustomTimeline(
      children: <Widget>[
        Container(  child: _shopDetails(order.shopName, order.shopAddress) ),
        Container(child: _shopDetails('Home', order.custAddress) ),
      ],
      indicators: <Widget>[
        // Icon(MaterialCommunityIcons.store_24_hour, color: Colors.blueGrey),
        SvgPicture.asset('${Constant.PATH_IMAGE}/svg/store.svg',height: 30,color: Colors.blueGrey),
        Icon(Feather.map_pin, color: Colors.blueGrey),
      ],
    );

  }
  Widget _createOrderTimeline(orderStatus){
    var newStatus = 1;
    if(int.parse(orderStatus)==7)
    {
      var _processes = [
        'Created',
        'In-Progress',
        'Cancelled',
      ];

      var _processesImages = [
        'orderCreated.svg',  //1
        'orderInProgress.svg',  //2
        'orderCancelled.svg',   //23
      ];
      return ProcessTimelinePage(orderStatusCode:int.parse(orderStatus),processes: _processes,processesImages: _processesImages,);
    }
    else if(int.parse(orderStatus)==8||int.parse(orderStatus)==9){
      var _processes = [
        'In-Progress',
        'Packaging',
        'Ready to Collect',
        'Collected',
      ];

      var _processesImages = [
        'orderInProgress.svg',  //1
        'orderPackaging.svg',
        'orderReadyCollect.svg',  //3
        'orderDelivered.svg',   //5
      ];
      return ProcessTimelinePage(orderStatusCode:int.parse(orderStatus)==8?2:4,processes: _processes,processesImages: _processesImages,);
    }
    else{
      var _processes = [
        'In-Progress',
        'Packaging',
        'On the Way',
        'Delivered',
      ];

      var _processesImages = [
        'orderInProgress.svg',  //1
        'orderPackaging.svg',
        'orderDelivering.svg',  //3
        'orderDelivered.svg',   //5
      ];
      return ProcessTimelinePage(orderStatusCode:int.parse(orderStatus)==4?int.parse(orderStatus):int.parse(orderStatus)-1,processes: _processes,processesImages: _processesImages,);
    }

  }
  }

