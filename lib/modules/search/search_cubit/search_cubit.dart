import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/modules/search/search_cubit/search_states.dart';
import '../../../models/search_model/search_model.dart';
import '../../../shared/componants/constant.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel?searchModel;
  
  void postSearchData(String?text)
  {
    emit(SearchGetLoadingState());
    DioHelper.postData(
        url: search,
        data:{
          "text":text,
        },
      token:token,
    ).then((value)
    {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchGetSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchGetErrorState(error.toString()));
    });
  }


}