import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/models/login_data_model.dart';
import '../../../data/services/connectivity_repository.dart';
import '../../../data/services/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ConnectivityRepository connectivityRepository;
  LoginRepository loginRepository;
  LoginBloc({
    required this.connectivityRepository,
    required this.loginRepository
  }) : super(LoginLoading()) {
    //===============Connectivity checking portion================
    //------------------------------------------------------------
    connectivityRepository.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(LoginConnectionErrorEvent());
      }
    });
    on<LoginWithEmailAndPassword>((event, emit) async{
      // TODO: implement event handler
      if (state is LoginLoading ||
          state is LoginLoaded ||
          state is LoginConnectionError ||
          state is LoginFailure) {
        emit(LoginLoading());
        try {
          final response =
              await loginRepository.getLoginWithEmailAndPassword(event.email, event.password);
          LoginDataModel _loginDataModel =
          LoginDataModel.fromJson(response.data);
          emit(LoginLoaded(loginDataModel: _loginDataModel));
        } on DioError catch (e) {
          emit(LoginFailure(errorString: e.message));
        }
      }
    });

    on<LoginConnectionErrorEvent>((event, emit) {
      if (state is LoginLoading ||
          state is LoginLoaded ||
          state is LoginConnectionError ||
          state is LoginFailure) {
        emit(LoginConnectionError());
      }
    });
  }
}
