import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/model/loginCiudadanoModel.dart';

class LoginCiudadanoController extends ControllerMVC {

  Future<int> checkIsUserExists() => LoginCiudadanoModel.checkIsCCExists();
  getIsLoggedIn() => LoginCiudadanoModel.getIsLoggedIn;
  getNamePrefs() => LoginCiudadanoModel.getNamePrefs;
  Future<bool> getAutoLogin() => LoginCiudadanoModel.autoLogin();
  setLocalStorage() => LoginCiudadanoModel.setAutoLogin();
  

}