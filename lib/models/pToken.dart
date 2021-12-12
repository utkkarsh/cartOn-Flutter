import 'dart:convert';

import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:dio/dio.dart';

class pToken {
  String ptoken;
  int ptokenLen;
  int ptokenNum;
  String ptokenKey;
  String ptokenSecret;

  pToken({this.ptokenKey, this.ptokenSecret});

  pToken.fromJson(Map<String, dynamic> json) {
    ptoken = json['ptoken'];
    ptokenLen = json['ptokenLen'];
    ptokenNum = json['ptokenNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ptoken'] = this.ptoken;
    data['ptokenLen'] = this.ptokenLen;
    data['ptokenNum'] = this.ptokenNum;
    return data;
  }
}


Future <pToken> getPayToken(String callerName) async{
  print('/pToken API called from '+ callerName + ' @ '+ DateTime.now().toString());
  var token = await getTokens();
  // print(token);
  Dio dio = new Dio();
  Response response = await dio.get(Constant.BASE_URL+"/payservice",queryParameters: {"cust_token": token} );
  // print(response);
  print(jsonDecode(response.data));

  if (response.statusCode == 200) {
    // print('I am in');
    Map data = jsonDecode(response.data);
    pToken token = pToken.fromJson(data["results"]["data"]);
    String result="";
    for(int i=0;i<token.ptoken.length;i++)
      {
        result = result + String.fromCharCode(token.ptoken.codeUnitAt(i) - token.ptokenNum);
      }
    print(result);
    token.ptokenKey=result.substring(0,token.ptokenLen);
    token.ptokenSecret=result.substring(token.ptokenLen);

    // pToken token = new pToken()
    print('/pToken API Result for '+ callerName + ' @ '+ DateTime.now().toString());
    return token;
  }
  else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}