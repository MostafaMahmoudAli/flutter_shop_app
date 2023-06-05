class ChangeFavouritesModel
{
  bool?status;
  String?massage;

  ChangeFavouritesModel.fromJson(Map<String,dynamic>json)
  {
    status=json["status"];
    massage=json["massage"];

  }
}