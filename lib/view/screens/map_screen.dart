import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/constants/appTheme.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error fetching current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          TextButton(
            onPressed: (){
              if (selectedLocation != null) {
                Navigator.pop(context, selectedLocation);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please wait while fetching your location.'),
                  ),
                );
              }
          }, child: const Text("Ok" ,
        style: TextStyle(
          color: Colors.white
        )
          )),
        ],
      ),
      body: selectedLocation != null
          ? GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: selectedLocation!,
          zoom: 20.0,
        ),
        onTap: (LatLng location) {
          setState(() {
            selectedLocation = location;
          });
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
