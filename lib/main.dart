import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/shared/blocobserver.dart';
import 'package:flutter_shop_app/shared/componants/constant.dart';
import 'package:flutter_shop_app/shared/cubit/shopcubit.dart';
import 'package:flutter_shop_app/shared/network/local/cache_helper.dart';
import 'package:flutter_shop_app/shared/network/remote/dio_helper.dart';
import 'package:flutter_shop_app/shared/styles/themes.dart';
import 'layout/shop_layout.dart';
import 'modules/onboarding/onboarding_screen.dart';
import 'modules/shop_login/shop_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  token=CacheHelper.getData(key:"token");
  print(token);
  print(CacheHelper.getData(key:"onBoarding"));
  Widget widget;

  if(CacheHelper.getData(key:"onBoarding") != null && CacheHelper.getData(key:"onBoarding"))
  {
    if(token != null)
    {
      widget = ShopLayoutScreen();
    } else
    {
      widget = ShopLoginScreen();
    }

  } else
  {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>ShopCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner:false,
          theme:theme,
          darkTheme:darkTheme,
          themeMode:ThemeMode.light,
          home: startWidget,
        ),
    );
  }
}
