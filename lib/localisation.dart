import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final LatLng _tangerCenter = const LatLng(35.7595, -5.8330);
  final LatLng _rabatPosition1 = const LatLng(34.020882, -6.841650);
  final LatLng _rabatPosition2 = const LatLng(33.971590, -6.849813);
  final Set<Marker> _markers = {};
  late Marker _trackingMarker;
  late Timer _timer;
  double _animationStep = 0.0;
  MapType _currentMapType = MapType.normal; 

  @override
  void initState() {
    super.initState();
    _onMapCreated();
    _startTrackingAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onMapCreated() {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('rabat_position_1'),
          position: _rabatPosition1,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('rabat_position_2'),
          position: _rabatPosition2,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      _trackingMarker = Marker(
        markerId: const MarkerId('tracking_marker'),
        position: _rabatPosition1,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
    });
  }

  void _startTrackingAnimation() {
    const duration = Duration(milliseconds: 800);
    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        _animationStep += 0.05;
        if (_animationStep >= 1.0) {
          _animationStep = 0.0;
        }
        _trackingMarker = _trackingMarker.copyWith(
          positionParam: LatLng(
            _rabatPosition1.latitude + (_rabatPosition2.latitude - _rabatPosition1.latitude) * _animationStep,
            _rabatPosition1.longitude + (_rabatPosition2.longitude - _rabatPosition1.longitude) * _animationStep,
          ),
        );
      });
    });
  }

  void _zoomToMarkers() {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        _rabatPosition1.latitude < _rabatPosition2.latitude
            ? _rabatPosition1.latitude
            : _rabatPosition2.latitude,
        _rabatPosition1.longitude < _rabatPosition2.longitude
            ? _rabatPosition1.longitude
            : _rabatPosition2.longitude,
      ),
      northeast: LatLng(
        _rabatPosition1.latitude > _rabatPosition2.latitude
            ? _rabatPosition1.latitude
            : _rabatPosition2.latitude,
        _rabatPosition1.longitude > _rabatPosition2.longitude
            ? _rabatPosition1.longitude
            : _rabatPosition2.longitude,
      ),
    );
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  void _changeMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.satellite  ? MapType.normal : MapType.satellite ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
              _onMapCreated();
              _zoomToMarkers();
            },
            initialCameraPosition: CameraPosition(
              target: _tangerCenter,
              zoom: 6.0,
            ),
            markers: {..._markers, _trackingMarker},
            polylines: {
              Polyline(
                polylineId: const PolylineId('rabat_trajectory'),
                color: Colors.blue,
                width: 8,
                points: [_rabatPosition1, _rabatPosition2],
                patterns: [
                  PatternItem.dash(10),
                  PatternItem.gap(5),
                ],
                startCap: Cap.roundCap,
                endCap: Cap.roundCap,
                jointType: JointType.round,
                geodesic: true,
              ),
            },
            mapType: _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal,
          ),
          Positioned(
            top: 60,
            left: 20,
            child: FloatingActionButton(
              onPressed: _changeMapType,
              child: const Icon(Icons.map),
            ),
          ),
        ],
      ),
    );
  }
}