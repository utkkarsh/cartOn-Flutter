import 'package:flutter/material.dart';
import 'package:dio/dio.dart' ;
import 'package:CartOn/pages/modal/Orders.dart';
import 'dart:convert';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/models/sharedPreference.dart';

class Order {

  Future <Map> getOrder() async{
    Dio dio = new Dio();
    var token = await getTokens();
    print(token);
    Response response = await dio.get(Constant.BASE_URL+"/order", queryParameters: {"token": token});
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.data);
      return data;
    } else {
      throw Exception('Failed to Fetch! Problem with server!');
    }
  }
}
