import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Location _locationController = Location();
  final Completer<GoogleMapController> _mapController = Completer();
  static const LatLng _pCityUHongKong = LatLng(22.3375, 114.1739);
  static const LatLng _PLosAndes = const LatLng(4.6018, -74.0663);
  static const LatLng _pUniversidadDePorto= const LatLng(41.1783, -8.5981);
  static const LatLng _pMelbourne = const LatLng(-37.7963, 144.9614);
  static const LatLng _pUniversidadJaveriana = const LatLng(4.6385, -74.0821);

  LatLng? _currentP;

  @override
  void initState() {
    super.initState();
    getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? const Center(child: Text("Loading location..."))
          : GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(target: _currentP!, zoom: 13),
        mapType: MapType.normal,
        liteModeEnabled: false,
        markers: {
          Marker(markerId: const MarkerId('_cityUHongKong'), position: _pCityUHongKong),
          Marker(markerId: const MarkerId('_PLosAndes'), position: _PLosAndes),
          Marker(markerId: const MarkerId('_pUniversidadDePorto'), position: _pUniversidadDePorto),
          Marker(markerId: const MarkerId('_pMelbourne'), position: _pMelbourne),
          Marker(markerId: const MarkerId('_pUniversidadJaveriana'), position: _pUniversidadJaveriana),
          if (_currentP != null) Marker(markerId: const MarkerId('_currentP'), position: _currentP!),
        },
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _cameraToPosition(_currentP!);
      }
    });
  }

  Future<void> _cameraToPosition(LatLng target) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition newCameraPosition = CameraPosition(target: target, zoom: 14);
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }
}
