import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/models/products_model.dart';
import '../../../data/models/search_product_model.dart';
import '../../../data/services/connectivity_repository.dart';
import '../../../data/services/search_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ConnectivityRepository connectivityRepository;
  SearchRepository searchRepository;
  SearchBloc({
    required this.connectivityRepository,
    required this.searchRepository,
  }) : super(SearchLoadingState()) {
    //===============Connectivity checking portion================
    //------------------------------------------------------------
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(SearchConnectionErrorEvent());
      } else {
        add(const SearchProductEvent(''));
      }
    });
    on<SearchProductEvent>((event, emit) async {
      if (state is SearchLoadingState ||
          state is SearchLoadedState ||
          state is SearchConnectionErrorState ||
          state is SearchFailureState) {
        emit(SearchLoadingState());
        try {
          final response =
              await searchRepository.getSearchByKeyword(event.keyword);
          SearchProductModel _searchProductModel =
              SearchProductModel.fromJson(response.data);
          emit(SearchLoadedState(products: _searchProductModel.products ?? []));
        } on DioError catch (e) {
          emit(SearchFailureState(errorString: e.message));
        }
      }
    });
    on<SearchConnectionErrorEvent>((event, emit) {
      if (state is SearchLoadingState ||
          state is SearchLoadedState ||
          state is SearchConnectionErrorState ||
          state is SearchFailureState) {
        emit(SearchConnectionErrorState());
      }
    });
  }
}
