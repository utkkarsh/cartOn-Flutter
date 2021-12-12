import 'dart:convert';
import 'package:CartOn/models/Orders.dart';
import 'package:CartOn/models/address.dart';
import 'package:latlng/latlng.dart';
import 'package:shared_preferences/shared_preferences.dart';

deleteSharedPreferenceData() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

addToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

getTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tokenValue = prefs.getString('token');
  return tokenValue;
}

deleteToken () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('token');
  if (checkValue)
    {
      prefs.remove("token");

    }
}



getCustomerAddress () async {
  final prefs = await SharedPreferences.getInstance();
  var data = prefs.getString('address');
  // print('getting address from SP' + data);
  return data!=null?jsonDecode(data):null;
}

addCustomerAddress (address) async {
  final prefs = await SharedPreferences.getInstance();
  print('Adding Customer Address to SP :' + json.encode(address));
  // print(json.encode(address));
  prefs.setString('address', address);
}


clearCustomerLocation () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('location');
  if (checkValue)
  {
    prefs.remove("location");

  }

}

getCustomerLocation () async {
  final prefs = await SharedPreferences.getInstance();
  // print(jsonDecode(prefs.getString('location')));
  print('SharedPref - Getting Customer Saved Location');
  var data = prefs.getString('address');
  // var data = prefs.getString('location');
  return data!=null?[jsonDecode(data)["lat"],jsonDecode(data)["long"]]:null;
}

addCustomerLocation (LatLng location) async {
  final prefs = await SharedPreferences.getInstance();
  // print(json.encode(address));
  var locString = location.latitude.toString()+","+location.longitude.toString();
  prefs.setString('location', locString);
}

getCustomerOrdersfromSP () async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('order');
  // print(parseOrders(prefs.getStringList('order')));
}

addCustomerOrdersToSP (order) async {
  final prefs = await SharedPreferences.getInstance();
  // var data = ["{Order_Number: 1, cust_id: 1, Order_Value: 250, Order_Items: 2, Order_Date: 2020-11-19 08:30:53, Order_Status: 4, Order_PayID: 78987, Order_DlvyID: 789787, Items: [{cust_id: 1, order_number: 1, item_seq_no: 1, prod_number: AB123, item_value: 20, item_discount: 0, vendor_id: 9856598}, {cust_id: 1, order_number: 1, item_seq_no: 2, prod_number: AB152, item_value: 55, item_discount: 0, vendor_id: 25655569}]}", "{Order_Number: 2, cust_id: 1, Order_Value: 20, Order_Items: 1, Order_Date: 2020-11-19 08:30:53, Order_Status: 4, Order_PayID: 78987, Order_DlvyID: 789787, Items: [{cust_id: 1, order_number: 2, item_seq_no: 1, prod_number: AB129, item_value: 20, item_discount: 0, vendor_id: 9856598}]}"];
  // prefs.remove("order");
  var myorderList =  <String>[];
  for ( var i in order)
    {
      myorderList.add(i);
      // print(i);
    }
  print(myorderList);
  prefs.setStringList("order", myorderList );
  // print(prefs.getStringList("order")); // [foobar]
}
removeCustomerOrder () async {
  final prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('order');
  if (checkValue)
  {
    prefs.remove("order");
  }
}

removeCustomerAddress () async {
  final prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey('address');
  if (checkValue)
  {
    prefs.remove("address");
  }
}

addCustomerDetails (custName, custPhone) async {
  final prefs = await SharedPreferences.getInstance();
  var myDetailsList =  <String>[];
  myDetailsList.add(custName);
  myDetailsList.add(custPhone);
  prefs.setStringList("personalDetails", myDetailsList );
}

getCustomerDetails () async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('personalDetails');
}

checkValid (key) async {
  var value = true;
  final prefs = await SharedPreferences.getInstance();
  bool checkValue = prefs.containsKey(key);
  if (!checkValue)
  {
    value = false;
  }
  return value;
}

 getCustomerAddressInString () async {
  final prefs = await SharedPreferences.getInstance();
  var address= prefs.getString('address');
  String addressString="";
  if(address!=null)
    {
      var data = Address.fromJson(json.decode(address));
      addressString = data.houseName + ", near " + data.landmark + ", " + data.streetName +  ", " +
          data.city;
    }
  // var dataString = data.houseName + "," + data.streetName  + "," + data.landmark  + "," + data.pinCode;
  // print(dataString);
  return address!=null?addressString:null;
}

