// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qolbu/services/drawer_service.dart';

class ConnectivityService {
  static ConnectivityResult connectionStatus = ConnectivityResult.none;

  static init() async {
    connectionStatus = _connectionStatus(await Connectivity().checkConnectivity());
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      connectionStatus = _connectionStatus(result);
    });
  }

  /// Convert from the third part enum to our own enum
  static ConnectivityResult _connectionStatus(List<ConnectivityResult> result) {
    // This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
    if (result.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      return ConnectivityResult.mobile;
    } else if (result.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available.
      // Note for Android:
      // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
      return ConnectivityResult.wifi;
    } else if (result.contains(ConnectivityResult.ethernet)) {
      // Ethernet connection available.
      return ConnectivityResult.ethernet;
    } else if (result.contains(ConnectivityResult.vpn)) {
      // Vpn connection active.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      return ConnectivityResult.vpn;
    } else if (result.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
      return ConnectivityResult.bluetooth;
    } else if (result.contains(ConnectivityResult.other)) {
      // Connected to a network which is not in the above mentioned networks.
      return ConnectivityResult.other;
    } else {
      // No available network types
      return ConnectivityResult.none;
    }
  }

  static void initializeConnectivity({
    required Function() onConnected,
    Function()? onRetry,
  }) async {
    DrawerService.close();
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      DrawerService.showDrawer(title: "Tidak Ada Koneksi");
    } else {
      onConnected();
    }
  }
}
