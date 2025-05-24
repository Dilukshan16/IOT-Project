// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Maps Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MapScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   LatLng? _currentPosition;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       final status = await Geolocator.checkPermission();
//       if (status == LocationPermission.denied) {
//         final requestedStatus = await Geolocator.requestPermission();
//         if (requestedStatus != LocationPermission.whileInUse &&
//             requestedStatus != LocationPermission.always) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Location permission denied')),
//             );
//           }
//           return;
//         }
//       }

//       final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       if (!mounted) return; // Add this check

//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         _isLoading = false;
//       });

//       mapController.animateCamera(
//         CameraUpdate.newLatLngZoom(_currentPosition!, 15),
//       );
//     } catch (e) {
//       if (!mounted) return; // Add this check

//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//           _isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : GoogleMap(
//                 onMapCreated: (controller) => mapController = controller,
//                 initialCameraPosition: CameraPosition(
//                   target:
//                       _currentPosition ??
//                       const LatLng(6.90628891406983, 79.8707173647734),
//                   zoom: 15,
//                 ),
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//                 zoomControlsEnabled: false,
//               ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         child: const Icon(Icons.gps_fixed),
//       ),
//     );
//   }
// }
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Bin Locator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;

  // For bin locations
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  // For directions
  LatLng? _selectedBinLocation;
  bool _showDirections = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _clearDirections() {
    setState(() {
      _polylines.clear();
      polylineCoordinates.clear();
      _showDirections = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final status = await Geolocator.checkPermission();
      if (status == LocationPermission.denied) {
        final requestedStatus = await Geolocator.requestPermission();
        if (requestedStatus != LocationPermission.whileInUse &&
            requestedStatus != LocationPermission.always) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permission denied')),
            );
          }
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      if (!mounted) return;

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 15),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void _addBinLocation(LatLng position) {
    final markerId = MarkerId('bin_${_markers.length}');

    setState(() {
      _markers.add(
        Marker(
          markerId: markerId,
          position: position,
          infoWindow: const InfoWindow(title: 'Waste Bin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        ),
      );
      _selectedBinLocation = position;
    });
  }

  Future<void> _getDirections() async {
    if (_currentPosition == null || _selectedBinLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Current location or bin location not available'),
        ),
      );
      return;
    }
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBXbIKcFU02XxLoMMpbciJtK06Litvbp5o', // Replace with your actual API key
        PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        PointLatLng(
          _selectedBinLocation!.latitude,
          _selectedBinLocation!.longitude,
        ),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates.clear();
          _polylines.clear();

          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }

          _polylines.add(
            Polyline(
              polylineId: const PolylineId('directions'),
              points: polylineCoordinates,
              color: Colors.blue,
              width: 5,
            ),
          );

          _showDirections = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Directions error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) => mapController = controller,
                    initialCameraPosition: CameraPosition(
                      target:
                          _currentPosition ??
                          const LatLng(6.90628891406983, 79.8707173647734),
                      zoom: 15,
                    ),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                    markers: _markers,
                    polylines: _polylines,
                    onLongPress: (LatLng position) {
                      _addBinLocation(position);
                    },
                  ),
                  if (_showDirections)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: _clearDirections,
                        mini: true,
                        child: const Icon(Icons.clear),
                      ),
                    ),
                ],
              ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getCurrentLocation,
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(height: 10),
          if (_selectedBinLocation != null)
            FloatingActionButton(
              onPressed: _getDirections,
              child: const Icon(Icons.directions),
            ),
        ],
      ),
    );
  }
}
