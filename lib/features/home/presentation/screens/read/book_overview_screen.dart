import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thera/core/router/go_route.dart';
import 'package:thera/features/home/presentation/controllers/book_controller.dart';
import 'package:thera/features/home/presentation/screens/read/book_reader.dart';

class BookOverviewScreen extends ConsumerWidget {
  final String bookId;

  const BookOverviewScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(singleBookProviderProvider.call(bookId));
    return controller.when(
        data: (book) {
          return Scaffold(
            appBar: AppBar(
              title: Text(book.name),
            ),
            floatingActionButton: Consumer(
              builder: (_, WidgetRef ref, __) {
                return ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PdfReaderScreen(pdfUrl: book.downloadLink)));
                    // Navigator.of(context)
                    //     .pushNamed("/book", arguments: book.id);
                    // ref.read(goRouterProvider).pushNamed("read-book",
                    //     pathParameters: {"pdfUrl": book.downloadLink});
                  },
                  label: const Text("Read")
                      .paddingSymmetric(horizontal: 16, vertical: 16),
                  icon: const Icon(Icons.book),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
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
                      textDirection: TextDirection.rtl,
                      style: context.bodyLarge),
                ],
              ),
            ),
          );
        },
        error: (e, s) => Scaffold(
              body: const Text("Error").toCenter(),
            ),
        loading: () => const CircularProgressIndicator.adaptive().toCenter());
  }
}
