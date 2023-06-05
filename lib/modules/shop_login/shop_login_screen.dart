import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_layout.dart';
import '../../shared/componants/componants.dart';
import '../../shared/componants/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../register/register_screen.dart';
import 'cubit/shoplogincubit.dart';
import 'cubit/shoploginstates.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();

  var passwordController=TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state)
        {
          if (state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              token=state.loginModel.data!.token;
              CacheHelper.saveData(
                key: "token",
                value: state.loginModel.data!.token,
              ).then((value)
              {

                navigateAndFinish(context,ShopLayoutScreen());
              });

              showToast(
                  text: state.loginModel.message!,
                  state:ToastStates.success
              );
            }else
            {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message!,
                state:ToastStates.error,
              );
            }
          }
        },
        builder:(context,state)
        {
          return Scaffold(
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
                          "LOGIN",
                          style:Theme.of(context).textTheme.headline5?.copyWith(color:Colors.black,fontWeight:FontWeight.w900),
                        ),
                        const SizedBox(
                          height:10.0,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(color:Colors.grey,fontWeight:FontWeight.w900),
                        ),
                        const SizedBox(
                          height:30.0,
                        ),
                        defultFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator:(String?value){
                            if(value!.isEmpty)
                            {
                              return "Please Enter Your Email Address";
                            }
                            return null;
                          },
                          prefix:Icons.email_outlined,
                          text:"EmailAddress",
                        ),
                        const SizedBox(
                          height:20.0,
                        ),
                        defultFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator:(String?value){
                            if(value!.isEmpty)
                            {
                              return "Password Is Too Short";
                            }
                            return null;
                          },
                          prefix:Icons.lock,
                          text:"Password",
                          isPassword:ShopLoginCubit.get(context).isPassword,
                          suffix:ShopLoginCubit.get(context).suffix,
                          onPressed:()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height:20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! ShopLoginErrorState,
                          builder:(context)=>defultButton(
                            function:()
                            {
                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email:emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text:"login",
                            height:40.0,
                            color:primarySwitchColor,
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()),

                        ),
                        const SizedBox(
                          height:20.0,
                        ),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:[
                            Text(
                              "don't have an account ?",
                              style:Theme.of(context).textTheme.bodyText1,
                            ),
                            defultTextButton(
                              function:()
                              {
                                navigateTo(context,RegisterScreen());
                              },
                              text:'REGISTER',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

