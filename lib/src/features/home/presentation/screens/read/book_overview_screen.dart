import 'package:flutter/material.dart';

class BookOverviewScreen extends StatelessWidget {
  final Map<String, String> book;

  const BookOverviewScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book["title"]!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book["cover"]!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book["title"]!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Author: John Doe", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Genre: ${book["genre"]!}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Level: ${book["level"]!}",
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "This is a placeholder description for the book. Add your own description here.",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add read action here
                },
                child: const Text("Read"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
