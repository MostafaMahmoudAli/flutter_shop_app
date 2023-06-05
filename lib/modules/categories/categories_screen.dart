import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model/categories_model.dart';
import '../../shared/componants/componants.dart';
import '../../shared/cubit/shopcubit.dart';
import '../../shared/cubit/shopstates.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    cubit.getCategoriesData();
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state)
        {
        return ListView.separated(
          physics:const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildCatItem(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder:  (context,index)=>myDivider(),
            itemCount: cubit.categoriesModel!.data!.data.length,
        );
        },

    );
  }
}

Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Image(
        image:NetworkImage(
          model.image!,
        ),
        width:80.0,
        height:80.0,
        fit:BoxFit.cover,
      ),
      Text(
        model.name!,
        style:TextStyle(
          fontSize:22.0,
          fontWeight:FontWeight.bold,
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: (){},
        icon:Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    ],
  ),
);
