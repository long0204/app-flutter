import 'dart:js';

import 'package:appbooking/Bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => MapBloc(),
        child: MapScreen(),
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Example'),
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is InitialMapState) {
            return _buildInitialMap();
          } else if (state is MapLoading) {
            return _buildLoadingMap();
          } else if (state is MapLoaded) {
            return _buildLoadedMap(state.markers, state.polyline);
          } else if (state is MapError) {
            return _buildErrorMap(state.error);
          } else {
            return Container(); // Handle other states if needed
          }
        },
      ),
    );
  }

  Widget _buildInitialMap() {
    return Center(
      child: Text('Type an address and press search to see the map'),
    );
  }

  Widget _buildLoadingMap() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedMap(Set<Marker> markers, Polyline? polyline) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter a location',
                  ),
                  onSubmitted: (value) {
                    context.read<MapBloc>().add(SearchButtonPressed(value));
                    
                  },
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => context.read<MapBloc>().add(SearchButtonPressed('')),
                child: Text('Search'),
              ),
            ],
          ),
        ),
        Expanded(
          child: GoogleMap(
            onMapCreated: (controller) {},
            initialCameraPosition: CameraPosition(
              target: LatLng(21.005407899999998, 105.8113602),
              zoom: 12,
            ),
            markers: markers,
            polylines: polyline != null ? {polyline} : {},
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMap(String error) {
    return Center(
      child: Text('Error: $error'),
    );
  }
}
