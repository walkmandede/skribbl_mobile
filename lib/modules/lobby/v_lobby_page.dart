import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/modules/_common/controllers/c_data_controller.dart';
import 'package:skribbl/modules/room/playground/v_playground_page.dart';
import 'package:skribbl/modules/room_create/v_create_room_page.dart';
import 'package:skribbl/services/others/extensions.dart';

import '../../constants/app_functions.dart';

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {

  TextEditingController txtRoomCode = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> onClickCreateRoom() async{

  }

  Future<void> onClickJoinRoom() async{

  }

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello! ${dataController.myProfile.name}",
          style: TextStyle(
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w900
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(AppConstants.basePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtRoomCode,
                    decoration: const InputDecoration(
                        labelText: "Enter Room Code To Join"
                    ),
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                  ),
                ),
              ],
            ),
            10.heightBox(),
            SizedBox(
                width: double.infinity,
                height: AppConstants.baseButtonHeightS,
                child: ElevatedButton(
                  onPressed: () {
                    if(txtRoomCode.text.isNotEmpty){
                      Get.to(()=> PlaygroundPage(roomCode: txtRoomCode.text));
                    }
                  },
                  child: const Text("Join Room"),
                )
            ),
            20.heightBox(),
            SizedBox(
              width: double.infinity,
              height: AppConstants.baseButtonHeightM,
              child: ElevatedButton(
                onPressed: () {
                  vibrateNow();
                  Get.to(()=> const CreateRoomPage());
                },
                style: ElevatedButton.styleFrom(),
                child: const Text(
                  "Create Room",
                  style: TextStyle(

                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
