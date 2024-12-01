import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/features/home/data/home_repository.dart';

class ExtraContentCard extends ConsumerWidget {
  final String imageUrl;
  final String title;
  final String level;

  const ExtraContentCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.level,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () async {
        final home = ref.read(homeRepositoryProvider);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              alignment: Alignment.center,
              child: const Icon(Icons.image),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16)),
                  Text(level, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtraContentListView extends StatelessWidget {
  const ExtraContentListView({super.key});

  @override
  Widget build(BuildContext context) {
    final contentCards = [
      const ExtraContentCard(
          imageUrl:
              'https://via.placeholder.com/150', // Replace with an actual image URL
          title: "مسلسل يوسف",
          level: "متوسط"),
      const ExtraContentCard(
          imageUrl:
              'https://via.placeholder.com/150', // Replace with an actual image URL
          title: "مندوب الليل",
          level: "متقدم"),
    ];

    return SizedBox(
      height: 200, // Fixed height for extra content cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: contentCards.length,
        itemBuilder: (context, index) => Container(
          width: 8 * 20,
          padding: const EdgeInsets.only(right: 8.0),
          child: contentCards[index],
        ),
      ),
    );
  }
}
