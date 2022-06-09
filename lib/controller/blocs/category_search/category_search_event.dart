part of 'category_search_bloc.dart';

abstract class CategorySearchEvent extends Equatable {
  const CategorySearchEvent();
}

class CategorySearchProductEvent extends CategorySearchEvent {
  final String keyword;
  const CategorySearchProductEvent(this.keyword);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class CategorySearchConnectionErrorEvent extends CategorySearchEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
