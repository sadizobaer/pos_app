import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dorkar/data/models/category_model.dart';
import 'package:dorkar/data/models/products_model.dart';
import 'package:dorkar/data/services/connectivity_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/services/home_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;
  ConnectivityRepository connectivityRepository;
  HomeBloc({required this.connectivityRepository, required this.repository})
      : super(HomeLoadingState()) {
    //===============Connectivity checking portion================
    //------------------------------------------------------------
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(HomeConnectionErrorEvent());
      } else {
        add(HomeCategoryProductsEvent());
      }
    });

    //==================Event portion==================
    //-------------------------------------------------
    on<HomeCategoryProductsEvent>((event, emit) async {

      if (state is HomeLoadingState || state is HomeLoadedState) {
        try {
          final response = await repository.getAllCategories();
          final responseProducts = await repository.getAllProducts();

          CategoryModel _categoryModel = CategoryModel.fromJson(response.data);
          ProductsModel _productsModel =
              ProductsModel.fromJson(responseProducts.data);
          int itemsPerPage = 10;
          List<List<CategoryData>> categoryPerPageList = [];
          List<List<Products>> productPerPageList = [];

          for (var i = 0; i < _categoryModel.data!.length; i += itemsPerPage) {
            categoryPerPageList.add(
              _categoryModel.data!.sublist(
                i,
                i + itemsPerPage > _categoryModel.data!.length
                    ? _categoryModel.data!.length
                    : i + itemsPerPage,
              ),
            );
          }
          for (var i = 0; i < _productsModel.data!.length; i += itemsPerPage) {
            productPerPageList.add(
              _productsModel.data!.sublist(
                i,
                i + itemsPerPage > _productsModel.data!.length
                    ? _productsModel.data!.length
                    : i + itemsPerPage,
              ),
            );
          }
          emit(HomeLoadedState(categoryPerPageList, productPerPageList));
        } on DioError catch (e) {
          emit(HomeFailureState(errorString: e.message));
        }
      }
      // TODO: implement event handler
    });

    on<HomeConnectionErrorEvent>((event, emit) {
      // TODO: implement event handler
      emit(HomeConnectionErrorState());
    });
  }
}
