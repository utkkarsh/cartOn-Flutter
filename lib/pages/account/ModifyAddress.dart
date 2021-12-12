import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/models/address.dart';
import 'package:CartOn/util/Pallete.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/locationService/getLiveLocation.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:CartOn/models/sharedPreference.dart';
import 'dart:convert';
import 'package:CartOn/models/Shop.dart';

class ModifyAddress extends StatefulWidget {
  @override
  _ModifyAddressState createState() => _ModifyAddressState();
}

class _ModifyAddressState extends State<ModifyAddress> with WidgetsBindingObserver {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController houseNoController;
  TextEditingController landmarkController;

  var tempHouseNo = "";
  var tempLandmark = "";
  bool saved = false;
  var latitude = 26.2208217;
  var longitude = 78.2077667;
  var globalAddressString = "Your Relative Address will appear over here.";

  Address globalAddress = Address();
  MapController _mapctl = MapController();
  List<Placemark> addrss;

  @override
  void initState() {
    super.initState();
    houseNoController = TextEditingController();
    landmarkController = TextEditingController();
    getSavedCoordinates();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    houseNoController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('MAP : paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('MAP : resumed');
    }
  }

  changePositioninMap(position, route) async {
    if (route == "oldData") {
      setState(() {
        saved = false;
        latitude = position.latitude;
        longitude = position.longitude;
      });
    }
    else {
      await getDatafromPositions(position);
      setState(() {
        saved = false;
        latitude = position.latitude;
        longitude = position.longitude;
        tempLandmark = "";
        tempHouseNo = "";
      });
    }

    _mapctl.move(latLng.LatLng(position.latitude, position.longitude), 19);
  }

  fetchDataonAddressChange(LatLng position) async{
    print('Address Change is being called');
    var store = Provider.of<MyStore>(context,listen: false);
    //Call ShopService on addressChange with updated coordinates:
    List<Shop> shops = await getShopsFromDB('STORE -> Address Change',[position.latitude,position.longitude]);
    store.clearShopList();
    store.clearItemList();

    if(shops.length > 0 )  // data fetched from API
      {
        print('ModifyAddress New Data fetched -> Total '+shops.length.toString()+' shops Added');
      store.addtoShopList(shops);
    }
  }

  getDatafromPositions(LatLng position) async {
    addrss = await determinePlacemarkfromLatLong(
        LatLng(position.latitude, position.longitude));
    print(position.latitude.toString() + ' , ' + position.longitude.toString());
    extractAddress(addrss[0], position);
  }

  getStringFromAddress(String type, Address tempAddress) {
    String addressString = tempAddress.streetName + ", " +
        tempAddress.city + ", " +
        tempAddress.state + " - " +
        tempAddress.pinCode;

    if (type == "onSave") {
      addressString =
          tempAddress.houseName + ", near " + tempAddress.landmark + ", " +
              tempAddress.streetName + ", " +
              tempAddress.city;
    }
    return addressString;
  }

  extractAddress(Placemark placemark, LatLng position) {
    print(placemark);

    // String addressString = (placemark.subLocality!=null?placemark.subLocality:placemark.street) + ", " + placemark.subAdministrativeArea  + ", " + placemark.administrativeArea + ", " + placemark.postalCode;
    // print(addressString);
    Address address = Address(
      houseName: '',
      streetName: placemark.subLocality != null
          ? placemark.subLocality
          : placemark.locality,
      landmark: placemark.subLocality != null
          ? placemark.subLocality
          : placemark.locality,
      pinCode: placemark.postalCode,
      city: placemark.subAdministrativeArea,
      state: placemark.administrativeArea,
      country: placemark.country,
      addressName: 'Home',
      long: position.longitude.toString(),
      lat: position.latitude.toString(),
    );
    String addressString = getStringFromAddress('normal', address);
    print(addressString);

    setState(() {
      globalAddress = address;
      globalAddressString = addressString;
    });
  }

