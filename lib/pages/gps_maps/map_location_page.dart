import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intern_flutter_challenge/widgets/my_appbar.dart';

class MapLocationPage extends StatefulWidget {
  const MapLocationPage({super.key});

  @override
  State<MapLocationPage> createState() => _MapLocationPageState();
}

class _MapLocationPageState extends State<MapLocationPage> {
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  static double lat = lat;
  static double long = long;
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGPS();
    addCustomMarkerIcon();
    addCustomUserIcon();
    super.initState();
  }

  checkGPS() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint('Location permissions are permanently denied');
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude;
    lat = position.latitude;

    setState(() {
      //refresh UI
    });
  }

  MapType _currentMapType = MapType.normal;
  void _changeMapType() {
    setState(() {
      _currentMapType =
          _currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }

  Future<void> _goToMyLocation() async {
    final myPosition = LatLng(lat, long);
    mapController.animateCamera(CameraUpdate.newLatLngZoom(myPosition, 18));
    setState(() {
      Marker(
        markerId: const MarkerId("My Location"),
        position: myPosition,
      );
    });
  }

  late GoogleMapController mapController;
  final Map<String, Marker> _markers = {};

  BitmapDescriptor customMarkerIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor userMarkerIcon = BitmapDescriptor.defaultMarker;

  void addCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/custom_marker.png")
        .then(
      (icon) {
        setState(() {
          customMarkerIcon = icon;
        });
      },
    );
  }

  void addCustomUserIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/custom_user_marker.png")
        .then(
      (icon) {
        setState(() {
          userMarkerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    LatLng synapsisLocation = const LatLng(-6.2636134, 106.8756337);
    LatLng currentLocation = LatLng(lat, long);

    return Scaffold(
      appBar: const MyAppBar(appBarTitle: "Maps"),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),
        mapType: _currentMapType,
        onMapCreated: (controller) {
          mapController = controller;
          addMarker(
            "userLocation",
            currentLocation,
            userMarkerIcon,
            "My Location",
            "$lat, $long",
          );
          addMarker(
            "synapsis.Id",
            synapsisLocation,
            customMarkerIcon,
            "Synapsis Sinergi Digital",
            "A Start-Up Company that working on system prototyping especially Internet of Things, Electronics Devices, and Monitoring Systems.",
          );
        },
        markers: _markers.values.toSet(),
        zoomControlsEnabled: false,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _changeMapType,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.map,
                size: 30,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: _goToMyLocation,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.my_location,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  addMarker(String id, LatLng location, BitmapDescriptor customIcon,
      String title, String? description) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      icon: customIcon,
      infoWindow: InfoWindow(
        title: title,
        snippet: description,
      ),
    );

    _markers[id] = marker;
    setState(() {});
  }
}
