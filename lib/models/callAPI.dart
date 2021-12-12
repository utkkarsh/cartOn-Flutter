import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:http/http.dart' as http;

Future modifyProfileData(phoneNumber, name, emailID) async{
  var token = await getTokens();
  Dio dio = new Dio();

  print('Updating Profile Data ' + name.toString() + " " +emailID.toString()+ " " +phoneNumber);
  // FormData formData = new FormData.fromMap({
  //   "apikey": "Test01",
  //   "cust_token" : token,
  //   "phone": phoneNumber,
  //   "name": name.toString(),
  //   "email": emailID.toString()
  // });
  //
  // Response response = await dio.post(Constant.BASE_URL+"/user/update", data: formData);
  // Map data = jsonDecode(response.data);
  // return data;
}


Future<String> generateOrderId2(String key, String secret,double amount) async{
  print('This is generating order ID');
  Dio dio = new Dio();
  var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = authn;
  print(authn);

  // FormData formData = new FormData.fromMap({
  //   "amount": amount,
  //   "currency": "INR",
  //   "receipt": "receipt#R1",
  //   "payment_capture": 1
  // });
  var data = '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

  var res = await dio.post(
      'https://api.razorpay.com/v1/orders',
      data: data,
      options: Options(headers: <String, String>{'authorization': authn})
  );
  if (res.statusCode != 200) {
    print(res);
  }

  print('ORDER ID response => ${res.data}');
  return json.decode(res.data)['id'].toString();
}

Future<String> generateOrderId(String key, String secret,double amount) async{
  var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

  var headers = {
    'content-type': 'application/json',
    'Authorization': authn,
  };

  var data = '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

  // Dio dio = new Dio();
  // dio.options.headers['content-type'] = 'application/json';
  // dio.options.headers["Authorization"] = "${authn}";
  //
  // var res = await dio.post('https://api.razorpay.com/v1/orders', data: data);

  var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'), headers: headers, body: data);
  if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  print('ORDER ID response => ${res.body}');

  return json.decode(res.body)['id'].toString();
}