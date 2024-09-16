import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// This mixin can listen to incoming notification
mixin FCMNotificationMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<RemoteMessage> _subscription;

  @override
  void initState() {
    _subscription = FirebaseMessaging.onMessage.listen(_onNewNotify);
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  /// Will be called whenever a new notification come and app is in foreground
  void onNotify(RemoteMessage notification);

  void _onNewNotify(RemoteMessage notification) {
    if (mounted) onNotify(notification);
  }
}
