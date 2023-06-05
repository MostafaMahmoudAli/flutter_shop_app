import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/favourites_model/favourites_model.dart';
import '../../shared/componants/componants.dart';
import '../../shared/cubit/shopcubit.dart';
import '../../shared/cubit/shopstates.dart';
import '../../shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ShopCubit.get(context).getFavouritesData();

    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          return ListView.separated(
            physics:const BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildFavouritesItem(ShopCubit.get(context).favouritesModel!.data!.data![index],context),
              separatorBuilder:(context,index)=>myDivider(),
              itemCount:ShopCubit.get(context).favouritesModel!.data!.data!.length,
          );
        },
    );
  }
}

Widget buildFavouritesItem(DataFavModel model , BuildContext context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:[
        Stack(
          alignment:AlignmentDirectional.bottomStart,
          children:[
            Image(
              image:NetworkImage(model.product!.image!),
              height:120.0,
              width: 120.0,
            ),
            if(model.product!.discount !=0)Container(
              padding:EdgeInsets.symmetric(
                horizontal:5.0,
              ),
              color:Colors.red,
              child:Text(
                'Discount',
                style:TextStyle(
                  color:Colors.white,
                  fontSize:10.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width:10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(
               model.product!.name!,
                maxLines:2,
                overflow:TextOverflow.ellipsis,
                style:TextStyle(
                  fontSize:18.0,
                  fontWeight:FontWeight.bold,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price.toString(),
                    style:TextStyle(
                      fontSize:16.0,
                      fontWeight:FontWeight.w600,
                      color:primarySwitchColor,
                    ),
                  ),
                  const SizedBox(width:5.0,),

                  if (model.product!.oldPrice!=0)Text(
                    model.product!.oldPrice.toString(),
                    style:TextStyle(
                      fontSize:16.0,
                      fontWeight:FontWeight.w600,
                      color:Colors.grey,
                      decoration:TextDecoration.lineThrough,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius:20.0,
                    backgroundColor:ShopCubit.get(context).favourites[model.product!.id]! ? primarySwitchColor : Colors.grey,
                    child: IconButton(
                      onPressed:()
                      {
                        ShopCubit.get(context).changeFavourites(model.product!.id);
                      },
                      icon:Icon(
                        Icons.favorite_outline_outlined,
                        color:Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
