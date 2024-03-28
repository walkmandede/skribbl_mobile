import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/_common/controllers/c_data_controller.dart';
import 'package:skribbl/modules/_common/models/m_in_game_player.dart';
import 'package:skribbl/modules/lobby/v_lobby_page.dart';
import 'package:skribbl/modules/room/d_room_socket_events.dart';
import 'package:skribbl/services/network_services/api_end_points.dart';
import 'package:skribbl/services/network_services/api_service.dart';
import 'package:skribbl/services/overlays_services/dialog/dialog_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as sic;

import '../_common/models/m_in_game_message.dart';

class RoomController extends GetxController{

  ValueNotifier<bool> xLoading = ValueNotifier(false);
  TextEditingController txtMsg = TextEditingController(text: "");
  ValueNotifier<String> currentRoomCode = ValueNotifier("");
  DataController dataController = Get.find();
  sic.Socket? socket;
  ValueNotifier<List<InGamePlayer>> playersList = ValueNotifier([]);
  ValueNotifier<List<InGameMessage>> messagesList = ValueNotifier([]);
  ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    if(socket!=null){
      socket!.dispose();
    }
    super.onClose();
  }

  Future<void> initLoad({required String roomCode}) async{
    xLoading.value = true;
    xLoading.notifyListeners();
    try{
      currentRoomCode.value = roomCode;
      currentRoomCode.notifyListeners();
      initSocket();
    }
    catch(e){
      null;
    }
    xLoading.value = true;
    xLoading.notifyListeners();
  }

  void initSocket() async{
    socket = sic.io(
        'https://sk-backend.buclib.club/socket',
        sic.OptionBuilder()
            .setQuery({"userId":dataController.myProfile.id})
            .setTransports(["websocket"])
            .enableForceNew()
            .build()
    );
    socket!.onAny((event, data) {
      superPrint(data,title: event);
      switch(event){
        case RoomSocketEvents.userJoinRoom :
          DialogService().showSnack(title: "A player has joined the game.", message: data["msg"].toString());
          updatePlayersList();
          break;
        case RoomSocketEvents.userLeaveRoom :
          DialogService().showSnack(title: "A player has left the game.", message: data["msg"].toString());
          updatePlayersList();
          break;
        case RoomSocketEvents.exception :
          Get.offAll(const LobbyPage());
          DialogService().showSnack(title: "Something went wrong",message: "Room does not exist");
          break;
        case RoomSocketEvents.roomMessage :
          messagesList.value.add(
            InGameMessage.fromMap(data: data)
          );
          messagesList.notifyListeners();
          break;
      }
    });
    socket!.connect();
    socket!.emit("joinRoom",{
      "roomCode" : currentRoomCode.value,
      "userId" : dataController.myProfile.id
    });
  }

  Future<void> updatePlayersList() async{

    playersList.value.clear();
    playersList.notifyListeners();
    final response = await ApiService().get(
      endPoint: "${ApiEndPoints.getRoomPlayers}/${currentRoomCode.value}",
      xNeedToken: true
    );
    superPrint(response!.body);
    await ApiService().validateResponse(
        response: response,
        onSuccess: (data) {
          superPrint(data);
          Iterable users = data["_data"]["users"];
          for(final eachUser in users){
            playersList.value.add(InGamePlayer.fromApi(data: eachUser));
          }
          playersList.notifyListeners();
        },
        onFailure: (data, errorMessage) {
          superPrint(data);
        },
    );
  }

  void onClickSend(){
    dismissKeyboard();
    superPrint('here');
    if(txtMsg.text.isNotEmpty){
      socket!.emit(
          RoomSocketEvents.sendRoom,
          {
            "roomCode": currentRoomCode.value,
            "event": RoomSocketEvents.roomMessage,
            "data":{
              "userName" : dataController.myProfile.name,
              "message": txtMsg.text
            }
          }
      );
      txtMsg.clear();
    }
  }

}