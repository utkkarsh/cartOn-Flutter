import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:CartOn/models/address.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:CartOn/widgets/ButtonWidget.dart';
import 'package:CartOn/widgets/TextWidget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ionicons/ionicons.dart';

import 'getLiveLocation.dart';


class AddressBottomSheet extends StatefulWidget {
  final Address address;
  AddressBottomSheet({this.address});
  @override
  _AddressBottomSheetState createState() => _AddressBottomSheetState(address);
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final Address address;
  _AddressBottomSheetState(this.address);

  final _formKey = GlobalKey<FormState>();
  TextEditingController houseNoController ;
  TextEditingController streetController;
  TextEditingController landmarkController ;
  TextEditingController pinCodeController ;
  TextEditingController fixedController ;
  var state;
  var city;
  var country;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    houseNoController = new TextEditingController(text: address.houseName);
    streetController = new TextEditingController(text: address.streetName);
    landmarkController = new TextEditingController(text: address.landmark);
    pinCodeController = new TextEditingController(text: address.pinCode);
    fixedController = new TextEditingController(text: address.city + " , "+address.state);
    state = address.state;
    city = address.city;
    country = address.country;
  }

  @override
  void dispose(){
    houseNoController.dispose();
    streetController.dispose() ;
    landmarkController.dispose();
    pinCodeController.dispose() ;
    fixedController.dispose();
    super.dispose();
  }

  void saveAddress(  String houseName,  String streetName,   String landmark,  String pinCode) async{
    //create address object
    print(city + "," + country + "," + state);

    String addressString = houseName + "," + streetName + "," + landmark + "," + pinCode;
    print(addressString);
    List<Location> coordinates =  await determineCoordinates(addressString);
    Location longlat = coordinates[0];

    Address address = Address (
        houseName: houseName,
        streetName: streetName,
        landmark: landmark,
        pinCode: pinCode,
        city: city,
        state:state,
        country: country,
        addressName: 'Home',
        long: longlat.longitude.toString(),
        lat: longlat.latitude.toString(),
    );
    print(jsonEncode(address.toJson()));
    await address.addAddresstoDB(jsonEncode(address.toJson()));
    print(address.statusType);
    if(address.statusType == 'success')
      {
        setState(() {
          saved=true;
        });
      }
    // addCustomerAddress(address.toJson());
  }

  @override
  Widget build(BuildContext context) {
    print(address);
    return SafeArea(
      child: Container(
        height: 700,
        color: Colors.white70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.blue,
              child: Container(
                // color: Colors.green,
                height: 50,
                width: 500,
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: "Manage Address",
                      fontSize: Constant.PRICE_TEXT_FONT,
                      fontColor: Colors.white,
                      fontFamily: Constant.ROBOTO_MEDIUM,
                    ),
                    Container(
                      width: 150,
                      child: SizedBox(
                        height: Constant.BUTTON_HEIGHT,

                        child: RaisedButton.icon(
                          icon: Icon(
                            saved ? Ionicons.checkmark_done_outline : Ionicons.save_outline,
                            color:Colors.black,),
                          label: Text(
                            saved ? 'Saved' : 'Save',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  Constant.BUTTON_FONT,
                              fontFamily: Constant.ROBOTO_MEDIUM,
                            ),
                          ),
                          color: saved ? Colors.white12 : Colors.white70,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color:Colors.transparent)),

                          onPressed: () => {
                            saved ? null : saveAddress(houseNoController.text,streetController.text,landmarkController.text,pinCodeController.text)
                          } ,

                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(Constant.PADDING_VIEW, 50, Constant.PADDING_VIEW, 15),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    maxLength: 10,
                    style:
                    TextStyle(fontSize: 18, color: Pallete.textColor),
                    decoration: InputDecoration(
                        hintText: Constant.HINT_HOUSE_EXAMPLE,
                        hintStyle: TextStyle(
                            fontSize: Constant.TEXT_FONT,
                            fontFamily: Constant.ROBOTO_REGULAR),
                        alignLabelWithHint: true,
                        // floatingLabelBehavior:
                        //     FloatingLabelBehavior.always,
                        labelText: Constant.HINT_HOUSENAME,
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Constant.HINT_TEXT_FONT)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constant.EMPTY_DATE;
                      }
                      return null;
                    },
                    controller: houseNoController,
                    cursorColor: Pallete.textColor,
                    // keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    maxLength: 300,
                    style:
                    TextStyle(fontSize: 18, color: Pallete.textColor),
                    decoration: InputDecoration(
                        hintText: Constant.HINT_STREET_EXAMPLE,
                        hintStyle: TextStyle(
                            fontSize: Constant.TEXT_FONT,
                            fontFamily: Constant.ROBOTO_REGULAR),
                        alignLabelWithHint: true,
                        // floatingLabelBehavior:
                        //     FloatingLabelBehavior.always,
                        labelText: Constant.HINT_STREET,
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Constant.HINT_TEXT_FONT)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constant.EMPTY_DATE;
                      }
                      return null;
                    },
                    controller: streetController,
                    cursorColor: Pallete.textColor,
                    // keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    maxLength: 100,
                    style:
                    TextStyle(fontSize: 18, color: Pallete.textColor),
                    decoration: InputDecoration(
                        hintText: Constant.HINT_LANDMARK_EXAMPLE,
                        hintStyle: TextStyle(
                            fontSize: Constant.TEXT_FONT,
                            fontFamily: Constant.ROBOTO_REGULAR),
                        alignLabelWithHint: true,
                        // floatingLabelBehavior:
                        //     FloatingLabelBehavior.always,
                        labelText: Constant.HINT_LANDMARK,
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Constant.HINT_TEXT_FONT)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constant.EMPTY_DATE;
                      }
                      return null;
                    },
                    controller: landmarkController,
                    cursorColor: Pallete.textColor,
                    // keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    maxLength: 10,
                    style:
                    TextStyle(fontSize: 18, color: Pallete.textColor),
                    decoration: InputDecoration(
                        hintText: Constant.HINT_PINCODE_EXAMPLE,
                        hintStyle: TextStyle(
                            fontSize: Constant.TEXT_FONT,
                            fontFamily: Constant.ROBOTO_REGULAR),
                        alignLabelWithHint: true,
                        // floatingLabelBehavior:
                        //     FloatingLabelBehavior.always,
                        labelText: Constant.HINT_PIN_CODE,
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Constant.HINT_TEXT_FONT)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constant.EMPTY_DATE;
                      }
                      return null;
                    },
                    controller: pinCodeController,
                    cursorColor: Pallete.textColor,
                    keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    maxLength: 10,
                    style:
                    TextStyle(fontSize: 18, color: Pallete.textColor),
                    decoration: InputDecoration(
                        hintText:  city +" , " +state,
                        hintStyle: TextStyle(
                            fontSize: Constant.TEXT_FONT,
                            fontFamily: Constant.ROBOTO_REGULAR),
                        alignLabelWithHint: true,
                        // floatingLabelBehavior:
                        //     FloatingLabelBehavior.always,
                        labelText: 'City / State',
                        enabled: false,
                        labelStyle: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Constant.HINT_TEXT_FONT)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return Constant.EMPTY_DATE;
                      }
                      return null;
                    },
                    controller: fixedController,
                    cursorColor: Pallete.textColor,
                    keyboardType: TextInputType.phone,
                  ),
                ],)
              ),
            )
          ],
        ),
      ),
    );
  }
}
