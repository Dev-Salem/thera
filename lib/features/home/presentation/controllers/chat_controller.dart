import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thera/features/home/data/home_repository.dart';
import 'package:thera/features/home/domain/message.dart';
import 'package:uuid/uuid.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  @override
  Future<List<Message>> build() async {
    state = const AsyncValue.loading();
    final message = await ref.watch(homeRepositoryProvider).getWritingPrompt();
    return [message];
  }

  void addUserMessage(String content) {
    state = const AsyncValue.loading();
    final newMessage = Message(
      id: const Uuid().v4(),
      content: content,
      isUserGenerated: true,
    );

    state = AsyncValue.data([...?state.value, newMessage]);
    _getAiResponse(content); // Placeholder for AI response
  }

  Future<void> _getAiResponse(String userWriting) async {
    final aiResponse =
        await ref.watch(homeRepositoryProvider).getWritingFeedback(userWriting);
    state = AsyncValue.data([...?state.value, aiResponse]);
  }
}
