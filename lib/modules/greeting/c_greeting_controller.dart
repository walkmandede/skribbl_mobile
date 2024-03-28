import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/_common/controllers/c_data_controller.dart';
import 'package:skribbl/modules/_common/models/m_my_profile.dart';
import 'package:skribbl/modules/lobby/v_lobby_page.dart';
import 'package:skribbl/services/network_services/api_end_points.dart';
import 'package:skribbl/services/network_services/api_service.dart';
import 'package:skribbl/services/overlays_services/dialog/dialog_service.dart';

class GreetingController extends GetxController{

  TextEditingController txtName = TextEditingController(text: "");
  ValueNotifier<bool> xLoading = ValueNotifier(false);

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> initLoad() async{
    xLoading.value = true;
    xLoading.notifyListeners();
    try{
      setGetXDefaultConfig();
      final dataController = Get.put(DataController());
      await dataController.updateDeviceId();
      await fetchMe();
      superPrint(dataController.deviceId);
    }
    catch(e){
      null;
    }
    xLoading.value = false;
    xLoading.notifyListeners();
  }

  Future<void> fetchMe() async{
    DataController dataController = Get.find();
    final response = await ApiService().get(
      endPoint: "${ApiEndPoints.me}?deviceId=${dataController.deviceId}",
    );
    await ApiService().validateResponse(
        response: response,
        onSuccess: (data) {
          dataController.apiToken = data["_data"]["token"];
          try{
            txtName.text = data["_data"]["user"]["name"]??"";
          }
          catch(e){
            null;
          }
        },
        onFailure: (data, errorMessage) {
          DialogService().showTransactionDialog(text: errorMessage);
        },
    );

  }

  Future<void> onClickNext() async{
    if(txtName.text.length<2){
      DialogService().showTransactionDialog(text: "Your name's length must be at least 2");
    }
    else{
      DataController dataController = Get.find();
      DialogService().showLoadingDialog();
      final response = await ApiService().get(
        endPoint: "${ApiEndPoints.me}?deviceId=${dataController.deviceId}&name=${txtName.text}",
      );
      DialogService().dismissDialog();
      await ApiService().validateResponse(
        response: response,
        onSuccess: (data) {
          dataController.apiToken = data["_data"]["token"];
          MyProfile myProfile = MyProfile(
            name: data["_data"]["user"]["name"]??"Undefined",
            id: data["_data"]["user"]["insertedId"]??"",
            deviceId: dataController.deviceId,
          );
          dataController.myProfile = myProfile;
          Get.off(()=> const LobbyPage());
        },
        onFailure: (data, errorMessage) {
          DialogService().showTransactionDialog(text: errorMessage);
        },
      );
    }
  }

  void setGetXDefaultConfig(){
    Get.config(
        defaultTransition: Transition.cupertino,
        defaultDurationTransition: const Duration(milliseconds: 800)
    );
  }

}