
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pico_cedula/model/setHouseLocationMapModel.dart';

class SetHouseLocationMapController extends ControllerMVC {

  //onMapCreated() => SetHouseLocationModel.onMapCreated;
  Future<int> onAddLocation() => SetHouseLocationModel.onAddLocation();
  updatePosition(_position) => SetHouseLocationModel.updatePosition(_position);

  getMarkers() => SetHouseLocationModel.getMarkers;
  getCenter()=> SetHouseLocationModel.getCenter;
  getGoogleMapControlle() => SetHouseLocationModel.getController;

}