import 'package:CartOn/models/Shop.dart';
import 'package:CartOn/models/ShopCategory.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/pages/Nearby/ItemsNearby.dart';
import 'package:CartOn/pages/category_wid/CategoryTypeView.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewHorizontalList2.dart';
import 'package:CartOn/pages/grocery_list/list/GroceryViewList.dart';
import 'package:CartOn/pages/home/GroceryTypesView.dart';
import 'package:CartOn/pages/home/HomePromoView.dart';
import 'package:CartOn/pages/locationService/AddressBottomSheet.dart';
import 'package:CartOn/pages/locationService/LocationBottomSheet.dart';
import 'package:CartOn/pages/locationService/LocationBtmSht.dart';
import 'package:CartOn/pages/locationService/getLiveLocation.dart';
import 'package:CartOn/pages/shops/NearbyShops.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Helper.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:CartOn/models/address.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/util/Router.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  var currentAppState="normal";
  var currentAppCount=0;

  @override
  void initState() {
    super.initState();
    checkLocation();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('HOME_PAGE : paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('HOME_PAGE : resumed');
      // checkLocation();
    }
  }

  Future checkLocation () async{
    // Location Algorithm :
    // If Location service is enabled, check if there is a change in a pin code, If Yes, show an alert dialog requesting user to confirm
    //           if they need to change address or not, If they click yes, show a bottom_sheet with new address
    // If Location service is disabled, show a dialogBox alerting user that device location is turned off and request them to turn it on.

    var data = await getCustomerAddressInString();
    print(data);
    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    // removeCustomerAddress();

    if (isLocationServiceEnabled)
      {
        // Step 1 : Get current position and convert it approx placeMark
        Position position = await determinePositioninLatLong();
        print(position);
        List<Placemark> addrss = await determinePlacemark();
        Placemark place = addrss[0];
        print(addrss);
        // Step 2 : Check if existing address present in system
        Address address = Address (
            houseName: place.street,
            streetName: place.street,
            landmark: place.name,
            pinCode: place.postalCode,
            city: place.subAdministrativeArea,
            state: place.administrativeArea,
            country: place.country,
            addressName: 'Default',
        );
        //Step 3 : Check if there is existing data in shared preferences or not.
        // print(getCustomerAddressInString());
        if(await checkValid('address'))
          {
            // Step 3a: Data is present in shared preferences so please compare the data and proceed
            print('data hai');
            var data = Address.fromJson(await getCustomerAddress());
            // Address data = Address.fromJson(jsonDecode(await getCustomerAddress()));
            // Step 3b: Compare pin code of both the addresses , if they are different prompt user else no need to continue
            if(data.pinCode!=address.pinCode)
              {
                print('Different Addresses');
                // Step 3c: Prompt user with a bottom sheet to save new data
                _showMaterialDialog('Pin Code Changed','We have noticed that your location have been changed. Would you like to update to new location.',address);;
              }
            else{

            }
          }
        else{
          // Data is not present in shared preference so continue with new data.
          print('data nh hai');
          // print(address.toJson());
          _showMaterialDialog('Add Address','We have noticed that no address is associated with your profile. Please add your home address to Continue.',address);
          // addCustomerAddress(address);
        }
        print('data');
      }
    else{
      return _showMaterialDialog2(Constant.DEVICE_LOCATION_OFF, "Please turn on device location to get accurate address and hasle free delivery.");
    }
  }


  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    // getCategories();
    // getShopsFromDB();
    // determineCoordinates();
    // checkLocation();
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Pallete.appBgColor,
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(8,3,8,8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Feather.map_pin,
                    color:Pallete.experimentFontColor,
                    size: Constant.TEXT_FONT,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                      child:    FutureBuilder(
                              future: store.getAddressString() ,
                              builder: (BuildContext context, AsyncSnapshot snapshot ){
                                if(snapshot.data!=null)
                                  {
                                    return
                                      GestureDetector(
                                        onTap:(){
                                          Navigator.of(context).pushNamed(Routers.MAP_ADDRESS,arguments: 'location_data' );
                                        },
                                        child: TextWidget (
                                            // 'Delivering to : '+
                                              text:  snapshot.data,
                                            // getShopDistance(LatLng(widget.shop.shop_coordinates_lat, widget.shop.shop_coordinates_long), store.currentLocation),
                                            // style: TextStyle(
                                              fontColor: Pallete.experimentFontColor,
                                              fontSize: Constant.TEXT_FONT - 1,
                                              // : FontWeight.w300,
                                              fontFamily: Constant.ROBOTO_REGULAR,
                                              maxLines: 1,
                                          // )
                                        ),
                                      );
                                  }
                                else
                                  {
                                    return GestureDetector(
                                      onTap:(){
                                        Navigator.of(context).pushNamed(Routers.MAP_ADDRESS,arguments: 'location_data' );
                                      },
                                      child: Text (
                                          // 'Delivering to : '+
                                              'No Address Added',
                                          // getShopDistance(LatLng(widget.shop.shop_coordinates_lat, widget.shop.shop_coordinates_long), store.currentLocation),
                                          style: TextStyle(
                                            color: Pallete.experimentFontColor,
                                            fontSize: Constant.TEXT_FONT - 1,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: Constant.ROBOTO_REGULAR,
                                          )
                                      ),
                                    );
                                  }
                              })
                    ),
                  )
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Pallete.appBgColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomePromoView(),
                    CategoryTypesView(),
                    NearbyShopsView(),
                    // NearbyItemsView(),
                    GroceryTypesView(),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                    //       Constant.PADDING_VIEW * 2, Constant.PADDING_VIEW, 0),
                    //   child: TextWidget(
                    //     text: "Featured Products !!",
                    //     fontSize: Constant.HINT_TEXT_FONT,
                    //     fontColor: Pallete.textColor,
                    //     fontFamily: Constant.ROBOTO_MEDIUM,
                    //   ),
                    // ),
                    // GroceryViewHorizontalList(
                    //   listGrocery: Helper.getVegetableList(),
                    //   isFromHome: true,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW,
                    //       Constant.PADDING_VIEW * 2, Constant.PADDING_VIEW, 0),
                    //   child: TextWidget(
                    //     text: "Popular Shops Nearby ! ",
                    //     fontSize: Constant.HINT_TEXT_FONT,
                    //     fontColor: Pallete.textColor,
                    //     fontFamily: Constant.ROBOTO_BOLD,
                    //   ),
                    // ),
                    // ShopViewHorizontalList(
                    //   listShop: Helper.getShopList(),
                    //   isFromHome: true,
                    // ),
                    //
                    // GroceryViewList(
                    //   listGrocery: Helper.getVegetableList(),
                    //   isFromHome: true,
                    // )

                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  _showMaterialDialog(title,content,newAddress) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(Routers.MAP_ADDRESS,arguments: 'location_data' );
                }),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },

            )
          ],
        ));
  }

  _showMaterialDialog2(title,content) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                  // _showAddressBottomSheet(newAddress);
                }),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}
