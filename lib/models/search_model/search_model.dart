class SearchModel{
  bool?status;
  SearchDataModel?data;

  SearchModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=SearchDataModel.fromJson(json["data"]);
  }
}

class SearchDataModel{
  int?currentPage;
  List<DataModel>?data=[];
  SearchDataModel.fromJson(Map<String,dynamic>json)
  {
    currentPage=json["current_page"];
    json["data"].forEach((element)
    {
      data!.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  int?id;
  String?price;
  String?image;
  String?name;
  List<String>?images;
  bool?inFavorites;
  bool?inCart;
  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json["id"];
    price=json["price"];
    image=json["image"];
    name=json["name"];
    inFavorites=json["in_favorites"];
    inCart=json["in_cart"];
    images=json["images"].cast<String>();
  }
}