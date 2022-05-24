import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dorkar/data/services/connectivity_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/services/home_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  final ConnectivityRepository connectivityRepository;
  HomeBloc({required this.connectivityRepository, required this.repository})
      : super(HomeLoadingState()) {
    //===============Connectivity checking portion================
    //------------------------------------------------------------
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(HomeConnectionErrorEvent());
      }
    });

    //==================Event portion==================
    //-------------------------------------------------
    on<HomeCategoryEvent>((event, emit) {
      // TODO: implement event handler
      try{
        final response = repository.getAllCategories();
      } on DioError catch(e){
        emit(HomeFailureState(errorString: e.message));
      }
    });

    on<HomeCategoryEvent>((event, emit) {
      // TODO: implement event handler
      emit(HomeConnectionErrorState());
    });
  }
}
