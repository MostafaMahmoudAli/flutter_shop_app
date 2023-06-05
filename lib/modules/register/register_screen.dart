import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/register/register_cubit/register_cubit.dart';
import 'package:flutter_shop_app/modules/register/register_cubit/register_states.dart';
import '../../layout/shop_layout.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey= GlobalKey<FormState>();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context,state)
        {
          if (state is RegisterSuccessState)
          {
            if(state.registerModel.status!)
            {
              print(state.registerModel.message!);
              print(state.registerModel.data!.token);
              token=state.registerModel.data!.token;
              CacheHelper.saveData(
                  key: "token",
                  value: state.registerModel.data!.token
              ).then((value)
              {


                navigateAndFinish(context,ShopLayoutScreen());
              });

              showToast(text:state.registerModel.message!,
                  state:ToastStates.success,
              );

            }else
            {
              print(state.registerModel.message!);
              showToast(
                  text:state.registerModel.message!,
                  state: ToastStates.error,
              );
            }
          }
        },
        builder:(context,state)
        {
          return  Scaffold(
            appBar:AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Text(
                          "REGISTER",
                          style:Theme.of(context).textTheme.headline5?.copyWith(color:Colors.black,fontWeight:FontWeight.w900),
                        ),
                        const SizedBox(
                          height:30.0,
                        ),
                        Text(
                          "REGISTER Now To Know Our Hot Offers ",
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.black,fontWeight:FontWeight.w900),
                        ),
                        const SizedBox(
                          height:30.0,
                        ),
                        defultFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator:(String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return "Name Must N't Be Empty";
                              }
                              return null;
                            },
                            prefix: Icons.person_add,

                            text: "UserName",
                        ),
                        const SizedBox(
                          height:14.0,
                        ),
                        defultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator:(String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Email Address Must N't Be Empty";
                            }
                            return null;
                          },
                          prefix: Icons.email_rounded,

                          text: "Email Address",
                        ),
                        const SizedBox(
                          height:15.0,
                        ),
                        defultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator:(String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Password Must N't Be Empty";
                            }
                            return null;
                          },
                          prefix: Icons.lock_outline_rounded,

                          isPassword:RegisterCubit.get(context).isPassword,

                          suffix:RegisterCubit.get(context).suffix,

                          onPressed: ()
                          {
                            RegisterCubit.get(context).changePasswordVisibility();
                          },
                          text: "Password",
                        ),
                        const SizedBox(
                          height:15.0,
                        ),
                        //PasswordFormField
                        defultFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator:(String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Phone Number Must N't Be Empty";
                            }
                            return null;
                          },
                          prefix: Icons.phone_android_sharp,

                          text: "Phone Number",
                        ),
                        const SizedBox(height:40.0,),
                        defultButton(
                            function:()
                            {
                              if(formKey.currentState!.validate())
                              {
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            text:"register",
                            height:40.0,
                          color:primarySwitchColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
