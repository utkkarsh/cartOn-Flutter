import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/CampaignAd.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:ui';
import 'package:emojis/emojis.dart';
import 'package:im_animations/im_animations.dart';

class HomePromoView extends StatefulWidget {
  @override
  _HomePromoViewState createState() => _HomePromoViewState();
}

class _HomePromoViewState extends State<HomePromoView> {

  String custName="";

  List images = [
    // 'promo1.png',
    // 'promo2.png',
    'promo3.png',
    'promo4.jpg',
    // 'promo5.jpg',
    'promo6.jpg',
    'promo7.jpg'
  ];
  List colorList = [
    // Pallete.primaryColor,
    // Colors.teal,
    Colors.blue,
    Colors.teal,
    // Colors.red,
    Colors.teal,
    Colors.red,
  ];

  Future getDatafromAPI() async {
    var store = Provider.of<MyStore>(context);
    //
    if(store.getCampaignListLength()>0)
    {
      return store.campaignPromoList;
    }
    else
    {
    List<CampaignAd> promos = await getCampaignPromos('CAMPAIGN_LIST');
    // List<Shop> shops = await getShopsFromDB();
    print(promos);
    if(promos.length>0 )
    {
      store.addtoCampaignList(promos);
    }
    return promos;
  }}

  Future getCustomerName() async {
    var store = Provider.of<MyStore>(context);
    print('HomeScreen : Getting Customer Name from SP to be displayed');
    String tempData = store.getCustomerName();
    print(tempData);

  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: Constant.HALF_PADDING_VIEW,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Constant.PADDING_VIEW, Constant.HALF_PADDING_VIEW - 5, 0, 0),
          child: FutureBuilder(
            future: store.getCustomerName(),
            builder: (BuildContext context, AsyncSnapshot snapshot ){
              if(snapshot.data!=null)
              {
                return
                  Row(
                    children: [
                      TextWidget(
                        text: "Hey"+ ", " + snapshot.data.toString().split(" ")[0] +" ! " ,
                        fontSize: Constant.HINT_TEXT_FONT + 4,
                        fontColor: Pallete.textColor,
                        fontFamily: Constant.ROBOTO_BOLD,
                      ),
                      Image.asset(
                        '${Constant.PATH_IMAGE}/wavingHands.gif',
                        width: 40,
                        height: 40
                      )

                    ],
                  );
              }
              else
              {
                return TextWidget(
                  text: "Hey " + Emojis.handWithFingersSplayed + ", "  ,
                  fontSize: Constant.HINT_TEXT_FONT + 4,
                  fontColor: Pallete.textColor,
                  fontFamily: Constant.ROBOTO_BOLD,
                );
              }
            },
          ),
        ),

        // SizedBox(
        //   height: Constant.HALF_PADDING_VIEW,
        // ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(
        //       Constant.PADDING_VIEW, Constant.HALF_PADDING_VIEW - 5, 0, 0),
        //   child: TextWidget(
        //     text: "Offers for you",
        //     fontSize: Constant.HINT_TEXT_FONT,
        //     fontColor: Pallete.textColor,
        //     fontFamily: Constant.ROBOTO_BOLD,
        //   ),
        // ),
        SizedBox(
          height: Constant.HALF_PADDING_VIEW,
        ),
        // Container(
        //   // color: Pallete.primaryColor,
        //   // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        //   height: MediaQuery
        //       .of(context)
        //       .size
        //       .height * 0.25,
        //   child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 4,
        //       itemBuilder: (context, index) {
        //         return Container(
        //             width: MediaQuery
        //                 .of(context)
        //                 .size
        //                 .width * 0.90,
        //             padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
        //             child: Card(
        //               color: colorList[index],
        //               child: Container(
        //                 child: FittedBox(
        //                   fit: index >= 1 ? BoxFit.fill : BoxFit.contain,
        //                   child: Image.asset(
        //                     '${Constant.PATH_IMAGE}/${images[index]}',
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //               ),
        //             ));
        //       }),
        // ),

        Container(
          height: MediaQuery
            .of(context)
            .size
            .height * 0.24 < 150 ? 210 :  MediaQuery
              .of(context)
              .size
              .height * 0.24,

          child: FutureBuilder(
            future: getDatafromAPI() ,
            builder: (BuildContext context, AsyncSnapshot snapshot ){
              if (snapshot.data == null)
              {
                return Container(
                  child: SpinKitPulse(
                    color: Colors.blue,
                    size: 50.0,
                  ),
                );
              }
              if (snapshot.data.length>0)
              {
                // store.addtoCategoryList(snapshot.data);
                // print(snapshot.data.length);
                print(MediaQuery
                    .of(context)
                    .size
                    .height * 0.24);
                return Container (
                    height: 120.0,
                    // color: Colors.blue,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                          CampaignAd newPromoMember = snapshot.data[index];
                          return Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.90 > 390 ? 385: 390,
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Card(
                                color: colorList[index % 4],
                                // semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                      image: NetworkImage(
                                        newPromoMember.campaignBanner,
                                      ),
                                      fit: BoxFit.cover,
                                      scale: 2,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  child: ClipRRect( // make sure we apply clip it properly
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.grey.withOpacity(0.1),
                                        child: Image.network(
                                            newPromoMember.campaignBanner,
                                            fit: BoxFit.fill
                                        ),
                                    ),
                                  )),
                                  // color: Colors.green,
                                  // ),
                                ),
                              ));
                        })
                );
              }
              else
              {
                return Container();
              }
            },
          ),
        ),

      ],
    );
  }
}