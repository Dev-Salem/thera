import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:thera/src/features/home/presentation/widgets/extra_content_widgets.dart';
import 'package:thera/src/features/home/presentation/widgets/progress_widgets.dart';
import 'package:thera/src/features/home/presentation/widgets/task_card_widgets.dart';
import 'package:thera/src/features/leaderboard/presentation/screens/leaderboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bodies = [const HomeBody(), LeaderboardScreen(), const SizedBox()];
  int _navigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: bodies[_navigationBarIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Leader",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
        currentIndex: 0, // Default selected index
        onTap: (index) {
          setState(() {
            _navigationBarIndex = index;
          });
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressSection(),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.keyboard_double_arrow_right_sharp),
              label:
                  const Text("You have 23 words due to study").withUnderLine(),
            ),
            const SizedBox(height: 16),
            Text(
              "Today's Tasks",
              style: context.titleLarge,
            ).bold(),
            const SizedBox(height: 16),
            const TaskListView(),
            const SizedBox(height: 16),
            Text(
              "Extra Content",
              style: context.titleLarge,
            ).bold(),
            const SizedBox(height: 16),
            const ExtraContentListView(),
          ],
        ),
      ),
    );
  }
}
