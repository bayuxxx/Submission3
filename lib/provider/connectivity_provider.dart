import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isConnected = true;
  bool _isDisposed = false;

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (!_isDisposed) {
        _isConnected = result != ConnectivityResult.none;
        notifyListeners();
      }
    });

    updateConnectivityStatus();
  }

  Future<void> updateConnectivityStatus() async {
    if (!_isDisposed) {
      final result = await Connectivity().checkConnectivity();
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    }
  }

  void checkConnectivity() async {
    if (!_isDisposed) {
      final result = await Connectivity().checkConnectivity();
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    }
  }

  bool get isDisposed => _isDisposed;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
