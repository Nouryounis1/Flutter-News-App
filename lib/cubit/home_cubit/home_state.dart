abstract class HomeStates {}

class HomeInitalState extends HomeStates {}

class NewsBottomNav extends HomeStates {}

class HomeIconsChanged extends HomeStates {}

class NewsGetEverythingSuccessState extends HomeStates {}

class NewsGetEverythingErrorState extends HomeStates {
  final String error;
  NewsGetEverythingErrorState(this.error);
}

class NewsGetEverythingLoadingState extends HomeStates {}

class NewsGetHeadlinesSuccessState extends HomeStates {}

class NewsGetHeadlinesErrorState extends HomeStates {
  final String error;
  NewsGetHeadlinesErrorState(this.error);
}

class NewsGetHeadlinesLoadingState extends HomeStates {}
