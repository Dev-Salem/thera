import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thera/core/router/go_route.dart';
import 'package:thera/features/home/presentation/controllers/book_controller.dart';
import 'package:thera/features/home/presentation/screens/home_screen.dart';
import 'package:thera/features/home/presentation/screens/read/book_overview_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FiltersBottomSheet extends StatelessWidget {
  final String selectedGenre;
  final String selectedLevel;
  final Function(String, String) onApplyFilters;

  const FiltersBottomSheet({
    super.key,
    required this.selectedGenre,
    required this.selectedLevel,
    required this.onApplyFilters,
  });

  @override
  Widget build(BuildContext context) {
    List<String> genres = ["All", "Fiction", "Science", "History"];
    List<String> levels = ["All", "Beginner", "Intermediate", "Advanced"];

    String tempGenre = selectedGenre;
    String tempLevel = selectedLevel;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Filter by Genre",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Wrap(
            spacing: 8,
            children: genres.map((genre) {
              return ChoiceChip(
                label: Text(genre),
                selected: tempGenre == genre,
                onSelected: (selected) {
                  tempGenre = genre;
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            "Filter by Level",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Wrap(
            spacing: 8,
            children: levels.map((level) {
              return ChoiceChip(
                label: Text(level),
                selected: tempLevel == level,
                onSelected: (selected) {
                  tempLevel = level;
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                onApplyFilters(tempGenre, tempLevel);
              },
              child: const Text("Apply Filters"),
            ),
          ),
        ],
      ),
    );
  }
}

class BookGridScreen extends ConsumerStatefulWidget {
  const BookGridScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookGridScreenState();
}

class _BookGridScreenState extends ConsumerState<BookGridScreen> {
  String selectedGenre = "All";
  String selectedLevel = "All";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final booksNotifier = ref.watch(BooksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              showModalBottomSheet(
                context: context,
                builder: (context) => FiltersBottomSheet(
                  selectedGenre: selectedGenre,
                  selectedLevel: selectedLevel,
                  onApplyFilters: (genre, level) {
                    setState(() {
                      selectedGenre = genre;
                      selectedLevel = level;
                    });
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: booksNotifier.when(
          data: (books) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            BookOverviewScreen(bookId: book.name)));
                    // ref
                    //     .read(goRouterProvider)
                    //     .pushNamed("read", pathParameters: {"bookId": book.id});
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: WebsafeSvg.network(book.coverLink,
                            fit: BoxFit.fill,
                            placeholderBuilder: (context) => const SizedBox(
                                  height: 100,
                                  width: 150,
                                  child: CircularProgressIndicator.adaptive(),
                                )),
                      )),
                      const SizedBox(height: 8),
                      Text(
                        book.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(book.category),
                    ],
                  ),
                );
              },
            );
          },
          error: (e, s) {
            print(e);
            print(s);
            return const Text("Something went wrong").toCenter();
          },
          loading: () => const CircularProgressIndicator.adaptive().toCenter(),
        ),
      ),
    );
  }
}
