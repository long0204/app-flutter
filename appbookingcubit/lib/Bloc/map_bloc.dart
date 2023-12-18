import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_webservice/directions.dart' as directions;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// Define events
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class SearchButtonPressed extends MapEvent {
  final String searchAddress;

  SearchButtonPressed(this.searchAddress);

  @override
  List<Object> get props => [searchAddress];
}

// Define states
abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class InitialMapState extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Set<Marker> markers;
  final Polyline polyline;

  MapLoaded({required this.markers, required this.polyline});

  @override
  List<Object> get props => [markers, polyline];
}

class MapError extends MapState {
  final String error;

  MapError(this.error);

  @override
  List<Object> get props => [error];
}

// Define the bloc
class MapBloc extends Bloc<MapEvent, MapState> {
  final directions.GoogleMapsDirections _directions = directions.GoogleMapsDirections(apiKey: 'YOUR_GOOGLE_MAPS_API_KEY');

  MapBloc() : super(InitialMapState());

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is SearchButtonPressed) {
      yield MapLoading();

      try {
        List<Location> locations = await locationFromAddress(event.searchAddress);
        if (locations.isNotEmpty) {
          LatLng destination = LatLng(locations[0].latitude, locations[0].longitude);

          // Add marker for the destination
          Set<Marker> markers = {};
          markers.add(Marker(
            markerId: MarkerId('destination'),
            position: destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: InfoWindow(
              title: 'Destination',
              snippet: event.searchAddress,
            ),
          ));

          // Request directions from the current location to the destination
          var response = await _directions.directions(
            directions.Location(lat: 21.005407899999998, lng: 105.8113602), // Replace with the current location
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

          // Return the MapLoaded state with markers and polyline
          yield MapLoaded(markers: markers, polyline: Polyline(polylineId: PolylineId('route'), color: Colors.blue, points: polylineCoordinates));
        } else {
          yield MapError('No location found for the provided address');
        }
      } catch (e) {
        yield MapError('An error occurred: $e');
      }
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = PolylinePoints().decodePolyline(encoded).map((point) {
      return LatLng(point.latitude, point.longitude);
    }).toList();
    return points;
  }
}
