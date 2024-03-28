
class InGamePlayer{
  String id;
  String name;
  int point;

  InGamePlayer({
    required this.id,
    required this.name,
    required this.point,
  });

  factory InGamePlayer.fromApi({required Map<String,dynamic> data}){
    return InGamePlayer(
      id: data["id"].toString(),
      name: data["name"].toString(),
      point: int.parse(data["point"].toString())??0
    );
  }

}