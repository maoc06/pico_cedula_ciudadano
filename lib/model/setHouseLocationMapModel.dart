import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:pico_cedula/view/loginCiudadanoView.dart';

class SetHouseLocationModel {

  static var newLatitude = 0.0;
  static var newLongitude = 0.0;

  static Completer<GoogleMapController> _controller = Completer();
  static final Set<Marker> _markers = {};

  static const LatLng center = LatLng(3.4372201, -76.5224991);

  static Future<int> onAddLocation() async {
    int res = -1;
    await Firestore.instance
    .collection('usuarios')
    .document(ccNumber.text)
    .updateData(
      {
        'latitud': newLatitude,
        'longitud': newLongitude
      }
    ).then((value) {
      res = 0;
    });
    return res;
  }

  static void updatePosition(CameraPosition _position){

    Marker marker = _markers.firstWhere(
        (p) => p.markerId == MarkerId(ccNumber.text),
        orElse: () => null);

    _markers.remove(marker);
    _markers.add(
      Marker(
        markerId: MarkerId(ccNumber.text),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Mi Casa',
        ),
      )
    );
    newLatitude = _position.target.latitude;
    newLongitude = _position.target.longitude;
  }

  static get getMarkers => _markers;
  static get getCenter => center;
  static get getController => _controller;

}