import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/Items.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/pages/modal/Orders.dart';
import 'package:CartOn/util/Constant.dart';

class Orders1 {
  String orderNumber;
  String custId;
  String orderValue;
  String orderStatus;
  String orderItems;
  String orderDeliveryCharge;
  String orderDate;
  String orderPayType;

  String orderPayID;
  String orderPayStatus;
  // Delivery Information
  String orderDlvyType;
  String orderDlvyID;
  String shopName;
  String shopAddress;
  String shopID;

  String custState;
  String custCity;
  String custPinCode;
  String custAddress;
  String custPhone;
  String custLatitude;
  String custLongitude;
  List<OrderItem> items;
  //Other Variables
  Status status ;

  //API RESPONSE VARS
  String statusNum;
  String statusType;
  String statusMsg;



  Orders1(
      {this.orderNumber,
        this.custId,
        this.orderValue,
        this.orderStatus,
        this.orderItems,
        this.orderDeliveryCharge,
        this.orderDate,
        this.orderPayType,
        this.orderPayID,
        this.orderPayStatus,
        this.orderDlvyID,
        this.orderDlvyType,
        this.shopName,
        this.shopAddress,
        this.shopID,
        this.custState,
        this.custCity,
        this.custPinCode,
        this.custAddress,
        this.custPhone,
        this.custLatitude,
        this.custLongitude,
        this.items});

