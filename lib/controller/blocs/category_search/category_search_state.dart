part of 'category_search_bloc.dart';

abstract class CategorySearchState extends Equatable {
  const CategorySearchState();
}

class CategorySearchLoadingState extends CategorySearchState {
  @override
  List<Object> get props => [];
}

class CategorySearchLoadedState extends CategorySearchState {
  final List<List<Products>> productPerPageList;
  const CategorySearchLoadedState({required this.productPerPageList});
  @override
  List<Object> get props => [];
}

class CategorySearchConnectionErrorState extends CategorySearchState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategorySearchFailureState extends CategorySearchState {
  final String errorString;
  const CategorySearchFailureState({required this.errorString});
  @override
  // TODO: implement props
  List<Object?> get props => [errorString];
}
