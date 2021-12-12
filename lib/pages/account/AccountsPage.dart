import 'package:flutter/material.dart';
import 'package:CartOn/pages/account/HelpSupport.dart';
import 'package:CartOn/pages/account/ModifyProfile.dart';
import 'package:CartOn/pages/grocery_list/detail/GroceryProductDescription.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/util/Router.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:latlng/latlng.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  var custName =  Constant.USER_NAME;
  var phone = Constant.DUMMY_MOBILE_EXAMPLE;
  var email = '';


  void clearSharedPreferenceData() async {
    await deleteToken();
    await deleteSharedPreferenceData();
  }

  getUserData () async {
    // var data = await addCustomerLocation(LatLng(26.00000 , 78.000000));
    // await clearCustomerLocation();
    var list = <String>[];
    list = await getCustomerDetails();
    if ( list.length > 1)
      {
        setState(() {
          custName = list[0];
          phone = list[1];
          email = list[3];
        });
      }
    print(custName + phone);
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);

    // getUserData();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Pallete.appBgColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 0, 0, Constant.PADDING_VIEW),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW,
                  Constant.PADDING_VIEW,
                  Constant.PADDING_VIEW,
                  Constant.PADDING_VIEW / 2),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('${Constant.PATH_IMAGE}/profile.jpg'),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(Constant.PADDING_VIEW),
                    child: FutureBuilder(
                      future: getUserData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot ){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: custName,
                              fontColor: Pallete.textColor,
                              fontSize: Constant.APP_BAR_TEXT_FONT,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: TextWidget(
                                text: phone,
                                fontColor: Pallete.textSubTitle,
                                fontSize: Constant.TEXT_FONT,
                                fontFamily: Constant.ROBOTO_MEDIUM,
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: ()=>{
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                isScrollControlled: true,
                builder: (context) =>

                Container(
                    child: ModifyProfile(userName: custName,userEmail: email,userPhone: phone),
                    ),
              )
              },

              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Pallete.appBgColor,
                child: GroceryProductDescription(
                    title: "My Account",
                    description: "Change Your Basic Profile",
                    icon: Feather.settings,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: ()=>{
                Navigator.of(context).pushNamed(Routers.MAP_ADDRESS,arguments: 'location_data' ),
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Pallete.appBgColor,
                child: GroceryProductDescription(
                    title: "My Address", description: "Change Address Settings",
                  icon: Feather.map,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: ()=>{
                Navigator.of(context).pushNamed(Routers.FAQ,arguments: 'location_data' ),
              },
              child: Container(
                color: Pallete.appBgColor,
                width: MediaQuery.of(context).size.width,
                child: GroceryProductDescription(
                    title: "FAQ's", description: "Frequently Asked Questions",
                  icon: Feather.help_circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
              child: Divider(
                thickness: 1,
              ),
            ),
            GestureDetector(
              onTap: ()=>{
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) =>
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: HelpSupport(),
                        ),
                      ),
                )              },
              child: Container(
                color: Pallete.appBgColor,
                width: MediaQuery.of(context).size.width,
                child: GroceryProductDescription(
                    title: "Help & Support", description: "Get Support From Us",
                  icon: MaterialCommunityIcons.face_agent,
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Constant.PADDING_VIEW, 0, Constant.PADDING_VIEW, 0),
              // child: Divider(
              //   thickness: 1,
              // ),
            ),

            SizedBox(
              height: Constant.PADDING_VIEW,
            ),
            ButtonWidget(
                text: "Logout",
                buttonColor: Pallete.secondaryButtonColor,
                buttonShadowColor: Pallete.secondaryButtonColor,
                buttonBackgroundColor: Pallete.appBgColor,
                fontSize: Constant.HINT_TEXT_FONT,
                onPress: () async {
                  clearSharedPreferenceData();
                  store.clearItemList();
                  store.clearCart();
                  store.clearShopList();
                  Navigator.pushNamedAndRemoveUntil(context,
                  Routers.LANDING, ModalRoute.withName(Routers.LANDING));
                },
             ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,Constant.PADDING_VIEW*2,0,Constant.PADDING_VIEW),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: 'Made in ',
                          fontColor: Pallete.itemDescColor,
                          fontSize: Constant.APP_BAR_TEXT_FONT-3,
                          fontFamily: Constant.QS_SEMIBOLD,
                        ),
                        TextWidget(
                            text: _flagEmoji(),
                          fontColor: Pallete.textColor,
                          fontSize: Constant.APP_BAR_TEXT_FONT-3,
                          fontFamily: Constant.QS_SEMIBOLD,
                        ),
                        TextWidget(
                          text: ' with ',
                          fontColor: Pallete.itemDescColor,
                          fontSize: Constant.APP_BAR_TEXT_FONT-3,
                          fontFamily: Constant.QS_SEMIBOLD,
                        ),
                        Icon(Foundation.heart,color: Colors.red,),
                      ],
                    ),
                    TextWidget(
                      text: ' version 1.0.11 ',
                      fontColor: Pallete.itemDescColor,
                      fontSize: Constant.APP_BAR_TEXT_FONT-9,
                      fontFamily: Constant.QS_REGULAR,
                    )
                  ],
                ),),
            )
          ],
        ),
      ),
    );
  }

   _flagEmoji() {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    String country = "IN";

    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji =
        String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    print(emoji);
    return emoji;
  }
}


