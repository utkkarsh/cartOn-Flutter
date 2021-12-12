import 'package:flutter/material.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class LocationBottomSheet extends StatefulWidget {
  @override
  _LocationBottomSheetState createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  String location_btn_msg = Constant.TURN_ON;
  bool btnEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  Future checkLocationAvailablity () async{
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
      {
        permission = await Geolocator.requestPermission();
      }

    if ( (permission == LocationPermission.always || permission == LocationPermission.whileInUse) )
      {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if(!serviceEnabled)
            {
              setState(() {
                location_btn_msg = 'Continue';
              });
              await Geolocator.openLocationSettings();

            }

        serviceEnabled = await Geolocator.isLocationServiceEnabled();

          if(serviceEnabled){
            setState(() {
              btnEnabled = false;
              location_btn_msg = "Fetching ...";
            });

            Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            print(position);
            List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
            print(placemarks);
            print("Location is now on");
          }
      }

  }

  @override
  Widget build(BuildContext context) {
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
                    text: "Device Location is Off.",
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
              child: ButtonWidget(
                text: location_btn_msg,
                fontSize: Constant.BUTTON_FONT,
                fontColor: Colors.white,
                buttonColor: Colors.blueGrey,
                isBorder: false,
                onPress: btnEnabled ? () async => {
                  checkLocationAvailablity()
                } : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
