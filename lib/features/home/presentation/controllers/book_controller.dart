import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thera/features/home/domain/book.dart';
import 'package:uuid/uuid.dart';
part 'book_controller.g.dart';

Future<List<Book>> loadBooksWithIds(String filePath) async {
  final json = await rootBundle.loadString(filePath);
  final books = (jsonDecode(json) as List);
  final result = books.map((e) => Book.fromMap(e, const Uuid().v4())).toList();
  return result;
}

final BooksProvider = FutureProvider<List<Book>>((ref) async {
  return loadBooksWithIds("assets/books.json");
});

@riverpod
FutureOr<Book> singleBookProvider(Ref ref, String bookName) async {
  final books = await loadBooksWithIds("assets/books.json");
  return books.singleWhere((book) => book.name == bookName);
}
