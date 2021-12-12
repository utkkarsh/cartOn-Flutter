import 'dart:convert';
import 'package:CartOn/models/shopItem.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:dio/dio.dart';
import 'package:CartOn/models/ShopProd.dart';

class Shop {
  String shopId;
  String shopCategory;
  String shopName;
  String shopUuid;
  String shopState;
  String shopPincode;
  String shopCity;
  String shopArea;
  String shopRating;
  String shopImage;
  String shopDeliveryTime;
  String minDeliveryPrice;
  String shopCompleteAddress;
  String shopLocality;
  String ispromoted;
  String avgRating;
  String isnew;
  String registrationDate;
  String shopGSTIN;
  String shopAdhar;
  String isVerified;
  String isAccountActive;
  String shopPhone;
  String rowId;
  String shopLat;
  String shopLong;
  String distance;
  List<ShopItem> items;
  bool shopMulCat;
  List<String> shopCategories;

  Shop(
      {this.shopId,
        this.shopCategory,
        this.shopName,
        this.shopUuid,
        this.shopState,
        this.shopPincode,
        this.shopCity,
        this.shopArea,
        this.shopRating,
        this.shopImage,
        this.shopDeliveryTime,
        this.minDeliveryPrice,
        this.shopCompleteAddress,
        this.shopLocality,
        this.ispromoted,
        this.avgRating,
        this.isnew,
        this.registrationDate,
        this.shopGSTIN,
        this.shopAdhar,
        this.isVerified,
        this.isAccountActive,
        this.shopPhone,
        this.rowId,
        this.shopLat,
        this.shopLong,
        this.distance,
        this.shopMulCat,
        this.shopCategories,
        this.items});

  Shop.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopCategory = json['shop_category'];
    shopName = json['shop_name'];
    shopUuid = json['shop_uuid'];
    shopState = json['shop_state'];
    shopPincode = json['shop_pincode'];
    shopCity = json['shop_city'];
    shopArea = json['shop_area'];
    shopRating = json['shop_rating'];
    shopImage = json['shop_image'];
    shopDeliveryTime = convertDeliveryTime(json['shop_delivery_time']);
    minDeliveryPrice = json['min_delivery_price'];
    shopCompleteAddress = json['shop_complete_address'];
    shopLocality = json['shop_locality'];
    ispromoted = json['ispromoted'];
    avgRating = json['avgRating'];
    isnew = json['isnew'];
    registrationDate = json['registration_date'];
    shopGSTIN = json['shop_GSTIN'];
    shopAdhar = json['shop_adhar'];
    isVerified = json['isVerified'];
    isAccountActive = json['isAccountActive'];
    shopPhone = json['shop_phone'];
    rowId = json['row_id'];
    shopLat = json['shop_lat'];
    shopLong = json['shop_long'];
    distance = convertDistance(json['distance']);
    shopMulCat = json['shop_mul_cat'];
    shopCategories = json['shop_categories'].cast<String>();
    if (json['Items'] != null) {
      items = new List<ShopItem>();
      json['Items'].forEach((v) {
            print('value is--> ' + jsonEncode(v));
            items.add(new ShopItem.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['shop_category'] = this.shopCategory;
    data['shop_name'] = this.shopName;
    data['shop_uuid'] = this.shopUuid;
    data['shop_state'] = this.shopState;
    data['shop_pincode'] = this.shopPincode;
    data['shop_city'] = this.shopCity;
    data['shop_area'] = this.shopArea;
    data['shop_rating'] = this.shopRating;
    data['shop_image'] = this.shopImage;
    data['shop_delivery_time'] = this.shopDeliveryTime;
    data['min_delivery_price'] = this.minDeliveryPrice;
    data['shop_complete_address'] = this.shopCompleteAddress;
    data['shop_locality'] = this.shopLocality;
    data['ispromoted'] = this.ispromoted;
    data['avgRating'] = this.avgRating;
    data['isnew'] = this.isnew;
    data['registration_date'] = this.registrationDate;
    data['shop_GSTIN'] = this.shopGSTIN;
    data['shop_adhar'] = this.shopAdhar;
    data['isVerified'] = this.isVerified;
    data['isAccountActive'] = this.isAccountActive;
    data['shop_phone'] = this.shopPhone;
    data['row_id'] = this.rowId;
    data['shop_lat'] = this.shopLat;
    data['shop_long'] = this.shopLong;
    data['distance'] = this.distance;
    data['shop_mul_cat'] = this.shopMulCat;
    data['shop_categories'] = this.shopCategories;
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//Retrieve data from API and save data to shared preference.
Future <List<Shop>> getShopsFromDB(String callerName, List coordinatesData) async{
  print('/shops API called from '+ callerName + ' @ '+ DateTime.now().toString());
  Dio dio = new Dio();
  var queryParameters  = coordinatesData!=null && coordinatesData.length==2?{"lat": coordinatesData[0],"long":coordinatesData[1]}:null;
  Response response = await dio.get(Constant.BASE_URL+"/shop",queryParameters: queryParameters);

  if (response.statusCode == 200) {
    print(response);
    List <Shop> listShops = [];
    Map data = jsonDecode(response.data);

    List responseData = data["results"]["data"];
    for (var data in responseData) {
      // print(data);
      Shop shop = Shop.fromJson(data);
      listShops.add(shop);
    }
    print('/shop API Result for '+ callerName + ' @ '+ DateTime.now().toString());
    return listShops;
  }
  else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}

convertDistance(distance)
{
  String distanceString = "1 Km";
  double doubleDistInMeters = double.parse(distance) * 1000;
  // "distance": "0.07944312656767934"
  print(doubleDistInMeters);
  if(doubleDistInMeters>1000.00)
  {
    var distance = doubleDistInMeters/1000.00;
    distanceString = distance.round().toString() + ' Kms.';
  }
  else
  {
    distanceString = doubleDistInMeters.round().toString() + ' Mtr.';
  }
  return distanceString;
}

convertDeliveryTime(deliveryTime)
{
  String deliveryString = "45 Mins";
  int delvTime = int.parse(deliveryTime);
  // "distance": "0.07944312656767934"
  print(delvTime);
  if(delvTime >= 60)
  {
    var time = delvTime/60;
    deliveryString = time.round().toString() + ' Hrs.';
  }
  else
  {
    deliveryString = delvTime.toString() + ' Mins.';
  }

  return deliveryString;
}