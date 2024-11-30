import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'locFunctions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LocatorTest(),
    );
  }
}

class LocatorTest extends StatefulWidget {
  const LocatorTest({super.key});
  @override
  State<LocatorTest> createState() => _LocatorTestState();
}

class _LocatorTestState extends State<LocatorTest> {
  GeoCode geoCode = GeoCode();
  Position? pos;
  String? address;
  double? distanceDiff;
  String end = "620 Rua Alfredo Stringari, Joinville, SC 89230-690";
  String testCoordVar = "Var coords value";
  String testVarsA = "Vars A Test";
  String distanceResult = "Distance Between Points";
  late String lat;
  late String long;
  late double latitudeA;
  late double longitudeA;
  late double latitudeB;
  late double longitudeB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text("Locator Test")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(testVarsA),
              const SizedBox(height: 10.0),
              ElevatedButton(onPressed: () async {
                pos = await determinePosition(checkPlatform()).then((value) {
                  latitudeA = value.latitude;
                  longitudeA = value.longitude;
                  lat = '${value.latitude}';
                  long = '${value.longitude}';
                  setState(() {
                    testVarsA = 'Latitude: $latitudeA, Longitude: $longitudeA';
                  });
                });
              }, 
                child: const Text("Get Location")
              ),
              const SizedBox(height: 30.0),
              Text(
                "Endereço: $end",
                style: const TextStyle(
                  fontSize: 20,
                )
              ),
              const SizedBox(height: 20.0),
              Text(testCoordVar),  
              ElevatedButton(onPressed: () async {
                address = await geoCode.forwardGeocoding(address: end).then((value) {
                  latitudeB = value.latitude!;
                  longitudeB = value.longitude!;
                  setState(() {
                    testCoordVar = "Lat: $latitudeB, Long: $longitudeB";
                  });
                });
              }, 
                child: const Text("Convert Address")
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Distância entre os pontos:",
                style: const TextStyle (
                  fontSize: 20,
                )
              ),
              const SizedBox(height: 20.0),
              Text(distanceResult),
              ElevatedButton(onPressed: () async {
                distanceDiff = distanceCalc(latitudeA, longitudeA, latitudeB, longitudeB);
                setState(() {
                  distanceResult = "Distance Between Points: $distanceDiff";
                });
              },
                child: const Text("Calculate Distance")
              ),
            ],
          ),
        ),
      ),
    );  
  }
}