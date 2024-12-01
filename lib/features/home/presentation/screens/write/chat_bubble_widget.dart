import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:thera/features/home/domain/message.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    required this.message,
    required this.currentUserId,
    super.key,
  });
  final Message message;
  final String currentUserId;
  @override
  Widget build(BuildContext context) {
    final children = [
      Container(
        constraints: const BoxConstraints(
          maxWidth: 250,
        ),
        padding: const EdgeInsets.all(5),
        child: Text(message.content),
      ),
    ];
    return message.isUserGenerated
        ? _SenderBubble(
            children: children,
          )
        : _ReceiverBubble(
            children: children,
          );
  }
}

class _SenderBubble extends StatelessWidget {
  const _SenderBubble({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Bubble(
      color: Colors.black45,
      radius: const Radius.circular(10),
      alignment: AlignmentDirectional.centerEnd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}

class _ReceiverBubble extends StatelessWidget {
  const _ReceiverBubble({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Bubble(
      color: Colors.white24,
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}
