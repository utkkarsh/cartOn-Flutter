import 'dart:convert';
// import 'dart:js';
import 'package:CartOn/util/Constant.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class ShopCategory {
  String categoryId;
  String categoryName;
  String categoryDesc;
  String categoryImage;

  ShopCategory(
      {this.categoryId,
        this.categoryName,
        this.categoryDesc,
        this.categoryImage});

  ShopCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryDesc = json['category_desc'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['category_desc'] = this.categoryDesc;
    data['category_image'] = this.categoryImage;
    return data;
  }
}

//Retrieve data from API and save data to shared preference.
Future <List<ShopCategory>> getCategories(String callerName) async{
  print('/category API called from '+ callerName + ' @ '+ DateTime.now().toString());
  Dio dio = new Dio();
  Response response = await dio.get(Constant.BASE_URL+"/categories");

  if (response.statusCode == 200) {
    List <ShopCategory> listCatg = [];
    Map data = jsonDecode(response.data);

    List newdataCatg = data["results"]["data"];
    for (var data in newdataCatg) {
      ShopCategory catg = ShopCategory.fromJson(data);
      listCatg.add(catg);
    }
    print('/category API Result for '+ callerName + ' @ '+ DateTime.now().toString());
    return listCatg;
  }
  else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}