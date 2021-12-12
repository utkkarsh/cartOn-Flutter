import 'package:dio/dio.dart' ;
import 'dart:convert';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/models/sharedPreference.dart';

class Address {
  String houseName;
  String streetName;
  String landmark;
  String pinCode;
  String city;
  String country;
  String state;
  String addressName;
  String lat;
  String long;

  // Connection variables
  String status;
  String statusType;
  String statusMsg;
  Map responseData;

  Address({
    this.houseName,
    this.streetName,
    this.landmark,
    this.pinCode,
    this.city,
    this.state,
    this.country,
    this.addressName,
    this.lat,
    this.long});

  Address.fromJson(Map<String, dynamic> json)
      : houseName = json['houseName'],
        streetName = json['streetName'],
        landmark = json['landmark'],
        pinCode = json['pinCode'],
        addressName = json['addressName'],
        lat = json['lat'],
        long = json['long'],
        city = json['city'],
        country = json['country'],
        state = json['state']

  ;

  Map<String, dynamic> toJson() => {
    'houseName'  :houseName,
    'streetName' :streetName,
    'landmark' :landmark,
    'pinCode' :pinCode,
    'addressName' :addressName,
    'lat' :lat,
    'long' :long,
    'city' : city,
    'country' : country,
    'state' : state
  };

  void setData(Map data)
  {
    print(data);
    this.status = data["results"]["status"].toString();
    this.statusType=data["results"]["status_type"].toString();
    this.statusMsg=data["results"]["status_message"].toString();
  }


  Future addAddresstoDB(address) async{
    var token = await getTokens();
    var adr = jsonDecode(address);
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "apikey": "Test01",
      "address": adr,
      "cust_token" : token
    });

    Response response = await dio.post(Constant.BASE_URL+"/address", data: formData);
    if (response.statusCode == 200) {
      print('response --');
      print(response.data);
      Map data = jsonDecode(response.data.toString());
      print(data);
      setData(data);
      if (this.statusType == 'success')
      {
        // Save changes to Shared preferences.
        // addCustomerAddress(address);
      }
    }
    else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }
}


