import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:general_app/config/helpers/date_helper.dart';
import 'package:general_app/config/theme/color_extension.dart';
import 'package:general_app/screens/chat_screen/data/message_model.dart';
import 'package:general_app/widgets/app_widgets/app_text.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel messageModel;
  const MessageBubble({
    super.key,
    required this.messageModel,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _showDate = false;

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.messageModel.isCurrentUser;
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isCurrentUser
            ? AlignmentDirectional.centerStart
            : AlignmentDirectional.centerEnd,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser ? context.kPrimaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                AppText(
                  text: widget.messageModel.title ?? '',
                  color: widget.messageModel.isCurrentUser
                      ? context.kColorOnPrimary
                      : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _showDate = !_showDate),
          child: BubbleSpecialThree(
            text: widget.messageModel.title ?? '',
            color: isCurrentUser
                ? context.kPrimaryColor
                : context.kHintTextColor.withValues(alpha: 0.3),
            tail: true,
            isSender: isCurrentUser,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Offstage(
          offstage: !_showDate,
          child: Align(
            alignment: isCurrentUser
                ? AlignmentDirectional.centerEnd
                : AlignmentDirectional.centerStart,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
              child: AppText(
                text: DateHelper()
                    .getTimeFromDateString(widget.messageModel.creationDate),
                color: context.kHintTextColor,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