  Orders1.fromJson(Map<String, dynamic> json) {
    orderNumber = json['Order_Number'];
    custId = json['cust_id'];
    orderValue = json['Order_Value'];
    orderStatus = json['Order_Status'];
    orderItems = json['Order_Items'];
    orderDeliveryCharge = json['Order_Delivery_Charge'];
    orderDate = json['Order_Date'];
    orderPayType = json['Order_Pay_Type'];
    orderPayID = json['Order_PayID'];
    orderPayStatus = json['Order_Pay_Status'];
    orderDlvyID = json['Order_DlvyID'];
    orderDlvyType = json['Order_Dlvy_Type'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    shopID = json['shop_id'];
    custState = json['Cust_State'];
    custCity = json['Cust_City'];
    custPinCode = json['Cust_PinCode'];
    custAddress = json['Cust_Address'];
    custPhone = json['Cust_Phone'];
    custLatitude = json['Cust_Latitude'];
    custLongitude = json['Cust_Longitude'];
    status = ProcessStatus(int.parse(json['Order_Status']) );
    if (json['Items'] != null) {
      items = new List<OrderItem>();
      json['Items'].forEach((v) {
        items.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Order_Number'] = this.orderNumber;
    data['cust_id'] = this.custId;
    data['Order_Value'] = this.orderValue;
    data['Order_Status'] = this.orderStatus;
    data['Order_Items'] = this.orderItems;
    data['Order_Delivery_Charge'] = this.orderDeliveryCharge;
    data['Order_Date'] = this.orderDate;
    data['Order_Pay_Type'] = this.orderPayType;
    data['Order_PayID'] = this.orderPayID;
    data['Order_Pay_Status'] = this.orderPayStatus;

    data['Order_DlvyID'] = this.orderDlvyID;
    data['Order_Dlvy_Type'] = this.orderDlvyID;

    data['shop_id'] = this.shopID;
    data['shop_name'] = this.shopName;
    data['shop_address'] = this.shopAddress;

    data['Cust_State'] = this.custState;
    data['Cust_City'] = this.custCity;
    data['Cust_PinCode'] = this.custPinCode;
    data['Cust_Address'] = this.custAddress;
    data['Cust_Phone'] = this.custPhone;
    data['Cust_Latitude'] = this.custLatitude;
    data['Cust_Longitude'] = this.custLongitude;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }

 Status ProcessStatus (OrderStatus) {
    switch (OrderStatus) {
      //CREATED
      case 0 : {
        return Status(
            name: Constant.CREATED, bgColor: Colors.teal[100],
            textColor: Colors.teal[900], iconAsset: 'orderStatus/orderCreated.svg'
        );
      } break;
      //IN-PROGRESS
      case 1 : {
        return Status(
            name: Constant.ON_PROCESS,    bgColor: Colors.greenAccent[100],
            textColor: Colors.green[900], iconAsset: 'orderStatus/orderInProgress.svg'
        );
      } break;

    //PACKAGING
      case 2 : {
        return Status(
            name: Constant.PREPARING_ORDER,    bgColor: Colors.lightGreen[50],
            textColor: Colors.lightGreen[900], iconAsset: 'orderStatus/orderPackaging.svg');
      } break;

    // //ORDER_DISPATCHED
    //   case 3    : {
    //     return Status(
    //         name: Constant.ORDER_DISPATCHED,    bgColor: Colors.yellow[100],
    //         textColor: Colors.yellow[900], iconAsset: 'orderStatus/orderDelivering.svg');
    //   } break;
    //DELIVER_ORDER
      case 3 : {
        return Status(
            name: Constant.DELIVER_ORDER,    bgColor: Colors.amber[100],
            textColor: Colors.amber[900], iconAsset: 'orderStatus/orderDelivering.svg');
      } break;

    //DELIVERED
      case 4    : {
        return Status(
            name: Constant.DELIVERED,    bgColor: Colors.orange[100],
            textColor: Colors.orange[900], iconAsset: 'orderStatus/orderDelivered.svg');
      } break;

    //CANCELLED
      case 7 : {
        return Status(
            name: Constant.CANCELLED,    bgColor: Colors.red[100],
            textColor: Colors.red[900], iconAsset: 'orderStatus/orderCancelled.svg');
      } break;

    //READY_COLLECT
      case 8    : {
        return Status(
            name: Constant.READY_COLLECT,    bgColor: Colors.blue[100],
            textColor: Colors.blue,     iconAsset: 'orderStatus/orderReadyCollect.svg'
        );
      } break;
      case 9    : {
        return Status(
            name: Constant.COLLECTED,    bgColor: Colors.orange[100],
            textColor: Colors.orange[900],     iconAsset: 'orderStatus/orderDelivered.svg'
        );
      } break;
    }
  }


  Future <void> placeOrder(Orders1 orderData) async{

    var token = await getTokens();
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "cust_token" : token,
      "cust_id": "1",
      "Order_Number": orderData.orderNumber,
      "Order_Value": orderData.orderValue,
      "Order_Status": orderData.status,
      "Order_Items": orderData.orderItems,
      "Order_Delivery_Charge": "0",
      "Order_Pay_Type": orderData.orderPayType,
      "Order_PayID": orderData.orderPayID,
      "Order_Pay_Status" :orderData.orderPayStatus,
      "Order_DlvyID": orderData.orderDlvyID,
      "Order_Dlvy_Type": orderData.orderDlvyType,
      "shop_id" : orderData.shopID,
      "shop_name" : orderData.shopName,
      "shop_address":orderData.shopAddress,
      "Cust_State": orderData.custState,
      "Cust_City": orderData.custCity,
      "Cust_PinCode": orderData.custPinCode,
      "Cust_Address": orderData.custAddress,
      "Cust_Phone": orderData.custPhone,
      "Cust_Latitude": orderData.custLatitude,
      "Cust_Longitude": orderData.custLongitude,
      "Items" :  orderData.items.map((v) => v.toJson()).toList()
    });
    print('I am in order service the order now');
    orderData.items.map((v) => print(v.toJson())).toList();
    Response response = await dio.post(Constant.BASE_URL+"/createOrder", data: formData);
    if (response.statusCode == 200) {
      // print(response.data);
      Map data = jsonDecode(response.data);
      // print(data["results"]);
      // print(data["results"]["status_type"]);
      this.statusNum = data["results"]["status"].toString();
      this.statusType=data["results"]["status_type"].toString();
      this.statusMsg=data["results"]["status_message"].toString();
      print(data);
    } else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }
}


Future <List<Orders1>> getOrder() async{
  print('/orders API called from Order Page @ '+ DateTime.now().toString());
  Dio dio = new Dio();
  var token = await getTokens();
  print(token);
  Response response = await dio.get(Constant.BASE_URL+"/order", queryParameters: {"token": token});
  if (response.statusCode == 200) {
    List <Orders1> listOrders = [];
    Map data = jsonDecode(response.data);
    // print(data);
    List newdata = data["results"]["data"];
    print('newdata');
    print(newdata);
    // var myOrderList = <String>[];
    for (var data in newdata) {
      Orders1 order = Orders1.fromJson(data);
      listOrders.add(order);
      // myOrderList.add(jsonEncode(data));
      // print(myOrderList);
    }
    print('/orders API data parsed successfully');

    // await placeOrder();
    // addCustomerOrdersToSP(myOrderList);
    // removeCustomerOrder();
    // print(await getCustomerOrdersfromSP());
    // // print(data["results"]["data"][0]);
    // Orders1 order = Orders1.fromJson(data["results"]["data"][0]);
    // print(order.toJson());
    // print(order.status.toString());
    // print(listOrders.toString());
    return listOrders;
     } else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}


Future <List<Orders1>> parseOrders(order) async {
    List <Orders1> listOrders = [];
    print(order);
    for (var data in order) {
    //   print(json.decode(data.toString()));
      // Orders1 order = Orders1.fromJson(data);
      // listOrders.add(order);
    }
    print('Methid emd');
    return listOrders;
}

Future <Orders1> createOrder(order) {
  // var orderObj = {
  //   "Order_Number": null,
  //   "cust_id": "1",
  //   "Order_Value": "250",
  //   "Order_Items": "2",
  //   "Order_Date": "2020-11-19 08:30:53",
  //   "Order_Status": "4",
  //   "Order_PayID": "78987",
  //   "Order_DlvyID": "789787",
  //   "Items":
  // };

  var orderObj = {
    "cust_id": "1",
    "Order_Value": "250",
    "Order_Status": "4",
    "Order_Items": "2",
    "Order_Delivery_Charge": "0",
    "Order_Pay_Type": "online",
    "Order_PayID": "RBC99",
    "Order_DlvyID": "789787",
    "Cust_State": "Uttar Pradesh",
    "Cust_City": "Agra",
    "Cust_PinCode": "282007",
    "Cust_Address": "20 HIG Sector 3 Awas Vikas",
    "Cust_Phone": "9536459875",
    "Cust_Latitude": "20",
    "Cust_Longitude": "22"
  };


  // Orders1.fromJson(json)
}


Future <void> placeOrder(Orders1 orderData) async{

  var token = await getTokens();
  Dio dio = new Dio();
  FormData formData = new FormData.fromMap({
    "cust_token" : token,
    "cust_id": "1",
    "Order_Value": orderData.orderValue,
    "Order_Status": orderData.status,
    "Order_Items": orderData.orderItems,
    "Order_Delivery_Charge": "0",
    "Order_Pay_Type": orderData.orderPayType,
    "Order_PayID": orderData.orderPayID,
    "Order_DlvyID": orderData.orderDlvyID,
    "Cust_State": orderData.custState,
    "Cust_City": orderData.custCity,
    "Cust_PinCode": orderData.custPinCode,
    "Cust_Address": orderData.custAddress,
    "Cust_Phone": orderData.custPhone,
    "Cust_Latitude": orderData.custLatitude,
    "Cust_Longitude": orderData.custLongitude,
    "Items" :  orderData.items.map((v) => v.toJson()).toList()
  });

  Response response = await dio.post(Constant.BASE_URL+"/createOrder", data: formData);
  if (response.statusCode == 200) {
    // print(response.data);
    Map data = jsonDecode(response.data);
    // print(data["results"]);
    // print(data["results"]["status_type"]);
    return data;
  } else {
    throw Exception('Failed to Login! Problem with server!');
  }
}