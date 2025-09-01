import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustadam/core/Providers/src/condition_model.dart';
import 'package:mustadam/core/widgets/section_placeholder.dart';

import '../../../../Data/Model/RewardSummary/RewardSummaryModel.dart';
import '../../../../Data/Repositories/reward_summary_repo.dart';

class RewardSummaryScreen extends StatelessWidget {
  const RewardSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("Reward Summary")),
      body: FutureBuilder<List<RewardSummaryModel?>?>(
        future: RewardSummaryRepo().readAllWhere([
          QueryCondition.equals(field: "userId", value: userId),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: SectionPlaceholder(title: "No summary available."),
              ),
            );
          }

          final summaries = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: summaries.length,
            itemBuilder: (context, index) {
              final summary = summaries[index]!;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${summary.redeemedPoints < 0 ? 'Use Points' : 'Earn Points'} - ${summary.dateTime.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 12),
                      _buildRow(
                        "Redeemed",
                        summary.redeemedPoints,
                        color:
                            summary.redeemedPoints < 0
                                ? Colors.red
                                : Colors.green,
                      ),
                      const Divider(),
                      _buildRow(
                        "Remaining",
                        summary.totalPoints,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRow(String label, int value, {Color color = Colors.green}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            '$value pts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
