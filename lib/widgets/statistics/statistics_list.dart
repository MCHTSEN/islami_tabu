import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../presentation/viewmodels/statistics_viewmodel.dart';
import 'statistic_card.dart';

class StatisticsList extends ConsumerWidget {
  final List<GameStatisticsEntity> statistics;

  const StatisticsList({super.key, required this.statistics});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(statisticsViewModelProvider.notifier).loadStatistics();
      },
      color: Colors.amber.shade700,
      backgroundColor: Colors.blueGrey.shade800,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: statistics.length,
        itemBuilder: (context, index) {
          final statistic = statistics[index];
          // Use StatisticCard
          return StatisticCard(statistic: statistic);
        },
      ),
    );
  }
}
