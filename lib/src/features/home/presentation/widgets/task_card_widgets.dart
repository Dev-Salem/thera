import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thera/src/core/router/go_route.dart';

class TaskCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const TaskCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      const TaskCard(icon: Icons.headphones, label: "Listen"),
      const TaskCard(icon: Icons.book, label: "Read"),
      const TaskCard(icon: Icons.edit, label: "Write"),
      const TaskCard(icon: Icons.mic, label: "Speak"),
    ];

    return SizedBox(
      height: 160, // Fixed height for task cards
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tasks.length,
        itemBuilder: (context, index) => Consumer(
          builder: (_, WidgetRef ref, __) {
            return InkWell(
              onTap: () {
                ref
                    .read(goRouterProvider)
                    .pushNamed(tasks[index].label.toLowerCase());
              },
              child: Container(
                width: 8 * 20,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: tasks[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
