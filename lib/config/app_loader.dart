import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoader {
  static loading() => EasyLoading.show(
        dismissOnTap: false,
      );

  static dismiss() => EasyLoading.dismiss();
}
