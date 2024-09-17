import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../app_data_state/app_disconnect_view.dart';

class AppOfflineHandler extends StatefulWidget {
  final Widget child;

  const AppOfflineHandler({
    super.key,
    required this.child,
  });

  @override
  State<AppOfflineHandler> createState() => _AppOfflineHandlerState();
}

class _AppOfflineHandlerState extends State<AppOfflineHandler> {
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.mobile)) {
          isConnected = true;
        } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
          isConnected = true;
        } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
          isConnected = true;
        } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
          isConnected = true;
        } else if (connectivityResult.contains(ConnectivityResult.none)) {
          isConnected = false;
        } else {
          isConnected = false;
        }

        setState(() {});
      },
    );
    return Scaffold(
      body: isConnected ? widget.child : const AppDisconnectView(),
    );
  }
}
