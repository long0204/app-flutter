import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapWidget extends StatefulWidget {
  final String accountName;
  final String accountEmail;
  final List<Map<String, String>> hotelList;

  MapWidget({required this.accountName, required this.accountEmail, required this.hotelList});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _searchController1 = TextEditingController();
  TextEditingController _searchController2 = TextEditingController();
  Set<Marker> _markers = Set<Marker>();
  Polyline? _polyline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Map with Search'),
        toolbarHeight: 2,
      ),
      body: Stack(
        children: [
          SizedBox(height: 30.0),
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            polylines: _polyline != null ? {_polyline!} : {},
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController1,
                      decoration: InputDecoration(
                        hintText: 'Enter location 1',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchLocation(_searchController1.text, 1);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController2,
                      decoration: InputDecoration(
                        hintText: 'Enter location 2',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchLocation(_searchController2.text, 2);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

        _updateMarkers(location, markerNumber, placemark);
        _moveToLocation(location);
      } else {
        print('No location found');
      }
    } catch (e) {
      print('Error searching location: $e');
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
        ),
      );
      if (_markers.length == 2) {
        _drawPolyline();
      }
    });
    
  }

  Future<void> _moveToLocation(Location location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 14.0,
        ),
      ),
    );
  }

  void _drawPolyline() async {
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = _markers.map((marker) {
    return LatLng(marker.position.latitude, marker.position.longitude);
  }).toList();

  try {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBisRTGrVPSBHcazddG3Lh80Be-n9iNej4",
      PointLatLng(polylineCoordinates[0].latitude, polylineCoordinates[0].longitude),
      PointLatLng(polylineCoordinates[1].latitude, polylineCoordinates[1].longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        _polyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: result.points
              .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
              .toList(),
          width: 5,
        );

        // Adjust camera position to show both markers
        _adjustCameraPosition(polylineCoordinates);
      });
    }
  } catch (e) {
    print('Error drawing polyline: $e');
  }
}

void _adjustCameraPosition(List<LatLng> polylineCoordinates) async {
  double minLat = polylineCoordinates[0].latitude;
  double minLng = polylineCoordinates[0].longitude;
  double maxLat = polylineCoordinates[0].latitude;
  double maxLng = polylineCoordinates[0].longitude;

  for (LatLng point in polylineCoordinates) {
    if (point.latitude < minLat) minLat = point.latitude;
    if (point.latitude > maxLat) maxLat = point.latitude;
    if (point.longitude < minLng) minLng = point.longitude;
    if (point.longitude > maxLng) maxLng = point.longitude;
  }

  double padding = 50.0; // Adjust the padding as needed

  final GoogleMapController controller = await _controller.future;
  controller.animateCamera(
    CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      ),
      padding,
    ),
  );
}

}
