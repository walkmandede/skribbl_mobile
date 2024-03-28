import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_constants.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/room/playground/v_playground_page.dart';
import 'package:skribbl/services/network_services/api_end_points.dart';
import 'package:skribbl/services/network_services/api_service.dart';
import 'package:skribbl/services/others/extensions.dart';
import 'package:skribbl/services/overlays_services/dialog/dialog_service.dart';

class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {

  ValueNotifier<int> round = ValueNotifier(3);
  ValueNotifier<int> drawTime = ValueNotifier(100);
  ValueNotifier<int> wordCount = ValueNotifier(3);
  ValueNotifier<int> hint = ValueNotifier(2);

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

  Future<void> onClickCreateNow() async{
    DialogService().showLoadingDialog();
    final response = await ApiService().post(
      endPoint: ApiEndPoints.createRoom,
      xNeedToken: true,
      data: {
        "round": round.value,
        "playerCount": 20,
        "drawTimeInSec": drawTime.value,
        "wordCount": wordCount.value,
        "hit": hint.value
      }
    );
    DialogService().dismissDialog();
    ApiService().validateResponse(
        response: response,
        onSuccess: (data) {
          final roomCode = data["_data"]["code"].toString();
          Get.to(()=> PlaygroundPage(roomCode: roomCode));
        },
        onFailure: (data, errorMessage) {
          DialogService().showTransactionDialog(text: errorMessage);
        },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Room",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: AppConstants.fontSizeXL
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(AppConstants.basePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            eachWidget(
                label: "Round",
                valueNotifier: round,
                max: 10,
                min: 1
            ),
            eachWidget(
                label: "Draw Time",
                valueNotifier: drawTime,
                max: 200,
                min: 30
            ),
            eachWidget(
                label: "Word Count",
                valueNotifier: wordCount,
                max: 6,
                min: 1
            ),
            eachWidget(
                label: "Hint",
                valueNotifier: hint,
                max: 5,
                min: 0
            ),
            SizedBox(
              width: double.infinity,
              height: AppConstants.baseButtonHeightM,
              child: ElevatedButton(
                onPressed: () {
                  vibrateNow();
                  onClickCreateNow();
                },
                child: const Text("Create Now"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget eachWidget({
    required String label,
    required ValueNotifier<int> valueNotifier,
    required int min,
    required int max,
  }){
    return Container(
      margin: EdgeInsets.only(bottom: AppConstants.basePadding),
      child: ValueListenableBuilder(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  label
              ),
              10.widthBox(),
              Expanded(
                child: Slider(
                  value: value.toDouble(),
                  onChanged: (value) {
                    valueNotifier.value = value.toInt();
                    valueNotifier.notifyListeners();
                  },
                  max: max.toDouble(),
                  min: min.toDouble(),
                ),
              ),
              10.widthBox(),
              Text(
                  "$value"
              ),
            ],
          );
        },
      ),
    );
  }

}
