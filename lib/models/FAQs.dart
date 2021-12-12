import 'dart:convert';

import 'package:CartOn/util/Constant.dart';
import 'package:dio/dio.dart';

class FAQ {
  int faqId;
  String faqQues;
  String faqAns;

  FAQ({this.faqId, this.faqQues, this.faqAns});

  FAQ.fromJson(Map<String, dynamic> json) {
    faqId = json['faq_id'];
    faqQues = json['faq_ques'];
    faqAns = json['faq_ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faq_id'] = this.faqId;
    data['faq_ques'] = this.faqQues;
    data['faq_ans'] = this.faqAns;
    return data;
  }
}


Future <List<FAQ>> getFAQs(String callerName) async{
  print('/faqs API called from '+ callerName + ' @ '+ DateTime.now().toString());
  // var token = await getTokens();
  // print(token);
  Dio dio = new Dio();
  Response response = await dio.get(Constant.BASE_URL+"/faq.json");
  // print(response);
  print(response.data);

  if (response.statusCode == 200) {
    // print('I am in');

    List <FAQ> listFaqs = [];
    // Map data = jsonDecode(response.data);
    Map data = response.data;
    // print(response.data);
    List newPromoData = data["results"]["data"];
    for (var data in newPromoData) {
      FAQ catg = FAQ.fromJson(data);
      listFaqs.add(catg);
    }
    // print(listFaqs);

    print('/faqs API Result for '+ callerName + ' @ '+ DateTime.now().toString());
    return listFaqs;
  }
  else {
    throw Exception('Failed to Fetch! Problem with server!');
  }
}