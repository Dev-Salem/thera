import 'dart:convert';

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final bool isUserGenerated;
  const Message({
    required this.id,
    required this.content,
    required this.isUserGenerated,
  });

  Message copyWith({
    String? id,
    String? content,
    bool? isUserGenerated,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      isUserGenerated: isUserGenerated ?? this.isUserGenerated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isUserGenerated': isUserGenerated,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      content: map['content'] as String,
      isUserGenerated: map['isUserGenerated'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, content, isUserGenerated];
}
