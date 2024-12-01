import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PdfReaderScreen extends StatefulWidget {
  final String pdfUrl; // URL or file path of the PDF
  const PdfReaderScreen({super.key, required this.pdfUrl});

  @override
  _PdfReaderScreenState createState() => _PdfReaderScreenState();
}

class _PdfReaderScreenState extends State<PdfReaderScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late final CountdownController _countController;

  @override
  void initState() {
    _countController = CountdownController(autoStart: true);
    super.initState();
  }

  bool isTimerRunning = true;

  @override
  void dispose() {
    super.dispose();
    _countController.pause();
    isTimerRunning = false; // Stops the timer when user leaves the screen
  }

  Future<Map<String, dynamic>> fetchWordDefinition(String word) async {
    // const url = 'https://libretranslate.com/translate';
    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(
    //       {'q': word, 'source': 'ar', 'target': 'en', 'format': 'text'}),
    // );

    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   return {
    //     'word': word,
    //     'translation': data['translatedText'],
    //   };
    // } else {
    //   return {
    //     'word': word,
    //     'translation': 'Translation not found.',
    //   };
    // }
    return {
      'word': word,
      'translation': "معنى",
    };
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
              isTimerRunning = !isTimerRunning;
              if (isTimerRunning) {
                _countController.pause();
              } else {
                _countController.resume();
              }
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
          Positioned(
            bottom: 20,
            right: 20,
            child: Countdown(
              seconds: 20 * 60, // 20 minutes
              build: (context, time) => FloatingActionButton.extended(
                onPressed: null,
                label: Text(
                    "${(time / 60).floor()}:${(time % 60).toString().padLeft(2, '0')}"),
                icon: const Icon(Icons.timer),
              ),
              controller: _countController,
              onFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Time's up!")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
