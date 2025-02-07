import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:v1/helper/Constanat.dart'; // مكتبة geocoding لتحويل الأسماء إلى إحداثيات

class MapPage extends StatefulWidget {
  final String? pickupLocationUrl; // رابط موقع الاستلام
  final String? deliveryLocationUrl; // رابط موقع التسليم

  const MapPage({
    super.key,
    this.pickupLocationUrl,
    this.deliveryLocationUrl,
  });

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  late Position _currentPosition;
  LatLng _currentLocation = LatLng(30.0444, 31.2357); // الموقع الافتراضي
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];

  final String googleApiKey = googleMap_key; // ضع هنا مفتاح API الخاص بك

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // الحصول على الموقع الحالي
  }

  // دالة لاستخراج الإحداثيات من الرابط
  LatLng _extractLatLngFromUrl(String url) {
    final uri = Uri.parse(url);
    final queryParams = uri.queryParameters;
    final lat = double.parse(queryParams['mlat']!);
    final lng = double.parse(queryParams['mlon']!);
    return LatLng(lat, lng);
  }

  // الحصول على الموقع الحالي
  Future<void> _getCurrentLocation() async {
    try {
      // التحقق من الأذونات أولًا
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Permission denied. Cannot access location.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission denied forever. Cannot access location.");
        return;
      }

      // الحصول على الموقع إذا كانت الأذونات مُعطاة
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _currentPosition = position;
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      _moveCameraToCurrentLocation();
      _addMarkers();
      _getDirections(); // الحصول على الاتجاهات بين المواقع
    } catch (e) {
      print("Error in getting current location: $e");
    }
  }

  // رسم المسار بين المواقع
  Future<void> _getDirections() async {
    try {
      // استخراج إحداثيات موقع الاستلام والتسليم من الروابط
      final LatLng pickupLocation =
          _extractLatLngFromUrl(widget.pickupLocationUrl!);
      final LatLng deliveryLocation =
          _extractLatLngFromUrl(widget.deliveryLocationUrl!);

      // المسار من الموقع الحالي إلى موقع الاستلام
      final String urlToPickup =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation.latitude},${_currentLocation.longitude}&destination=${pickupLocation.latitude},${pickupLocation.longitude}&key=$googleApiKey';

      final responseToPickup = await http.get(Uri.parse(urlToPickup));

      if (responseToPickup.statusCode == 200) {
        final dataToPickup = json.decode(responseToPickup.body);
        final routesToPickup = dataToPickup['routes'];

        if (routesToPickup.isNotEmpty) {
          final polylinePointsToPickup =
              routesToPickup[0]['overview_polyline']['points'];
          _polylineCoordinates = _decodePolyline(polylinePointsToPickup);
          _addPolyline(Colors.blue); // لون المسار إلى موقع الاستلام
        } else {
          print('No routes found to pickup location');
        }
      } else {
        print('Failed to load directions to pickup location');
      }

      // المسار من موقع الاستلام إلى موقع التسليم
      final String urlToDelivery =
          'https://maps.googleapis.com/maps/api/directions/json?origin=${pickupLocation.latitude},${pickupLocation.longitude}&destination=${deliveryLocation.latitude},${deliveryLocation.longitude}&key=$googleApiKey';

      final responseToDelivery = await http.get(Uri.parse(urlToDelivery));

      if (responseToDelivery.statusCode == 200) {
        final dataToDelivery = json.decode(responseToDelivery.body);
        final routesToDelivery = dataToDelivery['routes'];

        if (routesToDelivery.isNotEmpty) {
          final polylinePointsToDelivery =
              routesToDelivery[0]['overview_polyline']['points'];
          _polylineCoordinates = _decodePolyline(polylinePointsToDelivery);
          _addPolyline(Colors.red); // لون المسار إلى موقع التسليم
        } else {
          print('No routes found to delivery location');
        }
      } else {
        print('Failed to load directions to delivery location');
      }
    } catch (e) {
      print("Error in getting directions: $e");
    }
  }

  // تحويل النقاط من API إلى إحداثيات
  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0;
    int len = polyline.length;
    int c = 0;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int shift = 0;
      int result = 0;
      do {
        c = polyline.codeUnitAt(index) - 63;
        result |= (c & 0x1f) << shift;
        shift += 5;
        index++;
      } while (c >= 0x20);

      int deltaLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += deltaLat;

      shift = 0;
      result = 0;
      do {
        c = polyline.codeUnitAt(index) - 63;
        result |= (c & 0x1f) << shift;
        shift += 5;
        index++;
      } while (c >= 0x20);

      int deltaLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += deltaLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  // إضافة الخطوط على الخريطة
  void _addPolyline(Color color) {
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId("route_${_polylines.length}"),
        points: _polylineCoordinates,
        width: 5,
        color: color,
        geodesic: true,
      ));
    });
  }

  // تحريك الكاميرا إلى الموقع الحالي
  void _moveCameraToCurrentLocation() {
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_currentLocation, 13.5),
    );
  }

  // إضافة العلامات
  void _addMarkers() {
    final LatLng pickupLocation =
        _extractLatLngFromUrl(widget.pickupLocationUrl!);
    final LatLng deliveryLocation =
        _extractLatLngFromUrl(widget.deliveryLocationUrl!);

    _markers.add(
      Marker(
        markerId: MarkerId('current'),
        position: _currentLocation,
        infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: 'موقعك الحالي'), // نص يظهر مع العلامة
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('pickup'),
        position: pickupLocation,
        infoWindow: InfoWindow(
            title: 'Pickup Location',
            snippet: 'موقع الاستلام'), // نص يظهر مع العلامة
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('delivery'),
        position: deliveryLocation,
        infoWindow: InfoWindow(
            title: 'Delivery Location',
            snippet: 'موقع التسليم'), // نص يظهر مع العلامة
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        centerTitle: true,
        backgroundColor: primary,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true, // تمكين عرض الموقع الحالي
        myLocationButtonEnabled: true, // تمكين زر الموقع الحالي
      ),
    );
  }
}
