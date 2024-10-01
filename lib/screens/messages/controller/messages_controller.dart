import 'package:general_app/config/clients/api/api_result.dart';
import 'package:general_app/controller/general_controller.dart';

class MessagesController extends GeneralController {
  List<String> messages = [];

  @override
  onInit() {
    super.onInit();
    loadMessages();
  }

  Future loadMessages() async {
    apiResult = const ApiLoading();
    await Future.delayed(const Duration(seconds: 3));
    messages.addAll([
      'A1',
      'A2',
      'A3',
      'A4',
      'A5',
      'A6',
      'A7',
      'A8',
    ]);
    apiResult = ApiSuccess(messages);
  }

  addMessage(String message) {
    messages.add(message);
    update();
  }

  @override
  Future<void> refreshApiCall() async {
    loadMessages();
  }
}
