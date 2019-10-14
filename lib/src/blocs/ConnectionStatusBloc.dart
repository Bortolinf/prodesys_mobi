import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class ConnectionStatusBloc extends BlocBase {

    final _temNetController = BehaviorSubject<bool>();

    Stream<bool> get outtemNet => _temNetController.stream;

    bool temNet;

    //flutter_connectivity
    final Connectivity _connectivity = Connectivity();



    // construtor
    ConnectionStatusBloc(){
    //  bool temNet = false;
        _connectivity.onConnectivityChanged.listen(_connectionChange);
        checkConnection();
    }



    //flutter_connectivity's listener
    void _connectionChange(ConnectivityResult result) {
        checkConnection();
    }

    //The test to actually see if there is a connection
    Future<bool> checkConnection() async {
        bool previousConnection = temNet;
        try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                temNet = true;
            } else {
                temNet = false;
            }
        } on SocketException catch(_) {
            temNet = false;
        }

        //The connection status changed send out an update to all listeners
        if (previousConnection != temNet) {
            _temNetController.add(temNet);
        }
        return temNet;
    }


    @override
    void dispose() {
        _temNetController.close();
        super.dispose();    
    }


}