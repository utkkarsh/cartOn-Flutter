import 'package:flutter/material.dart';
import 'package:CartOn/models/address.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/pages/locationService/getLiveLocation.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class LocationBtmSheet extends StatefulWidget {

  final bool gpsIndicator;
  LocationBtmSheet({this.gpsIndicator});
  @override
  _LocationBtmSheetState createState() => _LocationBtmSheetState(gpsIndicator);
}

class _LocationBtmSheetState extends State<LocationBtmSheet> with WidgetsBindingObserver {

  String location_btn_msg = Constant.TURN_ON;
  bool btnEnabled = true;
  bool serviceEnabled ;
  String locationTitle = Constant.DEVICE_LOCATION_OFF;
  _LocationBtmSheetState(this.serviceEnabled);

  @override
  void initState() {
    super.initState();
    serviceEnabled ? setState(()=>{locationTitle = Constant.DEVICE_LOCATION_ON}) : setState(()=>{locationTitle = Constant.DEVICE_LOCATION_OFF});
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('resumed');
      checkLocationAvailablity();
    }
  }


  Future checkLocationAvailablity () async{
    LocationPermission permission;


    permission = await Geolocator.checkPermission();
    // If permission was denied or denied forever request permission again
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
    {
      permission = await Geolocator.requestPermission();
    }
    // If other than check if GPS is ON ?
    // If GPS is ON , get coordinates and check if nearby coordinates are found.
    // If GPS is off , save the data to server

    if ( (permission == LocationPermission.always || permission == LocationPermission.whileInUse) )
    {

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // IF GPS was off , turn it on
      if(!serviceEnabled)
      {
        setState(() {
          locationTitle = Constant.DEVICE_LOCATION_OFF;
          location_btn_msg = 'Continue';
        });
        await Geolocator.openLocationSettings();
      }

      // If GPS is On , fetch the coordinates
      if(serviceEnabled){
        setState(() {
          btnEnabled = false;
          locationTitle = Constant.DEVICE_LOCATION_ON;
          location_btn_msg = "Modify Address";
        });
        // Step 1 : Determine Current Location
        Position position = await determinePositioninLatLong();
        List<Placemark> addrss = await determinePlacemark();
        Placemark place = addrss[0];
        print(place);
        // Step 2 : Check if existing address present in system

        Address address = Address (
            houseName: place.street,
            streetName: place.street,
            landmark: place.name,
            pinCode: place.postalCode,
            city: place.subAdministrativeArea,
            state: place.administrativeArea,
            country: place.country,
            addressName: 'Default'
        );

        // Address address = Address(addrss.)
        print(address.toJson());
      }
    }
  }

 turnonwidget ()  {
   return Container(
     height: 300,
     color: Colors.white70,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
       mainAxisSize: MainAxisSize.min,
       children: [
         Container(
           color: Colors.blue,
           child: Container(
             height: 80,
             width: 500,
             margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 TextWidget(
                   text: locationTitle,
                   fontSize: Constant.HINT_TEXT_FONT,
                   fontColor: Colors.white,
                   fontFamily: Constant.ROBOTO_MEDIUM,
                 ),
                 SizedBox(height: 5),
                 TextWidget(
                   text: "Please turn on device location to get accurate address \nand hasle free delivery.",
                   fontSize: 15,
                   fontColor: Colors.white70,
                   fontFamily: Constant.ROBOTO_REGULAR,
                 )
               ],
             ),
           ),
         ),
         SizedBox(height: 20),
         Center(
           child: Container(
             width: 150,
             child: Visibility(
               child: ButtonWidget(
                 text: location_btn_msg,
                 fontSize: Constant.BUTTON_FONT,
                 fontColor: Colors.white,
                 buttonColor: Colors.blueGrey,
                 isBorder: false,
                 onPress: () async => {
                   checkLocationAvailablity()
                 },
               ),
             ),
           ),
         )
       ],
     ),
   );
 }

 locationEnabledWidget () {
     return Container(
       height: 300,
       color: Colors.white70,
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start,
         mainAxisSize: MainAxisSize.min,
         children: [
           Container(
             color: Colors.blue,
             child: Container(
               height: 80,
               width: 500,
               margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   TextWidget(
                     text: 'Fetching Location',
                     fontSize: Constant.HINT_TEXT_FONT,
                     fontColor: Colors.white,
                     fontFamily: Constant.ROBOTO_MEDIUM,
                   ),
                   SizedBox(height: 5),
                   TextWidget(
                     text: "Please turn on device location to get accurate address \nand hasle free delivery.",
                     fontSize: 15,
                     fontColor: Colors.white70,
                     fontFamily: Constant.ROBOTO_REGULAR,
                   )
                 ],
               ),
             ),
           ),
           SizedBox(height: 20),
           Center(
             child: Container(
               width: 150,
               child: Visibility(
                 child: ButtonWidget(
                   text: location_btn_msg,
                   fontSize: Constant.BUTTON_FONT,
                   fontColor: Colors.white,
                   buttonColor: Colors.blueGrey,
                   isBorder: false,
                   onPress: btnEnabled ? () async =>
                   {
                     checkLocationAvailablity()
                   } : null,
                 ),
               ),
             ),
           )
         ],
       ),
     );
   }


  @override
  Widget build(BuildContext context) {
    return turnonwidget();
  }
}
