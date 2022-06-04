part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeCategoryProductsEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeConnectionErrorEvent extends HomeEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
