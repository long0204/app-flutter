// import 'package:appchart/chart.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChartWidget(),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController; // Controller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> _markers = Set<Marker>();
  Completer<GoogleMapController> _controller = Completer();
  String googleAPiKey = "AIzaSyBevJuSc3k1zsDNgrIz4jy_30NMomRgJqQ";

  Set<Marker> markers = Set(); // Markers for google map
  Map<PolylineId, Polyline> polylines = {}; // Polylines to show direction

  LatLng startLocation = LatLng(27.6683619, 85.3101895);
  LatLng endLocation = LatLng(27.6688312, 85.3077329);

  TextEditingController searchController1 = TextEditingController();
  TextEditingController searchController2 = TextEditingController();

  @override
  void initState() {
    markers.add(Marker(
      markerId: MarkerId(startLocation.toString()),
      position: startLocation,
      infoWindow: InfoWindow(
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    markers.add(Marker(
      markerId: MarkerId(endLocation.toString()),
      position: endLocation,
      infoWindow: InfoWindow(
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    getDirections();

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  Future<void> searchLocation(String query, int markerNumber) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        Placemark placemark = (await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        ))[0];
        print(placemark);
        _updateMarkers(location, markerNumber, placemark);
        _moveToLocation(location);
      } else {
        print('No location found');
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }
Future<void> _moveToLocation(Location location) async {
  if (mapController != null) {
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 15.0,
        ),
      ),
    );
  } else {
    print("Map controller is null");
  }
}
  void _updateMarkers(Location location, int markerNumber, Placemark placemark) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == 'location$markerNumber');
      _markers.add(
        Marker(
          markerId: MarkerId('location$markerNumber'),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
            title: 'Location $markerNumber',
            snippet: placemark.name ?? '',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Set marker color to red
        ),
      );
    });

    _moveToLocation(location);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Direction in Google Map"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController1,
              decoration: InputDecoration(
                hintText: 'Enter starting location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchLocation(searchController1.text, 1);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController2,
              decoration: InputDecoration(
                hintText: 'Enter destination location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchLocation(searchController2.text, 2);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 16.0,
              ),
              markers: markers,
              polylines: Set<Polyline>.of(polylines.values),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}