
import 'package:clientapp/domain/model/model_chat.dart';
import 'package:flutter/material.dart';

class widget_chat_buuble extends StatelessWidget {
  final model_chat data;
  final VoidCallback ReplyMessage;
  final VoidCallback deleteMessage;
  const widget_chat_buuble(
      {super.key,
      required this.data,
      required this.deleteMessage,
      required this.ReplyMessage});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
