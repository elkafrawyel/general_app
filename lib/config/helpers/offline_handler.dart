import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:general_app/config/helpers/logging_helper.dart';
import 'package:general_app/widgets/app_data_state/app_disconnect_view.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class OfflineHandler {
  static bool _dialogOpened = false;

  static handle() async {
    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.mobile)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.none)) {
          _showNoConnectionDialog();
        } else {
          _showNoConnectionDialog();
        }
      },
    );
  }

  static _hideGetXDialog() {
    if (_dialogOpened) {
      Get.back();
      _dialogOpened = false;
      AppLogger.log(
        'Your connection was established',
      );
    }
  }

  static _showNoConnectionDialog() {
    if (_dialogOpened) {
      return;
    }

    Get.dialog(
      const AppDisconnectView(),
      barrierDismissible: false,
    );
    _dialogOpened = true;
    AppLogger.log(
      'Your connection was lost',
      level: Level.error,
    );
  }
}
