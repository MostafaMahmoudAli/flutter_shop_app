import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/cubit/shopcubit.dart';
import '../../shared/cubit/shopstates.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../onboarding/onboarding_screen.dart';

//sdvnsdvnmbvbdfv

class SettingsScreen extends StatelessWidget {
  var userController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){

    ShopCubit.get(context).getSettingsData();




    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state) {} ,
      builder:(context,state)
      {
        var model=ShopCubit.get(context).userModel;
        userController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                    if(state is ShopLoadingUpDateUserDataState)const LinearProgressIndicator(),
                  SizedBox(
                    height:20.0,
                  ),
                  defultFormField(
                      controller: userController,
                      keyboardType: TextInputType.name,
                      validator: (String?value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Name Must Not Be Empty";
                        }
                        return null;


                      },
                      prefix:Icons.person,
                      text:"Name",
                  ),
                   const SizedBox(
                    height:20.0,
                  ),
                  defultFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String?value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Email Address Must Not Be Empty";
                      }
                      return null;


                    },
                    prefix:Icons.email,
                    text:"Email Address",
                  ),
                   const SizedBox(
                    height:20.0,
                  ),
                  defultFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (String?value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Number Must Not Be Empty";
                      }
                      return null;


                    },
                    prefix:Icons.phone_android_outlined,
                    text:"Phone",
                  ),
                  const SizedBox(
                    height:20.0,
                  ),
                  defultButton(
                      function: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          ShopCubit.get(context).upDateUserData(
                            name:userController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }

                      },
                      text: "UPDATE",
                      color: primarySwitchColor,
                      height:50.0,
                  ),
                   const SizedBox(
                    height:30.0,
                  ),
                  defultButton(
                    function: ()
                    {
                      CacheHelper.removeData(key:token!).then((value)
                      {
                        if(value)
                        {
                          navigateAndFinish(context,OnBoardingScreen());
                        }
                      });
                    },
                    text:"logout",
                    color:primarySwitchColor,
                    height:50.0,
                  ),
                  defultButton(function: (){},
                      text:"another button",
                    color:primarySwitchColor,
                    height:30.0,
                    isUpperCase:true,
                  ),
                //  the last button is just a button it's not doing any thing
                ],
              ),
            ),
          ),
        );
      } ,
    );
  }
}

// I'm trying commands
