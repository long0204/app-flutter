import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/directions.dart' as directions;

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
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = {};
  List<LatLng> allPoints = [];
  Polyline? polyline;
  final directions.GoogleMapsDirections _directions = directions.GoogleMapsDirections(apiKey: 'AIzaSyBevJuSc3k1zsDNgrIz4jy_30NMomRgJqQ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Nhập điểm tìm kiếm',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _onSearchButtonPress(),
                  child: Text('Tìm kiếm'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(21.005407899999998, 105.8113602),
                zoom: 12,
              ),
              markers: markers,
              polylines: polyline != null ? {polyline!} : {},
            ),
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onSearchButtonPress() async {
    String searchAddress = searchController.text;

    List<Location> locations = await locationFromAddress(searchAddress);
    if (locations.isNotEmpty) {
      LatLng destination = LatLng(locations[0].latitude, locations[0].longitude);

      // Add marker for the destination
      markers.add(Marker(
        markerId: MarkerId('destination'),
        position: destination,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Destination',
          snippet: searchAddress,
        ),
      ));

      // Request directions from current location to destination
      var currentLocation = allPoints.isNotEmpty ? allPoints.last : LatLng(21.005407899999998, 105.8113602);
      var response = await _directions.directions(
      directions.Location( lat: currentLocation.latitude, lng: currentLocation.longitude),
      directions.Location(lat: destination.latitude, lng: destination.longitude),
      travelMode: directions.TravelMode.driving,
    );


      // Extract polyline coordinates from the response
      List<LatLng> polylineCoordinates = [];
      for (var route in response.routes) {
        for (var leg in route.legs) {
          for (var step in leg.steps) {
            polylineCoordinates.addAll(decodePolyline(step.polyline.points));
          }
        }
      }

      // Draw polyline on the map
      setState(() {
        polyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
        );
      });

      // Move camera to the destination
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(destination, 14),
      );
    }
  }

  List<LatLng> decodePolyline(String encoded) {
  List<LatLng> points = PolylinePoints().decodePolyline(encoded).map((point) {
    return LatLng(point.latitude, point.longitude);
  }).toList();
  return points;
}

}
