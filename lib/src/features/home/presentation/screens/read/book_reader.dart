import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:timer_count_down/timer_count_down.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PdfReaderScreen extends StatefulWidget {
  final String pdfUrl; // URL or file path of the PDF
  const PdfReaderScreen({super.key, required this.pdfUrl});

  @override
  _PdfReaderScreenState createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool isTimerRunning = true;

  @override
  void dispose() {
    super.dispose();
    isTimerRunning = false; // Stops the timer when user leaves the screen
  }

  Future<Map<String, dynamic>> fetchWordDefinition(String word) async {
    try {
      final response = await http.get(
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)[0];
      } else {
        return {
          "word": word,
          "meanings": [
            {
              "definitions": [
                {"definition": "Definition not found."}
              ]
            }
          ],
        };
      }
    } catch (e) {
      return {
        "word": word,
        "meanings": [
          {
            "definitions": [
              {"definition": "An error occurred."}
            ]
          }
        ],
      };
    }
  }

  void showWordDefinition(String word) async {
    final definition = await fetchWordDefinition(word);

    // Show bottom sheet with word definition
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Word: ${definition['word']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ...List.generate(definition['meanings'].length, (index) {
                  final meaning = definition['meanings'][index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Part of Speech: ${meaning['partOfSpeech']}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      ...List.generate(meaning['definitions'].length, (i) {
                        return Text(
                            "- ${meaning['definitions'][i]['definition']}");
                      }),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Reader"),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer),
            onPressed: () {
              // Optionally reset timer or show timer info
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(
            widget.pdfUrl,
            key: _pdfViewerKey,
            onTextSelectionChanged: (details) {
              if (details.selectedText != null &&
                  details.selectedText!.trim().isNotEmpty) {
                showWordDefinition(details.selectedText!.trim());
              }
            },
          ),
          // Positioned(
          //   bottom: 20,
          //   right: 20,
          //   child: Countdown(
          //     seconds: 20 * 60, // 20 minutes
          //     build: (context, time) => FloatingActionButton.extended(
          //       onPressed: null,
          //       label: Text(
          //           "${(time / 60).floor()}:${(time % 60).toString().padLeft(2, '0')}"),
          //       icon: const Icon(Icons.timer),
          //     ),
          //     onFinished: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text("Time's up!")),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
