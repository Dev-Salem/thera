import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/features/home/presentation/controllers/chat_controller.dart';

class ChatMessagesWidget extends ConsumerWidget {
  const ChatMessagesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatControllerProvider);

    return chatState.when(
      data: (messages) => ListView.builder(
        reverse: true, // New messages appear at the bottom
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[messages.length - 1 - index];
          return Align(
            alignment: message.isUserGenerated
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUserGenerated
                    ? Colors.green[100]
                    : Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.content,
                textDirection: TextDirection.rtl,
              ),
            ),
          );
        },
      ),
      loading: () => const Column(
        children: [
          Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
          Text("AI is typing..."),
        ],
      ),
      error: (e, s) => Center(
        child: Text("Something went wrong: $e"),
      ),
    );
  }
}

class ChatInputWidget extends ConsumerStatefulWidget {
  const ChatInputWidget({super.key});

  @override
  ConsumerState<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends ConsumerState<ChatInputWidget> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isNotEmpty) {
      ref.read(chatControllerProvider.notifier).addUserMessage(content);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
      ),
      body: const Column(
        children: [
          
          Expanded(
            child: ChatMessagesWidget(),
          ),
          ChatInputWidget(),
        ],
      ),
    );
  }
}
