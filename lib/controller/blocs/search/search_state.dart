part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchConnectionErrorState extends SearchState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchFailureState extends SearchState{
  final String errorString;
  const SearchFailureState({required this.errorString});
  @override
  // TODO: implement props
  List<Object?> get props => [errorString];

}
