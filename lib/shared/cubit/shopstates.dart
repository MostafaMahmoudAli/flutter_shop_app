
import '../../models/change_favourites_model/change_favourites_model.dart';
import '../../models/login_model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBar extends ShopStates{}

class ShopLoadingHomaDataState extends ShopStates {}

class ShopSuccessHomaDataState extends ShopStates {}

class ShopErrorHomaDataState extends ShopStates {
  final String error;
  ShopErrorHomaDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavouritesState extends ShopStates
{
 late final ChangeFavouritesModel model;

  ShopSuccessChangeFavouritesState(this.model);
}

class ShopChangeFavouritesState extends ShopStates {}

class ShopErrorChangeFavouritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavouritesState(this.error);
}

class ShopSuccessGetFavouritesState extends ShopStates {}

class ShopErrorGetFavouritesState extends ShopStates {
  final String error;
  ShopErrorGetFavouritesState(this.error);
}

class ShopSuccessGetUserDataState extends ShopStates {

 late final ShopLoginModel loginModel;
 ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;
  ShopErrorGetUserDataState(this.error);
}

class ShopLoadingUpDateUserDataState extends ShopStates{}

class ShopSuccessUpDateUserDataState extends ShopStates {

  late final ShopLoginModel userModel;
  ShopSuccessUpDateUserDataState(this.userModel);
}


class ShopErrorUpDateUserDataState extends ShopStates {
  final String error;
  ShopErrorUpDateUserDataState(this.error);
}


