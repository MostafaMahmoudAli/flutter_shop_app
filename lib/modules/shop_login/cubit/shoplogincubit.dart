import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/shop_login/cubit/shoploginstates.dart';
import '../../../models/login_model/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';



class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix =Icons.visibility;

  void changePasswordVisibility()
  {
    isPassword =!isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibility());
  }

  ShopLoginModel?loginModel;

  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: login,
        data:
        {
          "email":email,
          "password":password,
        }).then((value){
          print(value.data);
          loginModel=ShopLoginModel.formJson(value.data);
          emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

}