import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityRepository {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();
  ConnectivityRepository(){
    _connectivity.onConnectivityChanged.listen((event){
      connectivityStream.add(event);
    });
  }
}
