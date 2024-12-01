import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thera/src/core/router/go_route.dart';
import 'package:thera/src/features/home/domain/book.dart';


class BookOverviewScreen extends StatelessWidget {
  final Book book;

  const BookOverviewScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      floatingActionButton: Consumer(
        builder: (_, WidgetRef ref, __) {
          return ElevatedButton.icon(
            onPressed: () {
              ref
                  .read(goRouterProvider)
                  .pushNamed("read-book", extra: book.downloadLink);
            },
            label: const Text("Read")
                .paddingSymmetric(horizontal: 16, vertical: 16),
            icon: const Icon(Icons.book),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.network(
                  book.coverLink,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Author: ${book.author}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Genre: ${book.category}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const Text("Level: easy", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            Text("الوصف: \n ${book.description}",
                textDirection: TextDirection.rtl, style: context.bodyLarge),
          ],
        ),
      ),
    );
  }
}
