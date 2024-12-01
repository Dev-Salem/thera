// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mistralai_client_dart/mistralai_client_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:thera/src/core/env/env.dart';
import 'package:thera/src/features/home/domain/message.dart';
part 'home_repository.g.dart';

class HomeRepository {
  final MistralAIClient client;
  HomeRepository({
    required this.client,
  });
  Future<Message> getWritingPrompot() async {
    const prompt =
        "Generate a detailed prompt in Arabic (in the form of a question, the question should have at least 5 sub questions) to make an Arabic learner practice writing, no explanation, just the prompt in Arabic.";
    final response = await client.chatComplete(
        request: const ChatCompletionRequest(
      model: "mistral-small-latest",
      messages: [prompt],
    ));
    print(response);
    return const Message(id: "id", content: "content", isUserGenerated: false);
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
