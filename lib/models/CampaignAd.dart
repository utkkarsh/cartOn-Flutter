import 'dart:convert';
import 'package:CartOn/util/Constant.dart';
import 'package:dio/dio.dart';
import 'package:CartOn/models/sharedPreference.dart';

class CampaignAd {
  String campaignId;
  String campaignName;
  String campaignType;
  String campaignBanner;
  String campaignEndDate;
  String campaignDescription;

  CampaignAd(
      {this.campaignId,
        this.campaignName,
        this.campaignType,
        this.campaignBanner,
        this.campaignEndDate,
        this.campaignDescription});

  CampaignAd.fromJson(Map<String, dynamic> json) {
    campaignId = json['campaign_id'];
    campaignName = json['campaign_name'];
    campaignType = json['campaign_type'];
    campaignBanner = json['campaign_banner'];
    campaignEndDate = json['campaign_end_date'];
    campaignDescription = json['campaign_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaign_id'] = this.campaignId;
    data['campaign_name'] = this.campaignName;
    data['campaign_type'] = this.campaignType;
    data['campaign_banner'] = this.campaignBanner;
    data['campaign_end_date'] = this.campaignEndDate;
    data['campaign_description'] = this.campaignDescription;
    return data;
  }
}


//Retrieve data from API and save data to shared preference.
Future <List<CampaignAd>> getCampaignPromos(String callerName) async{
  print('/campaign API called from '+ callerName + ' @ '+ DateTime.now().toString());
  var token = await getTokens();
  print(token);
  Dio dio = new Dio();
  Response response = await dio.get(Constant.BASE_URL+"/campaign", queryParameters: {"token": token});
  print(response);
  if (response.statusCode == 200) {
    List <CampaignAd> listPromos = [];
    Map data = jsonDecode(response.data);

    List newPromoData = data["results"]["data"];
    for (var data in newPromoData) {
      print(data);
      CampaignAd catg = CampaignAd.fromJson(data);
      listPromos.add(catg);
    }
    print('/campaign API Result for '+ callerName + ' @ '+ DateTime.now().toString());
    return listPromos;
  }
  else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}