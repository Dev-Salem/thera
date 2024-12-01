import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CustomizePlanScreen extends StatefulWidget {
  const CustomizePlanScreen({super.key});

  @override
  State<CustomizePlanScreen> createState() => _CustomizePlanScreenState();
}

class _CustomizePlanScreenState extends State<CustomizePlanScreen> {
  final Map<String, Map<String, double>> plans = {
    "خطة الساعة": {
      "الاستماع (30 دقيقة)": 30,
      "القراءة (20 دقيقة)": 20,
      "الكتابة (5 دقائق)": 5,
      "المحادثة (5 دقائق)": 5,
    },
    "خطة الـ 30 دقيقة": {
      "الاستماع (15 دقيقة)": 15,
      "القراءة (10 دقائق)": 10,
      "الكتابة (3 دقائق)": 3,
      "المحادثة (2 دقيقة)": 2,
    },
    "خطة الساعتين": {
      "الاستماع (60 دقيقة)": 60,
      "القراءة (40 دقيقة)": 40,
      "الكتابة (10 دقائق)": 10,
      "المحادثة (10 دقائق)": 10,
    },
  };

  final List<String> availableInterests = [
    "الأخبار",
    "الطبيعة",
    "الخيال العلمي",
    "التاريخ",
    "التكنولوجيا",
    "الفن",
    "الموسيقى",
    "الرياضة",
    "السفر",
    "الصحة",
    "أسلوب الحياة",
  ];
  final List<String> selectedInterests = [];
  // Selected plan
  String selectedPlan = "خطة الساعة";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "اختر خطتك اليومية",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Toggle buttons for selecting the plan
                ToggleButtons(
                  isSelected:
                      plans.keys.map((key) => key == selectedPlan).toList(),
                  onPressed: (index) {
                    setState(() {
                      selectedPlan = plans.keys.elementAt(index);
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  constraints:
                      const BoxConstraints(minWidth: 100, minHeight: 40),
                  children: plans.keys
                      .map(
                        (plan) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(plan, textAlign: TextAlign.center),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                // Display the selected plan's pie chart
                Text(
                  selectedPlan,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                PieChart(
                  dataMap: plans[selectedPlan]!,
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: true,
                    legendPosition: LegendPosition.bottom,
                    legendTextStyle: TextStyle(fontSize: 12),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: true,
                    decimalPlaces: 0,
                  ),
                  colorList: const [
                    Colors.blue,
                    Colors.green,
                    Colors.orange,
                    Colors.purple,
                  ],
                ),
                const SizedBox(height: 40),
                const Text(
                  "اختر اهتمامتك",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: selectedInterests.map((interest) {
                    return Chip(
                      label: Text(interest),
                      deleteIcon: const Icon(Icons.close),
                      onDeleted: () {
                        setState(() {
                          selectedInterests
                              .remove(interest); // Remove from selected
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // List of available interests to select from
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: availableInterests.map((interest) {
                    return ChoiceChip(
                      label: Text(interest),
                      selected: selectedInterests.contains(interest),
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            selectedInterests.add(interest); // Add to selected
                          } else {
                            selectedInterests
                                .remove(interest); // Remove from selected
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
