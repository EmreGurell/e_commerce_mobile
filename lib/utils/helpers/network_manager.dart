import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tarhanaciyasarmobil/common/widgets/loaders/loaders.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Bağlantı durumu değişikliklerini dinliyoruz
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    // İlk başta bağlantı durumu kontrolü yapıyoruz
    _checkInitialConnection();
  }

  void _checkInitialConnection() async {
    // İlk başta bağlantı durumunu kontrol et
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus.value = result;

    if (_connectionStatus.value == ConnectivityResult.none) {
      // Bağlantı yoksa sadece bir kere uyarı göster
      Loaders.warningSnackBar(title: 'İnternet Bağlantısı yok');
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (e) {
      // Platform hatalarını logla
      print("PlatformException: $e");
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Bağlantı dinleyicisini iptal et
    _connectivitySubscription.cancel();
  }
}
