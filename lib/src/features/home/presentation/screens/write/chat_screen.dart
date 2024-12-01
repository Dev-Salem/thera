import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/src/features/home/presentation/controllers/chat_controller.dart';

class ChatMessagesWidget extends ConsumerWidget {
  const ChatMessagesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatControllerProvider);
    return messages.when(
        data: (messages) {
          return ListView.builder(
            reverse: false, // New messages appear at the bottom
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Align(
                alignment: message.isUserGenerated
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUserGenerated
                        ? Colors.grey[300]
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(message.content),
                ),
              );
            },
          );
        },
        error: (e, s) => Scaffold(
              body: const Text("something went wrong").toCenter(),
            ),
        loading: () => Scaffold(
              body: const CircularProgressIndicator.adaptive().toCenter(),
            ));
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
