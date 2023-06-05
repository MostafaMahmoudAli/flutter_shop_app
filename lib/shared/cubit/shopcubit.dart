
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/shared/cubit/shopstates.dart';
import '../../models/categories_model/categories_model.dart';
import '../../models/change_favourites_model/change_favourites_model.dart';
import '../../models/favourites_model/favourites_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/login_model/login_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/favourites/favourites_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../componants/constant.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit():super(ShopInitialState());

  static ShopCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;

  List<Widget>bottomScreens= [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index)
  {
    currentIndex=index;
    emit(ShopChangeBottomNavBar());
  }

  List<BottomNavigationBarItem>bottomNavigationBar=
  [
    BottomNavigationBarItem(
      icon:Icon(
        Icons.home,
      ),
      label:"Home",
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.apps,
      ),
      label:"Categories",
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.favorite_outline_outlined,
      ),
      label:"Favourites",
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.settings,
      ),
      label:"Settings",
    ),
  ];

 HomeModel?homeModel;

 Map<int?,bool?>favourites={};

  void getHomeData()
  {
    emit(ShopLoadingHomaDataState());
    DioHelper.getData(
        url: home,
      token:token,
    ).then((value)
    {
     homeModel= HomeModel.fromJson(value.data);
     for (var element in homeModel!.data!.products) {
       favourites.addAll({
         element.id : element.inFavorites
       });
     }
      emit(ShopSuccessHomaDataState());
    }).catchError((error)
    {
      print(error);
      emit(ShopErrorHomaDataState(error.toString()));
    });
  }

  CategoriesModel?categoriesModel;


  void getCategoriesData()
  {

    DioHelper.getData(
      url: categories,
      token:token,
    ).then((value)
    {
      categoriesModel= CategoriesModel.fromJson(value.data);
      print(token);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error);
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  ChangeFavouritesModel?changeFavouritesModel;

  void changeFavourites(int?productId)
  {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
        url:favorites,
        data:
        {
          "product_id":productId,
        },
      token:token,

    ).then((value)
    {
      changeFavouritesModel=ChangeFavouritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavouritesModel!.status!)
      {
        favourites[productId]=!favourites[productId]!;
      }else
      {
        getFavouritesData();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouritesModel!));
    }).catchError((error)
    {
      favourites[productId]=!favourites[productId]!;
      emit(ShopErrorChangeFavouritesState(error.toString()));
    });
  }

  FavouritesModel?favouritesModel;

  void getFavouritesData()
  {
    DioHelper.getData(
      url: favorites,
      token:token,
    ).then((value)
    {
      favouritesModel= FavouritesModel.fromJson(value.data);
      print(value.data);
      emit( ShopSuccessGetFavouritesState());
    }).catchError((error)
    {
      emit(ShopErrorGetFavouritesState(error));
    });
  }

  ShopLoginModel?userModel;

  void getSettingsData()
  {
    DioHelper.getData(
        url: profile,
      token:token,
    ).then((value)
    {
      userModel=ShopLoginModel.formJson(value.data);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error)
    {
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  void upDateUserData({
    required String name,
    required String email,
    required String phone,

})
  {
    emit(ShopLoadingUpDateUserDataState());

    DioHelper.putData(
        url: updateProfile,
        data:{
          "name":name,
          "email":email,
          "phone":phone,
        },
        token:token,
    ).then((value)
    {
      userModel=ShopLoginModel.formJson(value.data);
      emit(ShopSuccessUpDateUserDataState(userModel!));
    }).catchError((error)
    {
      emit(ShopErrorUpDateUserDataState(error));
    });
  }

}