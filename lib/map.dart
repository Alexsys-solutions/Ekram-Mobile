import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreenn extends StatefulWidget {
  const MapScreenn({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenn> {
  late GoogleMapController mapController;
  late MapType _currentMapType;
  bool _showContainer = false; 

  // Coordonnées de Rabat, Maroc
  final LatLng _center = const LatLng(34.020882, -6.841650);

  List<Marker> markers = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.020882, -6.841650),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(34.025255, -6.826962),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('3'),
      position: LatLng(34.013250, -6.832423),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('4'),
      position: LatLng(34.016823, -6.821264),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('5'),
      position: LatLng(34.018123, -6.853019),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('6'),
      position: LatLng(34.013723, -6.832194),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),
    ),
    const Marker(
      markerId: MarkerId('7'),
      position: LatLng(34.023581, -6.846292),
      infoWindow: InfoWindow(
        title: 'Déclaration de décès',
        snippet: 'Chez le constateur',
      ),   
    ),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _animateToCenter();
  }

  void _animateToCenter() async {
    await Future.delayed(const Duration(milliseconds: 500));
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _center,
        zoom: 13.0,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _currentMapType = MapType.normal;
  }

  void _changeMapType() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.hybrid
          : _currentMapType == MapType.hybrid
              ? MapType.normal
              : MapType.satellite;
    });
  }

  // Fonction pour gérer les clics sur les marqueurs
  void _onMarkerTapped() {
    setState(() {
      // Si le container est déjà visible, le rendre invisible
      _showContainer = !_showContainer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 0,
            ),
            markers: markers
                .map((marker) => Marker(
                      markerId: marker.markerId,
                      position: marker.position,
                      onTap: _onMarkerTapped, 
                      infoWindow: marker.infoWindow,
                    ))
                .toSet(),
            mapType: _currentMapType,
          ),
      
          if (_showContainer)
           Positioned(
  bottom: 0,
  left: 5,
  right: 5,
  child: GestureDetector(
    onTap: () {
      // Fonction pour gérer le clic sur le conteneur
    },
    child: SingleChildScrollView(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0), 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blue,
              child: const Center(
                child:  Text(
                  "Premier Conteneur",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10), 
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.green,
              child: const Center(
                child: Text(
                  "Deuxième Conteneur",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),




          Positioned(
            top: 26,
            left: 15,
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                FloatingActionButton(
                  onPressed: _changeMapType,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.map, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const SizedBox(height: 10), 
                FloatingActionButton( 
                  onPressed: () {
                    // Code pour le mode à pied
                  },
                  backgroundColor: Colors.blue, 
                  child: const Icon(Icons.directions_walk), 
                ),
                const SizedBox(height: 10), 
                FloatingActionButton( 
                  onPressed: () {
                    // Code pour le mode en voiture
                  },
                  backgroundColor: Colors.green, 
                  child: const Icon(Icons.directions_car), 
                ),
                // Ajoutez d'autres boutons avec les icônes appropriées pour d'autres modes de déplacement
              ],
            ),
          ),
        ],
      ),
    );
  }
}