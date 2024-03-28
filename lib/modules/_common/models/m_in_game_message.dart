
import 'package:skribbl/modules/_common/models/m_in_game_player.dart';

class InGameMessage{
  InGamePlayer inGamePlayer;
  String message;
  bool xGuessed;

  InGameMessage({
    required this.inGamePlayer,
    required this.message,
    required this.xGuessed
  });

  factory InGameMessage.fromMap({required Map<String,dynamic> data}){
    return InGameMessage(
      inGamePlayer: InGamePlayer(
        point: 0,
        name: data["user"]==null?"Undefined":data["user"]["userName"].toString(),
        id: "",
      ),
      message: data["msg"].toString(),
      xGuessed: bool.tryParse(data["guessed"].toString())??false
    );
  }

}