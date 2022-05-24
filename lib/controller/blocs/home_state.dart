part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeConnectionErrorState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeFailureState extends HomeState{
  final String errorString;
  const HomeFailureState({required this.errorString});
  @override
  // TODO: implement props
  List<Object?> get props => [errorString];

}