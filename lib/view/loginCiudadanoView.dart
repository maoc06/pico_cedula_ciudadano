import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/controller/loginCiudadanoController.dart';

import 'SetHouseLocationMapView.dart';
import 'homePageUsersView.dart';

//import 'homePageUsersView.dart';

final ccNumber = TextEditingController();
final phoneNumber = TextEditingController();
var isAlreadyLoggedIn = false;
//BuildContext contextLoginCiudadano;

class LoginCiudadano extends StatefulWidget {
  LoginCiudadano({Key key}) : super(key: key);

  final MaterialAppCiudadano state = MaterialAppCiudadano();

  LoginCiudadanoController get controller => state.controller;

  @override
  MaterialAppCiudadano createState() => state;
}

class MaterialAppCiudadano extends StateMVC<LoginCiudadano> {
  MaterialAppCiudadano() : super(LoginCiudadanoController()) {
    _con = controller;
  }
  LoginCiudadanoController _con;

  @override
  void initState() {
    super.initState();
    Future(() async {
      print('-*-*-*-*-*-*-*-**-*-*-*-*-*');
      var isLoggedIn = await _con.getAutoLogin();
      print("IsLoggedIn? = $isLoggedIn");
      if(isLoggedIn) {

        isAlreadyLoggedIn = isLoggedIn;

        print("------------> ALREADY LOGGED IN<------------");

        // Navigator.push(context,MaterialPageRoute(builder: (context) => HomePageUsers()));

      }
      
    });
    
  }

  @override
  Widget build(BuildContext context) {
    //setState(() => this.context = context);

    return MaterialApp(
      title: 'Login Ciudadano',
      debugShowCheckedModeBanner: false,
      home: 
      _LoginCiudadano(
        ccNumberInput: ccNumber,
        phoneNumerInput: phoneNumber,
        controlador: _con,
      )
    );
  }
}

class _LoginCiudadano extends StatelessWidget {
  //BuildContext context;

  final TextEditingController ccNumberInput;
  final TextEditingController phoneNumerInput;
  final LoginCiudadanoController controlador;
  // final State<StatefulWidget> state;

  const _LoginCiudadano({
    Key key,
    @required this.ccNumberInput,
    @required this.phoneNumerInput,
    @required this.controlador,
    // @required this.state
  }) : super(key: key);

  // initState() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   print("############################");
  //   if(user != null) {
  //     print("User ${user.providerId} is logged!");
  //   } else {
  //     print("User didn't login before!");
  //   }
  //   print("############################");
  // }

  @override
  Widget build(BuildContext context) {
    //setState(() => this.context = context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text("Login Ciudadano"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context, false),
        // ),
      ),

      // resizeToAvoidBottomPadding: false,

      body: Stack(
        
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/pics/loginCiudadano.png'),
                    fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
              child: Container(
            color: Colors.transparent,
            child:Column(
              children: [
                SizedBox(
                  height: 270,
                ),
                Container(
                    width: 250.0,
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: ccNumber,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          labelText: 'Num. Cédula',
                        ),
                        maxLength: 10,
                        //autofocus: true,
                        style: TextStyle(
                            height: 1, fontSize: 20.0, color: Colors.black54),
                        //onSubmitted: (cc) => checkIsCCExists(cc, context),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: 250.0,
                    child: Center(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: phoneNumber,
                        // hasFloatingPlaceholder: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          labelText: 'Num. Celular',
                        ),
                        maxLength: 10,
                        style: TextStyle(
                            height: 1, fontSize: 20.0, color: Colors.black54),
                      ),
                    )),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child: Center(
                      child: ButtonTheme(
                    minWidth: 250.0,
                    height: 50.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      onPressed: () async {
                        controlador.checkIsUserExists().then((onValue) {
                          if (onValue == 0) {
                            print('NAVEGAMOS A LA HOME-PAGE-USERS');
                            controlador.setLocalStorage();
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePageUsers()))
                                .then((_) {
                              ccNumber.text = '';
                            });
                          } else if (onValue == 2) {
                            print('INSERTAMOS NUEVO USUARIO Y LUEGO NAVEGAMOS');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SetLocationHouseMap())).then((_) {
                              ccNumber.text = '';
                            });
                          }
                        });
                      },
                      child: Text(
                        'Ingresar',
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: new EdgeInsets.all(15.0),
                      color: Colors.pink[400],
                      textColor: Colors.lightBlue[50],
                    ),
                  )),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
