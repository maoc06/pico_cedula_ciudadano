import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/controller/homePageUsersController.dart';
import 'package:pico_cedula/model/homePageUsersModel.dart';

class HomePageUsers extends StatefulWidget {
  HomePageUsers({Key key}) : super(key: key);

  final _HomePageUsers state = _HomePageUsers();

  @override
  _HomePageUsers createState() => state;
}

class _HomePageUsers extends StateMVC<HomePageUsers> {
  _HomePageUsers() : super(HomePageUsersController()) {
    _con = controller;
  }
  HomePageUsersController _con;

  @override
  void initState() {
    super.initState();

    setInfoLocation = HomePageUserModel();
    setInfoLocation.updateLocation(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text('Inicio'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              _con.handleClick(value, this.context);
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        leading: new Container(),
      ),

      body: Container(
          // color: Colors.lightBlue[50],
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          // height: 180,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 150,
                child: Card(
                  // color: Colors.lightBlue[100],
                  // height: 180,
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      color: Colors.pink[300],
                                      child: Center(
                                        child: Text(
                                          'Dias que puedes salir',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Container(
                                    child: Text(
                                      _con.getDayCC(),
                                      style: TextStyle(
                                        color: Colors.pink[400],
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Divider(
                color: Color.fromRGBO(0, 0, 0, 0.0),
              ),

              //alertas
              Container(
                height: (_con.getIsSectorHot()) ? 260 : 190,
                // height: 260,
                child: Card(
                  elevation: 5,
                  // color: Colors.lightBlue[100],
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      color: Colors.pink[300],
                                      child: Center(
                                        child: Text(
                                          'Alertas',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Container(
                                      child: Padding(
                                    padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                                    child: Stack(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Container(
                                                height: 70.0,
                                                // child: Text('ALERTA DE ZONA'),
                                                child: GestureDetector(
                                                  onTap: () => (_con
                                                          .getIsOutHouse())
                                                      ? _con.showAlert(context)
                                                      : _con.showOKAlertDialog(
                                                          context),
                                                  child: Card(
                                                    color:
                                                        (_con.getIsOutHouse())
                                                            ? Colors.amber[400]
                                                            : Colors.green[400],
                                                    elevation: 3,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(7),
                                                      child: Stack(
                                                        children: <Widget>[
                                                          Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: <Widget>[
                                                              Image(
                                                                image: AssetImage(
                                                                    'asset/pics/salir.png'),
                                                              ),
                                                              VerticalDivider(),
                                                              (_con.getIsOutHouse())
                                                                  ? Text(
                                                                      'Estas incumpliendo el pico y cédula')
                                                                  : Text(
                                                                      '¡Excelente! Permaneces en casa'),
                                                              // Text('3'),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            Divider(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.0),
                                            ),
                                            Container(
                                              // child: Text('ALERTA DE ZONA'),
                                              height: (_con.getIsSectorHot())
                                                  ? 70.0
                                                  : 0.0,
                                              child: (_con.getIsSectorHot())
                                                  ? GestureDetector(
                                                      onTap: () => _con.showAlerSectorHottDialog(context),
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(7),
                                                          child: Stack(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Image(
                                                                    image: AssetImage(
                                                                        'asset/pics/sector.png'),
                                                                  ),
                                                                  VerticalDivider(),
                                                                  Text(
                                                                      'Tú sector es foco de atención'),
                                                                  VerticalDivider(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0.0),
                                                                  ),
                                                                  Image(
                                                                    image: AssetImage(
                                                                        'asset/pics/hot.png'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Divider(
                                                      height: 0.0,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 0.0),
                                                    ),
                                            ),
                                            // Expanded(
                                            //   child: Divider(color: Colors.red,),
                                            // ),
                                            // Container(
                                            //   child: Text('ALERTA DE SALIDA'),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Divider(
                // color: Color.fromRGBO(0, 0, 0, 0.0),
                height: (_con.getIsSectorHot()) ? 75.0 : 150.0,
              ),

              //rappi mensaje
              Container(
                  // color: Colors.black12,
                  child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Color.fromRGBO(253, 98, 80, 1.0),
                      fontSize: 15.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Por el uso de esta app, recibe beneficios en '),
                      TextSpan(
                          text: 'Rappi', style: TextStyle(fontFamily: 'Steady'))
                    ]),
              )),
            ],
          )),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Container(
      //           child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Container(
      //             child: Text(
      //               'Ultimo Digito C.C',
      //               style: TextStyle(
      //                 color: Colors.pink[300],
      //                 fontSize: 20.0,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 10.0,
      //           ),
      //           Container(
      //             child: Text(_con.getLastDigitCC(),
      //                 style: TextStyle(
      //                   color: Colors.pink[400],
      //                   fontSize: 50,
      //                   fontWeight: FontWeight.bold,
      //                 )),
      //           )
      //         ],
      //       )),
      //       SizedBox(
      //         height: 5.0,
      //       ),
      //       Container(
      //           child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Container(
      //             child: Text(
      //               'puedes salir',
      //               style: TextStyle(
      //                 color: Colors.pink[300],
      //                 fontSize: 20.0,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 10.0,
      //           ),
      //           Container(
      //             child: Text(
      //               _con.getDayCC(),
      //               style: TextStyle(
      //                 color: Colors.pink[400],
      //                 fontSize: 30.0,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           )
      //         ],
      //       )),
      //       SizedBox(
      //         height: 50.0,
      //       ),
      //       (_con.getIsOutHouse())
      //           ? Container(
      //               child: RaisedButton.icon(
      //               color: Colors.yellow[600],
      //               textColor: Colors.black54,
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(50.0)),
      //               icon: Icon(Icons.warning),
      //               label: Text(
      //                 'ALERTA',
      //                 style: TextStyle(
      //                   fontSize: 20.0,
      //                 ),
      //               ),
      //               onPressed: () => {
      //                 (_con.getIsOutHouse())
      //                     ? _con.showAlert(context)
      //                     : print('NOTHING!')
      //               },
      //             ))
      //           : Text(''),
      //       Container(
      //         padding: EdgeInsets.all(25.0),
      //         child: RichText(
      //           text: TextSpan(
      //             style: TextStyle(
      //               color: Colors.pink[200],
      //               fontSize: 20.0,
      //             ),
      //             children: <TextSpan> [
      //               TextSpan(text: 'Recuerda que puedes salir a realizar actividad fisica entre\n'),
      //               TextSpan(text: '6:00 a.m. y 7:00 p.m.', style: TextStyle(fontWeight: FontWeight.bold))
      //             ]
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 50.0,
      //       ),
      //       Container(
      //         color: Colors.black12,
      //         child: RichText(
      //         text: TextSpan(
      //             style: TextStyle(
      //               color: Color.fromRGBO(253, 98, 80, 1.0),
      //               fontSize: 15.0,
      //             ),
      //             children: <TextSpan>[
      //               TextSpan(
      //                   text: 'Por el uso de esta app, recibe beneficios en '),
      //               TextSpan(
      //                   text: 'Rappi', style: TextStyle(fontFamily: 'Steady'))
      //             ]),
      //       )),
      //     ],
      //   ),
      // ),
    );
  }
}
