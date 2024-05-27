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
  LatLng? _currentP;

  // University markers
  static const LatLng _pCityUHongKong = LatLng(22.3375, 114.1739);
  static const LatLng _pLosAndes = LatLng(4.6018, -74.0663);
  static const LatLng _pUniversidadDePorto = LatLng(41.1783, -8.5981);
  static const LatLng _pMelbourne = LatLng(-37.7963, 144.9614);
  static const LatLng _pUniversidadJaveriana = LatLng(4.6385, -74.0821);
  static const LatLng _pOxford = LatLng(51.754816, -1.254367);
  static const LatLng _pStanford = LatLng(37.4275, -122.1697);
  static const LatLng _pCambridge = LatLng(52.2044, 0.1218);
  static const LatLng _pMIT = LatLng(42.3601, -71.0942);
  static const LatLng _pHarvard = LatLng(42.3770, -71.1167);
  static const LatLng _pYale = LatLng(41.3163, -72.9223);
  static const LatLng _pPrinceton = LatLng(40.3430, -74.6514);
  static const LatLng _pCaltech = LatLng(34.1377, -118.1253);
  static const LatLng _pColumbia = LatLng(40.8075, -73.9626);
  static const LatLng _pUChicago = LatLng(41.7886, -87.5987);
  static const LatLng _pImperial = LatLng(51.4988, -0.1749);
  static const LatLng _pETHZurich = LatLng(47.3769, 8.5417);
  static const LatLng _pUTokyo = LatLng(35.7126, 139.7620);
  static const LatLng _pTSinghua = LatLng(40.0076, 116.3264);
  static const LatLng _pNUSingapore = LatLng(1.2966, 103.7764);
  static const LatLng _pUCBerkeley = LatLng(37.8719, -122.2585);
  static const LatLng _pUPenn = LatLng(39.9522, -75.1932);
  static const LatLng _pLSE = LatLng(51.5145, -0.1164);
  static const LatLng _pMcGill = LatLng(45.5048, -73.5772);
  static const LatLng _pANU = LatLng(-35.2777, 149.1185);
  static const LatLng _pSydney = LatLng(-33.8888, 151.1872);

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
                Marker(markerId: const MarkerId('_PLosAndes'), position: _pLosAndes),
                Marker(markerId: const MarkerId('_pUniversidadDePorto'), position: _pUniversidadDePorto),
                Marker(markerId: const MarkerId('_pMelbourne'), position: _pMelbourne),
                Marker(markerId: const MarkerId('_pUniversidadJaveriana'), position: _pUniversidadJaveriana),
                Marker(markerId: const MarkerId('_pOxford'), position: _pOxford),
                Marker(markerId: const MarkerId('_pStanford'), position: _pStanford),
                Marker(markerId: const MarkerId('_pCambridge'), position: _pCambridge),
                Marker(markerId: const MarkerId('_pMIT'), position: _pMIT),
                Marker(markerId: const MarkerId('_pHarvard'), position: _pHarvard),
                Marker(markerId: const MarkerId('_pYale'), position: _pYale),
                Marker(markerId: const MarkerId('_pPrinceton'), position: _pPrinceton),
                Marker(markerId: const MarkerId('_pCaltech'), position: _pCaltech),
                Marker(markerId: const MarkerId('_pColumbia'), position: _pColumbia),
                Marker(markerId: const MarkerId('_pUChicago'), position: _pUChicago),
                Marker(markerId: const MarkerId('_pImperial'), position: _pImperial),
                Marker(markerId: const MarkerId('_pETHZurich'), position: _pETHZurich),
                Marker(markerId: const MarkerId('_pUTokyo'), position: _pUTokyo),
                Marker(markerId: const MarkerId('_pTSinghua'), position: _pTSinghua),
                Marker(markerId: const MarkerId('_pNUSingapore'), position: _pNUSingapore),
                Marker(markerId: const MarkerId('_pUCBerkeley'), position: _pUCBerkeley),
                Marker(markerId: const MarkerId('_pUPenn'), position: _pUPenn),
                Marker(markerId: const MarkerId('_pLSE'), position: _pLSE),
                Marker(markerId: const MarkerId('_pMcGill'), position: _pMcGill),
                Marker(markerId: const MarkerId('_pANU'), position: _pANU),
                Marker(markerId: const MarkerId('_pSydney'), position: _pSydney),
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
      }
    });
  }
}