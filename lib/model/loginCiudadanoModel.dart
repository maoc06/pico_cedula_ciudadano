import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pico_cedula/view/loginCiudadanoView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCiudadanoModel {

  static bool isLoggedIn = false;
  static String name = '';
  
  static Future<int> checkIsCCExists() async {
    int res = -1;

    Future<DocumentSnapshot> ccUser = Firestore.instance.collection('usuarios').document(ccNumber.text).get();
    await ccUser.then((DocumentSnapshot userCoordinates) async => {
      if(userCoordinates.exists) {
        // setAutoLogin(),
        res = 0
      } else {
        res = 1,
        await insertUser().then((onValue) {
          if(onValue == 1) {res = 2;}
        })
      }
    });

    return res;
  }

  static Future<int> insertUser() async {
    int res = -1;
    await Firestore.instance
    .collection('usuarios')
    .document(ccNumber.text)
    .setData(
      {
        'latitud': 0.0,
        'longitud': 0.0,
        'phoneNum': phoneNumber.text,
        'incumpliendo': false
      }
    ).then((value) {
      res = 1;
    });
    return res;
  }

  static Future<bool> autoLogin() async {
    var isLogged = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('userId');

    if(userId != null) {
      isLogged = true;
      name = userId;
      print("------>PREFS NAME = $name");
    }
    return isLogged;
  }

  static Future<Null> setAutoLogin() async {
    print("---------------->SET LOGIN PREFS<-------------------------");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', ccNumber.text);
      
    name = ccNumber.text;
    isLoggedIn = true;
    print("*------>PREFS NAME = $name");

    // ccNumber.clear();
  }

  static get getIsLoggedIn => isLoggedIn;
  static get getNamePrefs => name;
  
}