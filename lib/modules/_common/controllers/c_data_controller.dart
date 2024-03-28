import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:skribbl/constants/app_functions.dart';
import 'package:skribbl/modules/_common/models/m_my_profile.dart';

class DataController extends GetxController{

  String deviceId = "";
  String apiToken = "";
  MyProfile myProfile = MyProfile.getInstance();

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

  void initLoad() async{
    // await updateDeviceId();
  }

  Future<void> updateDeviceId() async{
    final deviceInfoPlugin = DeviceInfoPlugin();

    if(Platform.isAndroid){
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id + androidInfo.serialNumber;
    }
    else if(Platform.isIOS){
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor??"-";
    }

  }

}