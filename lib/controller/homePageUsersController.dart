
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/model/homePageUsersModel.dart';

class HomePageUsersController extends ControllerMVC {

  // updateLocation() => HomePageUserModel.updateLocation();
  getLastDigitCC() => HomePageUserModel.getLastDigitCC();
  getDayCC() => HomePageUserModel.getDay();
  Future<void> showAlert(_context) => HomePageUserModel.getAlertDialog(_context);
  Future<void> showOKAlertDialog(_context) => HomePageUserModel.getOKAlertDialog(_context);
  Future<void> showAlerSectorHottDialog(_context) => HomePageUserModel.getAlerSectorHottDialog(_context);
  getIsOutHouse() => HomePageUserModel.getIsOutHouse;
  getIsSectorHot() => HomePageUserModel.getIsSectorHot;
  handleClick(_value, _ctx) => HomePageUserModel.handleClick(_value, _ctx);

}