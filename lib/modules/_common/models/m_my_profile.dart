
class MyProfile{

  String id;
  String deviceId;
  String name;

  MyProfile({required this.id,required this.deviceId,required this.name});

  factory MyProfile.getInstance(){
    return MyProfile(deviceId: "", name: "",id: "");
  }


  bool xValid()=> deviceId.isNotEmpty;

}