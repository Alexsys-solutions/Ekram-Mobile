// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';


// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLocationPermission();
//   }

//   Future<void> _checkLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//         openAppSettings();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Localisation'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//             if (!serviceEnabled) {
//               Geolocator.openLocationSettings();
//             } else {
//               Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//               print('Position: ${position.latitude}, ${position.longitude}');
//             }
//           },
//           child: Text('Obtenir la localisation'),
//         ),
//       ),
//     );
//   }
// }





    