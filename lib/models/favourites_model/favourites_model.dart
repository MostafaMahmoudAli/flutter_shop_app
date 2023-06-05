class FavouritesModel
{
  bool?status;
  FavouritesData?data;

  FavouritesModel.fromJson(Map<String,dynamic>json)
  {
    status = json["status"];
    data = FavouritesData.fromJson(json["data"]);
  }
}

class FavouritesData
{
  int?currentPage;
 List<DataFavModel>?data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  FavouritesData.fromJson(Map<String,dynamic>json)
  {
    currentPage = json["current_page"];
    json["data"].forEach((element)
    {
      data!.add(DataFavModel.fromJson(element));
    });
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class DataFavModel
{
  int?id;
  ProductModel?product;

  DataFavModel.fromJson(Map<String,dynamic>json)
  {
     id=json["id"];
     product= ProductModel.fromJson(json["product"]);
  }
}

class ProductModel
{
  int?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String?image;
  String?name;
  String?description;


  ProductModel.fromJson(Map<String , dynamic>json)
  {
     id = json['id'];
     price = json['price'];
     oldPrice = json['old_price'];
     discount = json['discount'];
     image = json['image'];
     name = json['name'];
     description = json['description'];
  }
}