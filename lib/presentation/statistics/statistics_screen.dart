import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart'; // No longer needed here
import '../../domain/entities/game_statistics_entity.dart';
// import '../../domain/entities/team_entity.dart'; // No longer needed here
import '../viewmodels/statistics_viewmodel.dart';

// Import new widgets
import 'package:islami_tabu/widgets/statistics/empty_statistics_state.dart';
import 'package:islami_tabu/widgets/statistics/statistics_list.dart';
import 'package:islami_tabu/widgets/decorations/background_gradient.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsState = ref.watch(statisticsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İstatistikler',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Use BackgroundGradient
      body: BackgroundGradient(
        child: statisticsState.when(
          data: (statistics) {
            if (statistics.isEmpty) {
              // Use EmptyStatisticsState widget
              return const EmptyStatisticsState();
            }
            // Use StatisticsList widget
            return StatisticsList(statistics: statistics);
          },
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'İstatistikler yüklenirken hata oluştu: \n',
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 16),
                    ),
                    TextSpan(
                      text: '$error',
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
