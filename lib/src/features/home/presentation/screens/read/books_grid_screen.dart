import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/src/core/router/go_route.dart';

class BookGridScreen extends StatefulWidget {
  const BookGridScreen({super.key});

  @override
  _BookGridScreenState createState() => _BookGridScreenState();
}

class _BookGridScreenState extends State<BookGridScreen> {
  String selectedGenre = "All";
  String selectedLevel = "All";

  final List<Map<String, String>> books = [
    {
      "title": "Book 1",
      "genre": "Fiction",
      "level": "Beginner",
      "cover": "https://via.placeholder.com/150",
    },
    {
      "title": "Book 2",
      "genre": "Science",
      "level": "Intermediate",
      "cover": "https://via.placeholder.com/150",
    },
    {
      "title": "Book 3",
      "genre": "History",
      "level": "Advanced",
      "cover": "https://via.placeholder.com/150",
    },
    {
      "title": "Book 4",
      "genre": "Fiction",
      "level": "Beginner",
      "cover": "https://via.placeholder.com/150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter books based on genre and level
    List<Map<String, String>> filteredBooks = books.where((book) {
      bool matchesGenre =
          selectedGenre == "All" || book["genre"] == selectedGenre;
      bool matchesLevel =
          selectedLevel == "All" || book["level"] == selectedLevel;
      return matchesGenre && matchesLevel;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Books"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemCount: filteredBooks.length,
          itemBuilder: (context, index) {
            final book = filteredBooks[index];
            return Consumer(
              builder: (_, WidgetRef ref, __) {
                return GestureDetector(
                  onTap: () {
                    ref.read(goRouterProvider).pushNamed("book", extra: book);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                              Image.network(book["cover"]!, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        book["title"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(book["genre"]!),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

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
