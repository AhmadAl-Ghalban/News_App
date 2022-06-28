abstract class NewsStates{}


class NewsInitialState extends NewsStates{}


class NewsBottomNavState extends NewsStates{}
class ChangeBottomNAvBArState extends NewsStates{}
class NewsLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{

final String error;

  NewsGetBusinessErrorState(this.error);

}
class NewsGetSportSuccessState extends NewsStates{}
class NewsGetSportLoadingState extends NewsStates{}

class NewsGetSportErrorState extends NewsStates{

final String error;

  NewsGetSportErrorState(this.error);

}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{

final String error;

  NewsGetScienceErrorState(this.error);
}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{

final String error;

  NewsGetSearchErrorState(this.error);
}
abstract class ThemeStatus {

}
class ThemeInitialState extends ThemeStatus{}

class NewsThemeModeState extends ThemeStatus{}

