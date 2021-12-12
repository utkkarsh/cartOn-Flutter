import 'dart:ffi';

class Shop {
  int shopId;
  String shopName;
  String shopCat;
  String image;
  String shopDetails;
  double shop_coordinates_lat;
  double shop_coordinates_long;

  Shop({this.shopId, this.shopName, this.shopCat, this.image,this.shop_coordinates_lat,this.shop_coordinates_long});

  Shop.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopCat = json['shop_cat'];
    image = json['image'];
    shop_coordinates_lat = json['shop_coordinates_lat'];
    shop_coordinates_long = json['shop_coordinates_long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_cat'] = this.shopCat;
    data['image'] = this.image;
    data['shop_coordinates_long'] = this.shop_coordinates_long;
    data['shop_coordinates_lat'] = this.shop_coordinates_lat;
    return data;
  }
}
