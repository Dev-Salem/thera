import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'hours': 120},
    {'name': 'Bob', 'hours': 110},
    {'name': 'Charlie', 'hours': 100},
    {'name': 'David', 'hours': 95},
    {'name': 'Eve', 'hours': 80},
  ];

  final Map<String, dynamic> currentUser = {'name': 'Charlie', 'hours': 100};

  LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sort users by hours
    users.sort((a, b) => b['hours'].compareTo(a['hours']));

    // Find current user's rank
    final userRank =
        users.indexWhere((user) => user['name'] == currentUser['name']) + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // User Info Header Widget
          UserInfoHeader(userRank: userRank, currentUser: currentUser),

          const SizedBox(height: 8),

          // Leaderboard List Widget
          Expanded(
            child: LeaderboardList(users: users),
          ),
        ],
      ),
    );
  }
}

// Header Widget to display current user's info
class UserInfoHeader extends StatelessWidget {
  final int userRank;
  final Map<String, dynamic> currentUser;

  const UserInfoHeader({
    super.key,
    required this.userRank,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.accents[userRank],
            child: Text(
              userRank.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Rank: $userRank | Hours: ${currentUser['hours']}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// List Widget for Leaderboard
class LeaderboardList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const LeaderboardList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return LeaderboardItem(user: user, rank: index + 1);
        },
      ),
    );
  }
}

// Individual Item Widget for Each User
class LeaderboardItem extends StatelessWidget {
  final Map<String, dynamic> user;
  final int rank;

  const LeaderboardItem({
    super.key,
    required this.user,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.accents[rank],
          child: Text(
            rank.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: const Text('Total Hours'),
        trailing: Text(
          '${user['hours']} hrs',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
