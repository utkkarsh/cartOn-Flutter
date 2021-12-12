import 'package:CartOn/pages/locationService/AddressBottomSheet.dart';
import 'package:CartOn/pages/locationService/LocationBottomSheet.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';


Future<Position> determinePositioninLatLong() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return Future.error(
          'Location permissions are denied (actual value: $permission).');
    }
  }

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}


Future determinePlacemark() async {
  Position position = await determinePositioninLatLong();
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: 'en');
  // List<Placemark> placemarks = await placemarkFromCoordinates(27.1929869067, 77.9651239514);

  return placemarks  ;
}

Future determinePlacemarkfromLatLong(LatLng position) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: 'en');
  return placemarks  ;
}

Future determineCoordinates(location) async {
  // var location = "20 , Avas Vikas Colony, Sec 3, Bodla, Agra, Uttar Pradesh 282007";
  List<Location> locations = await locationFromAddress(location);
  print(locations);
  return locations;
}

Future getLastLocation() async {
  Position position = await Geolocator.getLastKnownPosition();
  print(position) ;
}

Future getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition();
  print(position) ;
}

getShopDistance(LatLng shopcoordinates, LatLng currentLocation) {

  String distanceString = "1 Km";
  print(shopcoordinates.latitude);
  print(currentLocation.latitude);
  double distanceInMeters = Geolocator.distanceBetween(shopcoordinates.latitude, shopcoordinates.longitude, currentLocation.latitude,currentLocation.longitude);

  if(distanceInMeters>1000.00)
    {
      var distance = distanceInMeters/1000.00;
      distanceString = distance.round().toString() + ' Km';
    }
  else
    {
      distanceString = distanceInMeters.round().toString() + ' Km';
    }

  return distanceString;
  // return distanceInMeters> 1000.00 ? (distanceInMeters/1000.00).round().toString() + ' Km':  (distanceInMeters).toInt().toString() + ' m';
}