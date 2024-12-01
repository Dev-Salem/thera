import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thera/src/features/home/domain/book.dart';
import 'package:uuid/uuid.dart';
part 'book_controller.g.dart';

@riverpod
class BooksController extends _$BooksController {
  @override
  FutureOr<List<Book>> build() {
    return loadBooksWithIds("assets/books.json");
  }

  Future<void> getBooks() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => loadBooksWithIds("assets/books.json"));
  }
}

Future<List<Book>> loadBooksWithIds(String filePath) async {
  final json = await rootBundle.loadString(filePath);
  final books = (jsonDecode(json) as List);
  final result = books.map((e) => Book.fromMap(e, const Uuid().v4())).toList();
  return result;
}