  changeMaptoCurrentLocation() async {
    print('MAP : Changing Map to Current Location');
    //check if map services are on if not request user to turn on the services.
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    print(
        'Location service : enabled = ' + isLocationServiceEnabled.toString());
    //Determine user's current location.
    //Point map to current location.
    if (isLocationServiceEnabled) {
      Position position = await determinePositioninLatLong();
      // addrss = await determinePlacemarkfromLatLong(LatLng(position.latitude,position.longitude));
      // print(position.latitude.toString() +' , '+ position.longitude.toString());
      // extractAddress(addrss[0],position);
      // print(addrss[((addrss.length+1)~/2).toInt()]);
      // print(addrss);
      changePositioninMap(
          LatLng(position.latitude, position.longitude), "other");
    }
    else {
      return _showMaterialDialog2(Constant.DEVICE_LOCATION_OFF,
          "Please turn on device location to get accurate address and hasle free delivery.");
    }
  }

  getSavedCoordinates() async {
    //Get customer saved Address, if present fetch saved location from address
    //otherwise request user to provide current location
    // await removeCustomerAddress();
    var addressData = await getCustomerAddress();
    var addressDataString = await getCustomerAddressInString();
    print(addressDataString.toString());
    if (addressData != null ) {
      Address address = Address.fromJson(addressData);
      var addressString = await getCustomerAddressInString();
      // print(address.lat);
      changePositioninMap( LatLng(double.parse(address.lat), double.parse(address.long)),  "oldData");
      //Call ShopService on addressChange with updated coordinates:
      setState(() {
        tempLandmark = address.landmark;
        tempHouseNo = address.houseName;
        globalAddressString = addressString;
        saved = true;
      });
    }
    else {
      // Position position = await Geolocator.getLastKnownPosition();
      // addrss = await determinePlacemarkfromLatLong(LatLng(double.parse(data[0]),double.parse(data[1])));
      // print(addrss[0]);
      await changeMaptoCurrentLocation();
    }
    print(globalAddressString);
  }

