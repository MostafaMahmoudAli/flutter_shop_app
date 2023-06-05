abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class SearchGetLoadingState extends SearchStates{}

class SearchGetSuccessState extends SearchStates{}

class SearchGetErrorState extends SearchStates{
  final String error;
  SearchGetErrorState(this.error);
}