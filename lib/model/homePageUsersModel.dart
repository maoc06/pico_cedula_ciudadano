
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pico_cedula/bloc_settings.dart';
import 'package:pico_cedula/view/loginCiudadanoView.dart';

class HomePageUserModel extends BloCSetting{

  static bool isOutHouse = false;
  static bool isSectorHot = false;

  static var oldCantidad;
  static var alredyCount = false;

  // static var tmpCCNumber = ccNumber.text;

  updateLocation(state) async {

    var userOriginLatitude = 0.0;
    var userOriginLongitude = 0.0;

    Future<DocumentSnapshot> ccUser = 
    Firestore.instance.
    collection('usuarios').
    document(ccNumber.text).
    get();

    await ccUser.then((DocumentSnapshot userCoordinates) => {
      if(userCoordinates.exists) {
        userOriginLatitude = userCoordinates['latitud'],
        userOriginLongitude = userCoordinates['longitud']
      }
    });

    print("Origin Location: $userOriginLatitude , $userOriginLongitude");

    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, timeInterval: 1000);

    geolocator
    .getPositionStream(locationOptions)
    .listen((Position position) async {

      double distanceInMeters = await Geolocator()
          .distanceBetween(userOriginLatitude, userOriginLongitude, position.latitude, position.longitude);

      print("Actual Location: ${position.latitude} , ${position.longitude}");

      print('Distancia Between Origin to Actual: ' + distanceInMeters.toString());

      List<Placemark> placemark = 
      await geolocator.
      placemarkFromCoordinates(userOriginLatitude, userOriginLongitude);

      Placemark address = placemark[0];

      getNumContagiadosSector(address.postalCode);
      print("POSTAL CODE: ${address.postalCode}");

      rebuildWidgets (
        setStates: () {
          if (distanceInMeters > 250) {
            print('PELIGRO!');
            isOutHouse = true;
            updateState(true);
            if(!alredyCount)setNewInfractor(address.postalCode);
            alredyCount = true;
          } else {
            print('TODO ESTA BIEN');
            isOutHouse = false;
            updateState(false);        
            alredyCount = false;
          }
        },
        states: [state],
      );

    });
  }

  static String getLastDigitCC() {
    return ccNumber.text.substring(ccNumber.text.length-1);
  }

  static String getDay() {
    String lastDigit = getLastDigitCC();
    String day = '';
    if(lastDigit == '1' || lastDigit == '2') {
      day = 'Lunes';
    } 
    else if(lastDigit == '3' || lastDigit == '4') {
      day = 'Martes';
    }
    else if(lastDigit == '5' || lastDigit == '6') {
      day = 'Miércoles';
    }
    else if(lastDigit == '7' || lastDigit == '8') {
      day = 'Jueves';
    }
    else if(lastDigit == '9' || lastDigit == '0') {
      day = 'Viernes';
    }
    if(int.parse(lastDigit)%2 == 0) {
      day += '/Domingo';
    } else {
      day += '/Sábado';
    }
    return day;
  }

  static void updateState(state) {
    print("ccNumber: ${ccNumber.text}");
    // print("tmpCCNumber: $tmpCCNumber");
    Firestore.instance
    .collection('usuarios')
    .document(ccNumber.text)
    .updateData(
      {
        'incumpliendo': state
      }
    );
  }

  static void setNewInfractor(zipCode) async {

    print('******************************************');

    Future<DocumentSnapshot> historyOffenders = Firestore.instance
    .collection('historyOffenders')
    .document(zipCode).get();

    await historyOffenders.then((DocumentSnapshot sectorCali) async => {
      if(sectorCali.exists) {
        oldCantidad = sectorCali['cantidad'],
        Firestore.instance
        .collection('historyOffenders')
        .document(zipCode)
        .updateData(
          {
            'cantidad': oldCantidad + 1
          }
        )
      } 
      else {
        Firestore.instance
        .collection('historyOffenders')
        .document(zipCode)
        .setData(
          {
            'cantidad': 1,
          }
        )
      }
    });
  }

  static void getNumContagiadosSector(zipCode) async {

    Future<DocumentSnapshot> contagiadosSector = 
    Firestore.instance.
    collection('hotSector').
    document(zipCode).
    get();

    await contagiadosSector.then((DocumentSnapshot sector) => {
      if(sector.exists) {
        print("Sector COVID-19 Cases: ${sector['cantidad']}"),
        print(isSectorHot),
        if(sector['cantidad'] >= 5) {
          isSectorHot = true
        }
      }
    });

  }

  static Future<void> _showDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('ESTAS INCUMPLIENDO EL AISLAMIENTO'),
          content: new Text('Estas fuera del rango permitido de tu residencia en un día que no corresponde a tú pico y cédula. A menos que sea una urgencia, por favor regresa a tú residencia lo más pronto posible.'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: new Text('Entendido')
            )
          ],
        );
      });
  }

  static Future<void> _showDialogOK(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('¡GENIAL!'),
          content: new Text('Eres un ciudadano comprometido. Estas cumpliendo con el pico y cédula. Sigue así.'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: new Text('Entendido')
            )
          ],
        );
      });
  }

  static Future<void> _showDialogHotSector(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('¡CUIDADO!'),
          content: new Text('En esté momento, tú sector es foco de atención por un incremento en los contagios. Por favor no salgas de tú residencia si no es urgente.'),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: new Text('Entendido')
            )
          ],
        );
      });
  }

  static get getIsOutHouse => isOutHouse;
  static get getIsSectorHot => isSectorHot;

  static Future<void> getAlertDialog(BuildContext context) {
    return _showDialog(context);
  }

  static Future<void> getOKAlertDialog(BuildContext context) {
    return _showDialogOK(context);
  }

  static Future<void> getAlerSectorHottDialog(BuildContext context) {
    return _showDialogHotSector(context);
  }

  static handleClick(String value, BuildContext ctx) {
    switch (value) {
      case 'Logout':
        Navigator.pop(ctx);
        break;
    }
  }

}

HomePageUserModel setInfoLocation;