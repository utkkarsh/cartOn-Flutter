import 'package:CartOn/models/MyStore.dart';
import 'package:CartOn/pages/locationService/AddressBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:CartOn/pages/locationService/getLiveLocation.dart';
import 'package:CartOn/util/Constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ionicons/ionicons.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:avatar_glow/avatar_glow.dart';
// import 'package:animating_location_pin/animating_location_pin.dart';
import 'package:CartOn/models/sharedPreference.dart';


class ModifyAddress extends StatefulWidget {
  @override
  _ModifyAddressState createState() => _ModifyAddressState();
}

class _ModifyAddressState extends State<ModifyAddress> with WidgetsBindingObserver {
  var latitude = 26.2208217;
  var longitude =  78.2077667;
  var addressString = "";
  MapController _mapctl = MapController();
  List<Placemark> addrss;

  changePositioninMap(position) async {
    setState(() {
      // latitude = 27.199729;
      // longitude = 77.950963 ;
      latitude = position.latitude;
      longitude = position.longitude;
    });
    _mapctl.move(latLng.LatLng(position.latitude,position.longitude),19);

  }

  extractAddress(Placemark address)
  {
    return 0;
  }

  changeMaptoCurrentLocation () async{
    print('MAP : Changing Map to Current Location');
    //check if map services are on if not request user to turn on the services.
    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    print('Location service : enabled = '+ isLocationServiceEnabled.toString());
    //Determine user's current location.
    //Point map to current location.
    if (isLocationServiceEnabled)
    {
      Position position = await determinePositioninLatLong();
      addrss = await determinePlacemarkfromLatLong(LatLng(position.latitude,position.longitude));
      print(position.latitude.toString() +' , '+ position.longitude.toString());
      extractAddress(addrss[0]);
      // print(addrss[((addrss.length+1)~/2).toInt()]);
      // print(addrss);
      changePositioninMap(position);}
    else
    {
      return _showMaterialDialog2(Constant.DEVICE_LOCATION_OFF, "Please turn on device location to get accurate address and hasle free delivery.");
    }
  }

  getSavedCoordinates() async {
    //Get customer saved location
    var data = await getCustomerLocation();
    if(data!=null)
    {
      //Get customer saved address
      var address = await getCustomerAddress();
      if(address!=null)
      {
        var addressString = await getCustomerAddressInString();
      }
      else
      {
        // Position position = await Geolocator.getLastKnownPosition();
        // addrss = await determinePlacemarkfromLatLong(LatLng(double.parse(data[0]),double.parse(data[1])));
        // print(addrss[0]);
        changeMaptoCurrentLocation();

      }
      print(addressString);
      changePositioninMap(LatLng(double.parse(data[0]),double.parse(data[1])));
    }
    else
    {
      changeMaptoCurrentLocation();
    }

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('MAP : paused');
    }
    if (state == AppLifecycleState.resumed) {
      print('MAP : resumed');
      changeMaptoCurrentLocation();
      // checkLocation();
    }
  }
  @override
  void initState() {
    super.initState();
    getSavedCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<MyStore>(context);
    print(latitude.toString() +' , '+ longitude.toString());
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
                onTap: (point) async => changeTapPosition(point.latitude,point.longitude),
                onLongPress: (point) async => changeTapPosition(point.latitude,point.longitude),
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
                        SvgPicture.asset('${Constant.PATH_IMAGE}/svg/location.svg',
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
                    onPressed: () async{
                      changeMaptoCurrentLocation();
                    },
                    child: Icon(Ionicons.locate_outline,color: Colors.black45,),
                    backgroundColor: Colors.white,
                    focusColor: Colors.white70,
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
                        ),

                        FlatButton(
                            onPressed: ()=> {
                              store.updateLocation(LatLng(latitude,longitude))
                            },
                            child: Text('Save')),
                        // ListTile(
                        //   title: Row(
                        //     children: <Widget>[
                        //       Expanded(child: FlatButton(onPressed: () {},child: Text("Edit"),color: Colors.black,textColor: Colors.white,)),
                        //       Expanded(child: FlatButton(onPressed: () {},child: Text("Save"),color: Colors.black,textColor: Colors.white,)),
                        //     ],
                        //   ),
                        // )

                      ],
                    ),
                  ),]
            ),
          ),

        ],
      ),
    );
  }

  changeTapPosition(lat,long) {
    changePositioninMap(LatLng(lat, long));
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
                  // await Geolocator.openAppSettings();
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
  _showAddressBottomSheet(newAddress) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) => AddressBottomSheet(address: newAddress,),
      isScrollControlled: true,
    );
  }
}

//
// new FlutterMap(
// options: new MapOptions(
//   center: new latLng.LatLng(27.175002, 78.0421170902921), minZoom: 17.0),
// layers: [
//   new TileLayerOptions(
//       urlTemplate: "https://api.mapbox.com/styles/v1/utkkarsh/ckj0bfnx08i5419qkaebti6op/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidXRra2Fyc2giLCJhIjoiY2tqMDlta25mNGt3djMycWptMmRqbGF6dyJ9.njVJdqXf6DCDYYpm97_a2w",
//       additionalOptions:{
//         'accessToken': 'pk.eyJ1IjoidXRra2Fyc2giLCJhIjoiY2tqMGJkdndpNDZzYzJ3cDN4MnpiZ245aSJ9.HgmENbCbKofKpO1__Ftvag',
//         'id': 'mapbox.mapbox-streets-v7'
//       }
//   ),
// new MarkerLayerOptions(
//   markers: [
//     new Marker(
//       width: 80.0,
//       height: 80.0,
//       point: latLng.LatLng(51.5, -0.09),
//       builder: (ctx) =>
//       new Container(
//         child: new FlutterLogo(),
//       ),
//     ),
//   ],
// ),
//     ],
//   );
