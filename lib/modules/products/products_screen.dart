
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model/categories_model.dart';
import '../../models/home_model/home_model.dart';
import '../../shared/componants/componants.dart';
import '../../shared/cubit/shopcubit.dart';
import '../../shared/cubit/shopstates.dart';
import '../../shared/styles/colors.dart';


class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    cubit.getHomeData();
    cubit.getCategoriesData();

    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state)
      {
        if (state is ShopSuccessChangeFavouritesState)
        {
          if(!state.model.status!)
          {
            showToast(
              text: state.model.massage!,
              state:ToastStates.error,
            );
          }
        }
      },
      builder:  (context,state)
      {
        return state is ShopLoadingHomaDataState ?
        const Center(child: CircularProgressIndicator()) : productsBuilder(cubit.homeModel!,cubit.categoriesModel!,context);
      },
    );
  }
}

Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel,BuildContext context)=>SingleChildScrollView(
  physics:const BouncingScrollPhysics(),
  child:   Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items:model.data?.banners.map((e) =>Image(
              image: NetworkImage("${e.image}"),
             width:double.infinity,
            fit: BoxFit.cover,
          ),
          ).toList(),
          options: CarouselOptions(
             height:250.0,
            initialPage:0,
            scrollDirection:Axis.horizontal,
            viewportFraction:1.0,
            enableInfiniteScroll:true,
            reverse:false,
            autoPlayAnimationDuration:const Duration(seconds:1),
            autoPlayInterval:const Duration(seconds: 3),
            autoPlay:true,
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
      ),
     const SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal:10.0,
        ),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text(
              "Categories",
              style:TextStyle(
                fontSize:24.0,
                fontWeight:FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              height:100.0,
              child: ListView.separated(
                physics:const BouncingScrollPhysics(),
                  scrollDirection:Axis.horizontal,
                  itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data!.data[index], context),
                  separatorBuilder: (context,index)=>const SizedBox(
                    width:10.0,
                  ),
                  itemCount: categoriesModel.data!.data.length),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "New Products",
              style:TextStyle(
                fontSize:24.0,
                fontWeight:FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        color:Colors.grey[300],
        child: GridView.count(
            crossAxisCount: 2,
          shrinkWrap: true,
          physics:const NeverScrollableScrollPhysics(),
          mainAxisSpacing:1.0,
          crossAxisSpacing:1.0,
          childAspectRatio: 1/58,
          children:List.generate(
            model.data!.products.length,
                (index) =>buildGridProduct(model.data!.products[index],context),
          ),
        ),
      ),
    ],
  ),
);

Widget buildGridProduct(ProductsModel model,BuildContext context)
=>Column(
  crossAxisAlignment:CrossAxisAlignment.start,
  children: [
    Stack(
      alignment:AlignmentDirectional.bottomStart,
      children:[
        Image(
        image:NetworkImage(model.image!),
        width: double.infinity,
      ),
        if(model.discount!=0)Container(
          padding:const EdgeInsets.symmetric(
            horizontal:5.0,
          ),
          color:Colors.red,
          child: Text(
            "Discount",
            style:TextStyle(
              color:Colors.white,
              fontSize:10.0,
            ),
          ),
        ),

      ] ,
    ),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(
            model.name!,
            maxLines: 2,
            overflow:TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                "${model.price}",
                style:const TextStyle(
                  fontSize:12.0,
                  color:Colors.deepOrange,
                ),
              ),
              const SizedBox(
                width:5.0,
              ),
              if(model.discount!=0) Text(
                "${model.oldPrice}",
                style:const TextStyle(
                  color: Colors.black,
                  decoration:TextDecoration.lineThrough,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius:20.0,
                backgroundColor:ShopCubit.get(context).favourites[model.id]! ? primarySwitchColor:Colors.grey,
                child: IconButton(
                  onPressed:()
                  {
                    ShopCubit.get(context).changeFavourites(model.id);
                  },
                  icon:const Icon(
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
);

Widget buildCategoriesItem(DataModel model, BuildContext context)=>Stack(
  alignment:AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage(
        model.image!,
      ),
      width:100.0,
      height:100.0,
    ),
    Container(
      color:Colors.black.withOpacity(0.8),
      width:100.0,
      child: Text(
        model.name!,
        textAlign:TextAlign.center,
        maxLines:1,
        overflow:TextOverflow.ellipsis,
        style:TextStyle(
          color:Colors.white,
          fontWeight:FontWeight.w800,
        ),
      ),
    ),

  ],
);