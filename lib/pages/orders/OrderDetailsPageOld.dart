import 'package:CartOn/models/Orders.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryProductDescription.dart';
import 'package:CartOn/pages/modal/Orders.dart';
import 'package:CartOn/pages/modal/ParamType.dart';
import 'package:CartOn/pages/orders/OrderCurrentStatus.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/MainAppBar.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ParamType paramType = ModalRoute.of(context).settings.arguments;
    Orders1 orders = paramType.orders;

    return Scaffold(
      appBar: MainAppBar(
        context: context,
        text: paramType.title,
        isHideSearch: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GroceryProductDescription(
                title: Constant.BOOKING_DATE,
                description: '${orders.orderDate}',
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              OrderCurrentStatus(orders: orders),
              Divider(
                thickness: 1,
                height: 1,
              ),
              GroceryProductDescription(
                title: Constant.DESTINATION,
                description: Constant.PRODUCT_ADDRESS,
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              GroceryProductDescription(
                title: Constant.COURIER,
                description: '${Constant.APP_NAME} ${Constant.COURIER}',
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              GroceryProductDescription(
                title: Constant.TOTAL_PAYMENT,
                description: '${Constant.RUPEE} ${orders.orderValue}',
              ),
            ],
             ),
        ),
      ),
    );
  }
}
