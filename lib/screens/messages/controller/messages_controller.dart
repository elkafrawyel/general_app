import 'package:get/get.dart';

class MessagesController extends GetxController {
  List<String> messages = [
    'A1',
    'A2',
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
  ];

  addMessage(String message) {
    messages.add(message);
    update();
  }
}
