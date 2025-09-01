import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Data/Model/BinModel.dart';
import '../../../Data/Repositories/bin_repo.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? currentPosition;
  late GoogleMapController mapController;
  late Future<List<BinModel?>?> binsFuture;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    binsFuture = BinRepo().readAll();
  }

  Future<void> _getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentPosition = LatLng(pos.latitude, pos.longitude);
    });
  }

  final List<BinModel> dummyBins = [
    BinModel(id: 'A1', name: 'Bin A1', latLng: LatLng(24.8395425, 46.7212535)),
    BinModel(id: 'A2', name: 'Bin A2', latLng: LatLng(24.8395425, 46.7212535)),
    BinModel(id: 'A3', name: 'Bin A3', latLng: LatLng(24.8506894, 46.7191256)),
    BinModel(id: 'A4', name: 'Bin A4', latLng: LatLng(24.8548225, 46.7179582)),
    BinModel(id: 'A5', name: 'Bin A5', latLng: LatLng(24.8583129, 46.7174861)),
    BinModel(id: 'A6', name: 'Bin A6', latLng: LatLng(24.8605877, 46.7204717)),
    BinModel(id: 'A7', name: 'Bin A7', latLng: LatLng(24.8571379, 46.7214477)),
    BinModel(id: 'A8', name: 'Bin A8', latLng: LatLng(24.8533117, 46.7216008)),
    BinModel(id: 'A9', name: 'Bin A9', latLng: LatLng(24.8490281, 46.7227139)),
    BinModel(
      id: 'A10',
      name: 'Bin A10',
      latLng: LatLng(24.8430366, 46.7238048),
    ),
  ];

  // ✅ 2. Upload Function
  Future<void> uploadBinsToFirestore() async {
    await BinRepo().createMultible(dummyBins);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearest Bin Map")),
      body:
          currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder<List<BinModel?>?>(
                future: binsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("No bins found."));
                  }

                  final bins = snapshot.data!;

                  final markers = <Marker>{
                    Marker(
                      markerId: const MarkerId('current_location'),
                      position: currentPosition!,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      infoWindow: const InfoWindow(title: "You are here"),
                    ),
                    ...bins.map(
                      (bin) => Marker(
                        markerId: MarkerId(bin!.id),
                        position: bin.latLng,
                        infoWindow: InfoWindow(title: bin.name),
                      ),
                    ),
                  };

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: currentPosition!,
                      zoom: 15,
                    ),
                    onMapCreated: (controller) => mapController = controller,
                    markers: markers,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                  );
                },
              ),
    );
  }
}
