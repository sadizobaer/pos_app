import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/models/category_search_product_model.dart';
import '../../../data/models/products_model.dart';
import '../../../data/services/connectivity_repository.dart';
import '../../../data/services/search_repository.dart';

part 'category_search_event.dart';
part 'category_search_state.dart';

class CategorySearchBloc
    extends Bloc<CategorySearchEvent, CategorySearchState> {
  ConnectivityRepository connectivityRepository;
  SearchRepository searchRepository;
  CategorySearchBloc({
    required this.connectivityRepository,
    required this.searchRepository,
  }) : super(CategorySearchLoadingState()) {
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(CategorySearchConnectionErrorEvent());
      } else {
        add(const CategorySearchProductEvent(''));
      }
    });
    on<CategorySearchProductEvent>((event, emit) async {
      if (state is CategorySearchLoadingState ||
          state is CategorySearchLoadedState ||
          state is CategorySearchConnectionErrorState ||
          state is CategorySearchFailureState) {

        emit(CategorySearchLoadingState());
        try {
          final response =
              await searchRepository.getSearchByCategory(event.keyword);
          CategorySearchProductModel _categorySearchProductModel =
              CategorySearchProductModel.fromJson(response.data);
          int itemsPerPage = 10;
          List<List<Products>> _productPerPageList = [];
          for (var i = 0;
              i < _categorySearchProductModel.data.length;
              i += itemsPerPage) {
            _productPerPageList.add(
              _categorySearchProductModel.data.sublist(
                i,
                i + itemsPerPage > _categorySearchProductModel.data.length
                    ? _categorySearchProductModel.data.length
                    : i + itemsPerPage,
              ),
            );
          }
          emit(
            CategorySearchLoadedState(productPerPageList: _productPerPageList),
          );
        } on DioError catch (e) {
          emit(CategorySearchFailureState(errorString: e.message));
        }
      }
    });

    on<CategorySearchConnectionErrorEvent>((event, emit) {
      if (state is CategorySearchLoadingState ||
          state is CategorySearchLoadedState ||
          state is CategorySearchConnectionErrorState ||
          state is CategorySearchFailureState) {
        emit(CategorySearchConnectionErrorState());
      }
    });
  }
}
