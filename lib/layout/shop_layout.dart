
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search/search_screen.dart';
import '../shared/componants/componants.dart';
import '../shared/cubit/shopcubit.dart';
import '../shared/cubit/shopstates.dart';

class ShopLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder:(context,state)
    {
      var cubit= ShopCubit.get(context);
      return Scaffold(
      appBar:AppBar(
      title:Text(
      "Salla",
      style:Theme.of(context).textTheme.headline4?.copyWith(
      fontWeight:FontWeight.bold,
      color:Colors.black,
      ),
      ),
      actions: [
      IconButton(
        onPressed:()
        {
          navigateTo(context, SearchScreen());
        },
      icon:Icon(
      Icons.search_rounded,
      ),
      ),
      ],
      ),
      body:cubit.bottomScreens[cubit.currentIndex],
      bottomNavigationBar:BottomNavigationBar(
      items:cubit.bottomNavigationBar,
        onTap:(index)
        {
          cubit.changeBottomNav(index);
        },
        currentIndex:cubit.currentIndex,

      ) ,
      );
    },

    );
  }
}
