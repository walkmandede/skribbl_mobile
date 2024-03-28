import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_functions.dart';
import 'package:dio/dio.dart' as dio;
import '../../modules/_common/controllers/c_data_controller.dart';
import '../overlays_services/dialog/dialog_service.dart';

class ApiService {
  ///staging
  String baseUrl = "https://sk-backend.buclib.club/api/v1/";

  ///local-XspherIT-2024
  // String baseUrl = "http://192.168.86.33:3000/api/"; //staging

  // final dioClient = dio.Dio(
  //   dio.BaseOptions(
  //     connectTimeout: const Duration(seconds: 120),
  //   )
  // );
  final getClient = GetConnect(
    timeout: const Duration(seconds: 40),
  );

  String convertNetworkImage({required String orgPath}){
    return ApiService().baseUrl.replaceAll("api/", "api")+orgPath;
  }

  Future<Response?> get({required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();
    final response = await getClient.get(
      xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );
    return response;
  }

  Future<Response?> post(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();

    final response = await getClient.post(
      xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
      data,
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );
    return response;
  }

  Future<Response?> put(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    DataController dataController = Get.find();
    final response = await getClient.put(
      xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
      data,
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
        if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
      },
    );
    return response;
  }

  Future<Response?> formDataPost(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      Map<String, dio.MultipartFile> files = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    Response? response;
    try {
      dio.Dio dioClient = dio.Dio();
      dio.FormData formData = dio.FormData.fromMap({...data, ...files});
      DataController dataController = Get.find();
      var dioResponse = await dioClient.post(
          xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint,
          options: dio.Options(
            contentType: 'text/html; charset=utf-8',
            headers: <String, String>{
              "accept": "*/*",
              "Content-Type": "application/json",
              if (xNeedToken)
                "Authorization": "Bearer ${dataController.apiToken}",
            },
          ),
          data: formData);
      if (dioResponse.statusCode == 201) {
        response = Response(
          statusCode: 201,
          headers: {},
          body: dioResponse.data,
          statusText: "",
        );
      }
    } catch (error) {
      if (error is dio.DioException) {
        try{
          superPrint(error.response!.data, title: error.response!.statusCode);
          response = Response(
              statusCode: error.response!.statusCode,
              body: error.response!.data,
              bodyString: error.response!.data.toString()
          );
        }
        catch(e){
          superPrint(error.toString());
          response = const Response(
            statusCode: 0,
            body: {},
            bodyString: "Something went wrong!"
          );
        }
      }
    }
    return response;
  }

  Future<void> validateResponse({
    required Response? response,
    required Function(Map<String, dynamic> data) onSuccess,
    required Function(Map<String, dynamic> data, String errorMessage) onFailure,
  }) async {
    if (response == null) {
      DialogService().showSnack(
          title: "Something went wrong",
          message: "Unable to use the system now.Please contact the development team.");
    }
    else {
      try {
        if (response.statusCode! < 200 || response.statusCode! > 299) {
          if (response.body["_metadata"]["message"]
                  .toString()
                  .replaceAll(" ", "")
                  .toLowerCase() ==
              "invalidtoken") {
            //invalidToken
            if (Get.currentRoute == "/LoginPhonePage") {
              return;
            } else {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              DialogService().showSnack(
                  title: "Something went wrong",
                  message:
                      "Unable to use the system now.Please contact the development team.");
              return;
            }
          } else {
            //failure
            await onFailure(response.body,
                response.body["_metadata"]["message"].toString());
            return;
          }
        } else if (response!.body["_metadata"]["statusCode"] >= 200 &&
            response!.body["_metadata"]["statusCode"] <= 299) {
          //success
          await onSuccess(response.body);
          return;
        } else {
          superPrint(response.body);
          if (response.body["_metadata"]["message"]
                  .toString()
                  .replaceAll(" ", "")
                  .toLowerCase() ==
              "invalidtoken") {
            //invalidToken
            if (Get.currentRoute == "/LoginPhonePage") {
              return;
            } else {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              DialogService().showSnack(
                  title: "Something went wrong",
                  message:
                      "Unable to use the system now.Please contact the development team.");
              return;
            }
          } else {
            //failure
            await onFailure(response.body,
                response.body["_metadata"]["message"].toString());
            return;
          }
        }
      } catch (e) {
        if(response.statusCode == null){
          DialogService().showSnack(title: "Connection Time Out", message: "Unable to use the system now.Please contact the development team.");
        }
        else{
          DialogService().showSnack(title: "Something went wrong", message: "Unable to use the system now.Please contact the development team.");
        }
      }
    }
  }
}
