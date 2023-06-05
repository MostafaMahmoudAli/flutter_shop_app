import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData theme = ThemeData(
  fontFamily:"Roboto",
  primarySwatch:primarySwitchColor,
  scaffoldBackgroundColor:lightColor,
  appBarTheme:AppBarTheme(
    elevation:0.0,
    backwardsCompatibility:false,
    backgroundColor:lightColor,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:lightColor,
      statusBarIconBrightness:Brightness.dark,
      statusBarBrightness:Brightness.dark,
    ),
    titleTextStyle:TextStyle(
      color:Colors.black,
      fontSize:30.0,
      fontWeight:FontWeight.bold,
    ),
    iconTheme:IconThemeData(
      color:Colors.black,
      size:30.0,
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor:lightColor,
    elevation:30.0,
    selectedItemColor:primarySwitchColor,
    unselectedItemColor: Colors.grey,
    type:BottomNavigationBarType.fixed,
  ),
  textTheme:const TextTheme(
    headline6:TextStyle(
      color:Colors.black,
      fontSize:22.0,
      fontWeight:FontWeight.bold,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily:"Roboto",
  primarySwatch:primarySwitchColor,
  scaffoldBackgroundColor:darkColor,
  appBarTheme:AppBarTheme(
    elevation:0.0,
    backgroundColor:darkColor,
    backwardsCompatibility:false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:darkColor,
      statusBarIconBrightness:Brightness.light,
      statusBarBrightness:Brightness.light,
    ),
    titleTextStyle:TextStyle(
      color:Colors.white,
      fontSize:30.0,
      fontWeight:FontWeight.bold,
    ),
    iconTheme:IconThemeData(
      color:Colors.white,
      size:30.0,
    ),
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor:darkColor,
    elevation:30.0,
    selectedItemColor:primarySwitchColor,
    unselectedItemColor: Colors.grey,
    type:BottomNavigationBarType.fixed,
  ),
  textTheme:const TextTheme(
    headline6:TextStyle(
      color:Colors.white,
      fontSize:22.0,
      fontWeight:FontWeight.bold,
    ),
  ),
);