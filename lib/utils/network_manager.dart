import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._();

  static NetworkManager getInstance() => _instance;

  NetworkManager._();

  Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      // Not connected to any network.
      return false;
    } else if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Connected to a mobile or Wi-Fi network.
      return true;
    }

    return false;
  }
}
