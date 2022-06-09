part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchProductEvent extends SearchEvent{
  final String keyword;
  const SearchProductEvent(this.keyword);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SearchConnectionErrorEvent extends SearchEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

