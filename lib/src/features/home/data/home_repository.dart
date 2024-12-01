// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mistralai_client_dart/mistralai_client_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:thera/src/core/env/env.dart';
import 'package:thera/src/features/home/domain/message.dart';
import 'package:uuid/uuid.dart';
part 'home_repository.g.dart';

class HomeRepository {
  final MistralAIClient client;
  HomeRepository({
    required this.client,
  });

  Future<Message> getWritingPrompt() async {
    const prompt =
        "Generate an interesting writing prompt in Arabic for someone who wants to practice writing, the prompt should consist of at least 4 sub questions";
    final response = await client.chatComplete(
        request: const ChatCompletionRequest(
      model: "mistral-small-latest",
      messages: [UserMessage(content: UserMessageContent.string(prompt))],
    ));

    return Message(
        id: const Uuid().v4(),
        content: response.choices!.first.message.content!,
        isUserGenerated: false);
  }

  Future<Message> getWritingFeedback(String userWriting) async {
    final prompt =
        "You will be provided with text in Arabic from someone who wants to practice writing in Arabic, provide feedback on the spelling, grammar and general structure of the text\n$userWriting:";
    final response = await client.chatComplete(
        request: ChatCompletionRequest(
      model: "mistral-small-latest",
      messages: [UserMessage(content: UserMessageContent.string(prompt))],
    ));

    return Message(
        id: const Uuid().v4(),
        content: response.choices!.first.message.content!,
        isUserGenerated: false);
  }
}

@riverpod
MistralAIClient mistralClient(Ref ref) {
  return MistralAIClient(apiKey: Env.mistralApi);
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(client: ref.watch(mistralClientProvider));
}
