import 'package:CartOn/models/ShopCategory.dart';
import 'package:dio/dio.dart' ;
import 'dart:convert';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/models/sharedPreference.dart';

class SignIn {

  String phoneNumber;
  String otpCode;
  bool auth;
  String token;
  String customerId;
  String status;
  String statusType;
  String statusMsg;
  Map responseData;

  void setData(Map data)
  { print(data);
    this.status = data["results"]["status"].toString();
    this.statusType=data["results"]["status_type"].toString();
    this.statusMsg=data["results"]["status_message"].toString();
       if (this.statusType == 'success')
      {
        this.otpCode = data["results"]["data"]["pin"].toString();
        this.responseData = data["results"]["data"];
      }
  }

  void setAuth(String phone,Map data)
  {
    this.customerId = data["results"]["data"]["cust_id"].toString();
    this.token=data["results"]["data"]["cust_token"].toString();
    this.auth= data["results"]["data"]["auth"]==1?true:false;
    this.phoneNumber = phone;
    addToken(this.token);
    addCustomerDetails(data["results"]["data"]["cust_name"], data["results"]["data"]["cust_phone"]);
    print("Customer Address is"+ data["results"]["data"]["address"].toString());
     if(data["results"]["data"]["address"]!= ""){
       addCustomerAddress(jsonEncode(data["results"]["data"]["address"]));
     }
     else
       {
         print('Customer Signing : Empty Address on customer profile.');
       }
  }

  Future <void> getOTP(phoneNumber) async{
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "apikey": "Test01",
      "phone": phoneNumber,
      "type":"PHONE",
      "pin":"0000"
    });

    Response response = await dio.post(Constant.BASE_URL+"/signin", data: formData);
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.data);
      setData(data);
    } else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }

  Future <void> registrationOTP(phoneNumber) async{
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "apikey": "Test01",
      "phone": phoneNumber,
      "type":"PHONE",
      "pin":"0000"
    });

    Response response = await dio.post(Constant.BASE_URL+"/register", data: formData);
    if (response.statusCode == 200) {
      // print(response.data);
      Map data = jsonDecode(response.data);
      // print(data["results"]);
      setData(data);
    } else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }

  Future validateLogin(phoneNumber, otpCode,name,type) async{
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "apikey": "Test01",
      "phone": phoneNumber,
      "type":"PIN",
      "pin": otpCode,
    //  new data
      "name": name,
    });

    var url = Constant.BASE_URL+"/signin";

    if(type=="signup")
      {
        url = Constant.BASE_URL+"/register";
      }
    print(url);
    Response response = await dio.post(url, data: formData);
    print(response.data);

    if (response.statusCode == 200) {
      print(response.data);
      Map data = jsonDecode(response.data);
      // print(data);
      setData(data);
      if (this.statusType == 'success')
        {
          setAuth(phoneNumber,data);
        }
    } else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }

  Future validateRegistration(phoneNumber, otpCode,name,type) async{
    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "apikey": "Test01",
      "phone": phoneNumber,
      "type":"PIN",
      "pin": otpCode,
      //  new data
      "name": name,
    });
    var url = Constant.BASE_URL+"/signin";
    if(type=="signup")
    {
      url = Constant.BASE_URL+"/register";
    }
    print('Calling -> '+url);
    Response response = await dio.post(url, data: formData);

    if (response.statusCode == 200) {
      // print(response.data);
      Map data = jsonDecode(response.data);
      // print(data);
      setData(data);
      if (this.statusType == 'success')
      {
        setAuth(phoneNumber,data);
      }
    } else {
      throw Exception('Failed to Login! Problem with server!');
    }
  }
}

Future getOTP(phoneNumber) async{
  Dio dio = new Dio();
  FormData formData = new FormData.fromMap({
    "apikey": "Test01",
    "phone": phoneNumber,
    "type":"PHONE",
    "pin":"0000"
  });
  Response response = await dio.post(Constant.BASE_URL+"/signin", data: formData);
  Map data = jsonDecode(response.data);
  return data;
}

Future validateLogin(phoneNumber, otpCode) async{
  Dio dio = new Dio();
  FormData formData = new FormData.fromMap({
    "apikey": "Test01",
    "phone": phoneNumber,
    "type":"PIN",
    "pin": otpCode
  });
  Response response = await dio.post(Constant.BASE_URL+"/signin", data: formData);
  Map data = jsonDecode(response.data);
  return data;
}