  saveHNLtoAddress(String house, String landmark, store) async{
    //Create Address Variable
    Address address = Address(
      houseName: house,
      streetName: globalAddress.streetName,
      landmark: landmark,
      pinCode: globalAddress.pinCode,
      city: globalAddress.city,
      state: globalAddress.state,
      country: globalAddress.country,
      addressName: globalAddress.addressName,
      long: globalAddress.long,
      lat: globalAddress.lat,
    );

    String addressString = getStringFromAddress('onSave', address);
    await address.addAddresstoDB(jsonEncode(address.toJson()));
    await fetchDataonAddressChange(LatLng(double.parse(address.lat), double.parse(address.long)));
    //Save this address to Shared Preference and to the store for fast access.
    store.updateLocation(LatLng(latitude, longitude));
    store.updateAddress(addressString, address);

    setState(() {
      globalAddress = address;
      saved = true;
      tempHouseNo=house;
      tempLandmark=landmark      ;
      // globalAddressString = addressString;
    });
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            mapController: _mapctl,
            options: new MapOptions(
                center: latLng.LatLng(latitude, longitude),
                minZoom: 13.5,
                zoom: 17,
                maxZoom: 18.499999,
                onTap: (point) async =>
                    changeTapPosition(point.latitude, point.longitude),
                onLongPress: (point) async =>
                    changeTapPosition(point.latitude, point.longitude),
                slideOnBoundaries: true
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate:
                "https://api.mapbox.com/styles/v1/utkkarshsharma/ckj0d957w0tj319o4nm1m2x7q/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidXRra2Fyc2hzaGFybWEiLCJhIjoiY2tqMGQyd21sNGtwNjJxcWpmNnlxdTN2YiJ9.dUX7SCSk9cK9wLsLC4SDyg",
                additionalOptions: {
                  'accessToken': 'pk.eyJ1IjoidXRra2Fyc2hzaGFybWEiLCJhIjoiY2tqMGQyd21sNGtwNjJxcWpmNnlxdTN2YiJ9.dUX7SCSk9cK9wLsLC4SDyg',
                  'id': 'mapbox.streets',
                },
              ),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 80.0,
                    height: 80.0,
                    point: latLng.LatLng(latitude, longitude),
                    builder: (ctx) =>
                    new Container(
                      child:
                      AvatarGlow(
                        endRadius: 110.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        glowColor: Colors.orange,
                        child:
                        SvgPicture.asset(
                          '${Constant.PATH_IMAGE}/svg/location.svg',
                          height: 55,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Positioned(
            bottom: 10.0,
            left: 5.0,
            right: 5.0,
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    mini: true,
                    onPressed: () async {
                      changeMaptoCurrentLocation();
                    },
                    child: Icon(
                      MaterialIcons.my_location, color: Colors.black45,),
                    backgroundColor: Colors.white,
                    focusColor: Colors.white70,
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Select Delivery Location",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        addressToString(),
                        fillAddressData(),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                            ),

                            onPressed: saved ? null : () {
                                validate(store);
                            },
                            color: saved ? Pallete.buttonDisabledColor : Pallete
                                .addItemButtonColor3,
                            child: Text(saved ? 'Saved' : 'Save'
                            //   ,style: TextStyle(
                            //   color: Pallete.textColorWhite,
                            // )
                              ,)),

                      ],
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

  Widget addressToString() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              MaterialIcons.location_on,
              color: Colors.deepOrangeAccent,
              size: Constant.TEXT_FONT + 10,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                  globalAddressString,
                  style: TextStyle(
                    color: Pallete.itemDescColor,
                    fontSize: Constant.TEXT_FONT - 1,
                    fontWeight: FontWeight.w100,
                    fontFamily: Constant.ROBOTO_REGULAR,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fillAddressData() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Constant.PADDING_VIEW, 8.0, Constant.PADDING_VIEW, 15),
      child: Container(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 100,
                  // style: TextStyle(fontSize: 15, color: Pallete.textColor),
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: Constant.HINT_HOUSE_EXAMPLE,
                      hintStyle: TextStyle(
                          height: 1,
                          fontSize: Constant.TEXT_FONT,
                          fontFamily: Constant.ROBOTO_REGULAR),
                      alignLabelWithHint: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto,
                      labelText: Constant.HINT_HOUSENAME,
                      labelStyle: TextStyle(
                          height: 1,
                          color: Colors.black54,
                          fontSize: Constant.TEXT_FONT)),
                  validator: (value) {
                    print('HOSUECONTROLLER' + value);
                    if (value.isEmpty) {
                      return Constant.EMPTY_DATE;
                    }
                    return null;
                  },
                  controller: houseNoController..text = tempHouseNo,
                  cursorColor: Pallete.textColor,
                  // keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  maxLength: 100,
                  style:
                  TextStyle(fontSize: 18, color: Pallete.textColor),
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: Constant.HINT_LANDMARK_EXAMPLE,
                      hintStyle: TextStyle(
                          fontSize: Constant.TEXT_FONT,
                          fontFamily: Constant.ROBOTO_REGULAR),
                      alignLabelWithHint: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.auto,
                      labelText: Constant.HINT_LANDMARK,
                      labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: Constant.TEXT_FONT)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return Constant.EMPTY_DATE;
                    }
                    return null;
                  },
                  controller: landmarkController..text = tempLandmark,
                  cursorColor: Pallete.textColor,
                  // keyboardType: TextInputType.phone,
                ),
              ],)
        ),
      ),
    );
  }

  changeTapPosition(lat, long) {
    changePositioninMap(LatLng(lat, long), "other");
  }

  _showMaterialDialog2(title, content) {
    showDialog(
        context: context,
        builder: (_) =>
        new AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // await Geolocator.openAppSettings();
                  await Geolocator.openLocationSettings();
                  print('Hi');
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
  //validator function for input fields
  void validate(store){
    if(_formKey.currentState.validate())
    {
      saveHNLtoAddress(houseNoController.text, landmarkController.text, store);
    }
  }
}