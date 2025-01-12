import 'package:scoped_model/scoped_model.dart';

import '../model/room.dart';
import '../util/database_helper.dart';

import '../model/light.dart';

import '../util/mqtt_util.dart';

class RoomModel extends Model {
  var db = DatabaseHelper();
  bool local = false;
  int noOfLights = 0;
  String xAuth = " ";
  
  List<Room> _rooms = [];
  
  MqttUtil mqtt = MqttUtil();
  bool mqttState = false;
  bool mqttStateChecking = false;

  getRooms() async {
    List roomsSQL = await db.getAllRooms();
    if (_rooms.isNotEmpty) {
      _rooms.clear();
    }
    for (int i = 0; i < roomsSQL.length; i++) {
      Room room = Room.map(roomsSQL[i]);
      _rooms.add(room);
    }
    notifyListeners();
  }

  get length => _rooms.length;
  //room needs to be database query;
  void addRoom(var roomSQL) {
    Room room = Room.map(roomSQL);
    _rooms.add(room);
    notifyListeners();
  }


  Room getRoomFromList(int index) {
    return _rooms[index];
  }

}
