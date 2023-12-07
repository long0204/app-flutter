import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  TextEditingController startAddressController = TextEditingController();
  TextEditingController destinationAddressController = TextEditingController();
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Map Example'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: startAddressController,
                    decoration: InputDecoration(
                      labelText: 'Điểm bắt đầu',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: destinationAddressController,
                    decoration: InputDecoration(
                      labelText: 'Điểm kết thúc',
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // Default: San Francisco
                zoom: 12,
              ),
              markers: markers,
              polylines: polylines,
            ),
          ),
          ElevatedButton(
            onPressed: () => _onButtonPress(),
            child: Text('Tìm đường'),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!mounted) return; // Check if the widget is still in the tree
    setState(() {
      mapController = controller;
    });
  }

  void _onButtonPress() async {
    String startAddress = startAddressController.text;
    String destinationAddress = destinationAddressController.text;

    List<Location> startLocations = await locationFromAddress(startAddress);
    List<Location> destinationLocations =
        await locationFromAddress(destinationAddress);

    LatLng startLatLng =
        LatLng(startLocations[0].latitude, startLocations[0].longitude);
    LatLng destinationLatLng = LatLng(
        destinationLocations[0].latitude, destinationLocations[0].longitude);
    print("2 Điểm ${startLatLng} ${destinationLatLng}");
    // Clear existing markers and polylines
    markers.clear();
    polylines.clear();
    polylineCoordinates.clear();

    // Add markers for start and destination
    markers.add(Marker(
      markerId: MarkerId('start'),
      position: startLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: InfoWindow(
        title: 'Start',
        snippet: startAddress,
      ),
    ));

    markers.add(Marker(
      markerId: MarkerId('destination'),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
        title: 'Destination',
        snippet: destinationAddress,
      ),
    ));

    // Get polyline coordinates
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBisRTGrVPSBHcazddG3Lh80Be-n9iNej4', // Replace with your Google Maps API key
      PointLatLng(startLatLng.latitude, startLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
    );
    print("Số điểm ${result.points}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Draw polyline on the map
    setState(() {
      Polyline polyline = Polyline(
        polylineId: PolylineId('route'),
        color: Colors.blue,
        points: polylineCoordinates,
      );
      polylines.add(polyline);
    });

    // Adjust camera position to show both markers
    double minLat = min(startLatLng.latitude, destinationLatLng.latitude);
    double maxLat = max(startLatLng.latitude, destinationLatLng.latitude);
    double minLng = min(startLatLng.longitude, destinationLatLng.longitude);
    double maxLng = max(startLatLng.longitude, destinationLatLng.longitude);

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
  }

}