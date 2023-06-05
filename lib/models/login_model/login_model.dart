class ShopLoginModel
{
   bool?status;
   String?message;
   UserData?data;

   ShopLoginModel.formJson(Map<String,dynamic>json)
   {
     status= json["status"];
     message= json["message"];
     data= json["data"]!= null ? UserData.formJson(json["data"]): null;
   }
}

class UserData
{
  int?id;
  String?name;
  String?email;
  String?phone;
  String?image;
  int?points;
  int?credit;
  String?token;

  //Constructor

//   UserData({
//     this.id,
//     this.name,
//     this.phone,
//     this.image,
//     this.email,
//     this.credit,
//     this.points,
//     this.token,
// });


//named constructor
  UserData.formJson(Map<String,dynamic>json)
  {
   id= json["id"];
   name= json["name"];
   phone= json["phone"];
   image= json["image"];
   email= json["email"];
   credit= json["credit"];
   points= json["points"];
   token= json["token"];
  }
}