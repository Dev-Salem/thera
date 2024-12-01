import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text(
          "Total Progress",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Card(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProgressStat(label: "23 Hours", subLabel: "Reading"),
              ProgressStat(label: "10 Hours", subLabel: "Listening"),
              ProgressStat(label: "50 Pages", subLabel: "Writing"),
              ProgressStat(label: "3 Hours", subLabel: "Speaking"),
            ],
          ).paddingAll(12),
        ),
        const SizedBox(height: 16),
        const Text(
          "Today's Progress",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Column(
          children: [
            ProgressBar(label: "Reading", value: 1.0),
            ProgressBar(label: "Listening", value: 0.85),
            ProgressBar(label: "Writing", value: 0.7),
            ProgressBar(label: "Speaking", value: 0.4),
          ],
        ),
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final String label;
  final double value;

  const ProgressBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class ProgressStat extends StatelessWidget {
  final String label;
  final String subLabel;

  const ProgressStat({super.key, required this.label, required this.subLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          subLabel,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}