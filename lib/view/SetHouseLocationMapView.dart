import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/controller/setHouseLocationMapController.dart';

import 'homePageUsersView.dart';

class SetLocationHouseMap extends StatefulWidget {

  SetLocationHouseMap({Key key}): super(key: key);

  final _SetHouseLocationMap state = _SetHouseLocationMap();

  SetHouseLocationMapController get controller => state.controller;

  @override
  _SetHouseLocationMap createState() => state;
}

class _SetHouseLocationMap extends StateMVC<SetLocationHouseMap> {

  _SetHouseLocationMap(): super(SetHouseLocationMapController()){
    _con = controller;
  }
  SetHouseLocationMapController _con;

  void _onMapCreated(GoogleMapController controller) {
    _con.getGoogleMapControlle().complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('¿Dónde esta tú casa?'),
        backgroundColor: Colors.pink[400],
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          markers: _con.getMarkers(),
          onCameraMove: ((_position)=> setState(() { _con.updatePosition(_position); })),
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _con.getCenter(),
            zoom: 11.0,
          ),
        ),
        Container(
          margin: EdgeInsets.all(16.0),
          alignment: Alignment.topRight,
          child: Column(
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                onPressed: () async {
                  _con.onAddLocation().then((onValue) {
                    if(onValue == 0) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageUsers()));
                    }
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: Colors.pink[400],
                child: const Icon(Icons.check, size: 36.0),
              ),
            ],
          ),
        )        
      ]),
    ));
  }
}