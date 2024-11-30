import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocode/geocode.dart';
//
// THIS PART OF THE CODE CORRESPONDS TO THE PART
// RELATED WITH THE GEOCODER DEPENDENCY
//

LocationSettings checkPlatform() {
  late LocationSettings locationSettings;
  if (defaultTargetPlatform == TargetPlatform.android){
  locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 10),
      //(Optional) Set foreground notification config to keep the app alive 
      //when going to the background
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText:
        "Example app will continue to receive your location even when you aren't using it",
        notificationTitle: "Running in Background",
        enableWakeLock: true,
      )
  );
  return locationSettings;
} else {
    return const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
  }
}

Future<Position> determinePosition(LocationSettings locSet) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }
    
    return Geolocator.getCurrentPosition(locationSettings: locSet);
}

//
// THIS PART OF THE CODE CORRESPONDS TO THE PART
// RELATED WITH THE GEOCODE DEPENDENCY
//

Future<Coordinates> coordsFinder(String address) async{
  GeoCode geoCode = GeoCode();

  Coordinates coordinates = await geoCode.forwardGeocoding(
    address: address
  );
  return coordinates;
}

Future<String> addressFinder(double lat, double long) async{
  GeoCode geoCode = GeoCode();
  
  try {
    Address address = await geoCode.reverseGeocoding(latitude: lat, longitude: long);
    return "${address.streetAddress}-${address.streetNumber}, ${address.city}, ${address.region}";
  } catch (e) {
    return "Error: $e";
  }
}

//
// THIS PART OF THE CODE CORRESPONDS TO THE MATH PART
// CALC. OF DISTANCE BETWEEN TWO POINTS
//

double distanceCalc(double latA, double lonA, double latB, double lonB) {
  double result = Geolocator.distanceBetween(latA, lonA, latB, lonB);
  result = result/1000;
  result = double.parse(result.toStringAsFixed(2));
  return result;
}