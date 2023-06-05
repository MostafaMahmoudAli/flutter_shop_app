import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/search/search_cubit/search_cubit.dart';
import 'package:flutter_shop_app/modules/search/search_cubit/search_states.dart';
import '../../models/search_model/search_model.dart';
import '../../shared/componants/componants.dart';
import '../../shared/cubit/shopcubit.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {

  var searchController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create:(BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener:(context,state){},
        builder:(context,state)
        {
          return Scaffold(
            appBar:AppBar(),
            body: Form(
              key:formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defultFormField(controller: searchController,
                      keyboardType: TextInputType.text,
                      validator:(String?value)
                      {
                        if(value!.isEmpty)
                        {
                          return "Please Put Your Search";
                        }
                        return null;
                      },
                      function:(String?text)
                      {
                        SearchCubit.get(context).postSearchData(text);
                      },
                      prefix: Icons.search_outlined,
                      text:"Search",
                    ),
                    const SizedBox(
                      height:10.0,
                    ),
                    if(state is SearchGetLoadingState)const LinearProgressIndicator(),
                    const SizedBox(
                      height:15.0,
                    ),
                    if(state is SearchGetSuccessState)Expanded(
                      child: ListView.separated(
                        itemBuilder:(context,index)=> buildSearchItem(SearchCubit.get(context).searchModel!.data!.data![index] , context),
                        separatorBuilder:(context,index)=>myDivider(),
                        itemCount:SearchCubit.get(context).searchModel!.data!.data!.length ,),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchItem(DataModel model,BuildContext context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:[
        Stack(
          alignment:AlignmentDirectional.bottomStart,
          children:[
            Image(
              image:NetworkImage(model.image!),
              height:120.0,
              width: 120.0,
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
                model.name!,
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
                    model.price.toString(),
                    style:TextStyle(
                      fontSize:16.0,
                      fontWeight:FontWeight.w600,
                      color:primarySwitchColor,
                    ),
                  ),
                  const SizedBox(width:5.0,),

                  const Spacer(),
                  CircleAvatar(
                    radius:20.0,
                    backgroundColor:ShopCubit.get(context).favourites[model.id]! ? primarySwitchColor : Colors.grey,
                    child: IconButton(
                      onPressed:()
                      {
                        ShopCubit.get(context).changeFavourites(model.id);
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
