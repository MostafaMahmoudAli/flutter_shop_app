import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/register/register_cubit/register_states.dart';
import '../../../models/login_model/login_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  var isPassword=true;

  IconData suffix=Icons.visibility_outlined;

  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix= isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit( RegisterChangePasswordVisibilityState());
  }

  ShopLoginModel?registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: register,
        data:
        {
          "name":name,
          "email":email,
          "password":password,
          "phone":phone,
        }
    ).then((value)
    {
      registerModel=ShopLoginModel.formJson(value.data);
      emit(RegisterSuccessState(registerModel!));

    }).catchError((error)
    {
      emit(RegisterErrorState(error.toString()));
    });
  }
}