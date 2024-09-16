import 'package:general_app/config/operation_reply.dart';
import 'package:general_app/controller/general_controller.dart';

class MessagesController extends GeneralController {
  List<String> messages = [];

  @override
  onInit() {
    super.onInit();
    loadMessages();
  }

  Future loadMessages() async {
    operationReply = OperationReply.loading();
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

    operationReply = OperationReply.success();
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
