// import 'package:awesome_extensions/awesome_extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:thera/src/features/auth/data/auth_repository.dart';
// import 'package:thera/src/features/home/domain/message.dart';
// import 'package:thera/src/features/home/presentation/screens/write/chat_bubble_widget.dart';

// class ChatDetailsScreen extends ConsumerWidget {
//   const ChatDetailsScreen({
//     required this.requestId,
//     required this.senderId,
//     required this.receiverId,
//     super.key,
//   });
//   final String requestId;
//   final String senderId;
//   final String receiverId;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final messagesProvider = ref.watch(getChatMessagesProvider.call(requestId));
//     final currentUserId =
//         ref.watch(supabaseClientProvider).auth.currentUser!.id;
//     final otherUserId = currentUserId == senderId ? receiverId : senderId;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Write"),
//       ),
//       body: messagesProvider.when(
//         data: (messages) {
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   reverse: true,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                   ),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 5),
//                       child: ChatBubbleWidget(
//                         message: messages[index],
//                         currentUserId: currentUserId,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       suffix: IconButton(
//                           onPressed: () {
                            
//                           }, icon: const Icon(Icons.send))),
//                   validator: (p0) {
//                     if (p0 == null) {
//                       return null;
//                     }
//                     if (p0.isEmpty) {
//                       return "Too short";
//                     }
//                     if (p0.length > 255) {
//                       return "Too Long";
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//         error: (e, s) => ErrorResultWidget(
//           onRefresh: () =>
//               ref.refresh(getChatMessagesProvider.call(requestId).future),
//         ),
//         loading: () {
//           return const _LoadingChatWidget();
//         },
//       ),
//     );
//   }
// }

// class _LoadingChatWidget extends StatelessWidget {
//   const _LoadingChatWidget();

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 16,
//       ),
//       children: List.generate(10, (index) {
//         final message = Message(
//           id: 'id',
//           content: 'index' * 2,
//         );
//         return ChatBubbleWidget(
//           currentUserId: '$index',
//           message: message,
//         ).applyShimmer(
//           highlightColor: index.isEven ? Colors.black12 : Colors.grey[200],
//           baseColor: index.isEven ? Colors.black38 : Colors.grey,
//         );
//       }),
//     );
//   }
// }
