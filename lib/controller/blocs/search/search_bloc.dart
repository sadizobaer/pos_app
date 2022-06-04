import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/services/connectivity_repository.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ConnectivityRepository connectivityRepository;
  SearchBloc({
    required this.connectivityRepository,
  }) : super(SearchLoadingState()) {
    //===============Connectivity checking portion================
    //------------------------------------------------------------
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(SearchConnectionErrorEvent());
      } else {
        //add();
      }
    });
    on<SearchProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
