import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../presentation/viewmodels/statistics_viewmodel.dart'; // Needed for delete
import 'statistic_info_row.dart';
import 'team_score_row.dart';
import '../dialogs/delete_confirmation_dialog.dart';
import '../sheets/detailed_statistics_sheet.dart';

class StatisticCard extends ConsumerWidget {
  final GameStatisticsEntity statistic;

  const StatisticCard({super.key, required this.statistic});

  // Helper to show delete confirmation
  Future<void> _confirmDeleteStatistic(
      BuildContext context, WidgetRef ref) async {
    final bool confirmed = await showDeleteConfirmationDialog(
      context: context,
      title: 'İstatistiği Sil',
      content:
          '${DateFormat('dd MMMM yyyy').format(statistic.timestamp)} tarihli oyuna ait istatistiği silmek istediğinizden emin misiniz?',
    );

    if (confirmed) {
      ref
          .read(statisticsViewModelProvider.notifier)
          .deleteStatistics(statistic.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('İstatistik başarıyla silindi'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade700,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('dd MMMM yyyy, HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:
            BorderSide(color: Colors.amber.shade700.withOpacity(0.3), width: 1),
      ),
      color: Colors.blueGrey.shade900.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dateFormat.format(statistic.timestamp),
                    style: TextStyle(
                      color: Colors.amber.shade300,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'İstatistiği Sil',
                  onPressed: () => _confirmDeleteStatistic(context, ref),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),

            // Game Details using StatisticInfoRow
            StatisticInfoRow(
                label: 'Süre', value: '${statistic.gameDuration} saniye'),
            StatisticInfoRow(
                label: 'Toplam Kelime', value: '${statistic.totalWords}'),
            StatisticInfoRow(
                label: 'Doğru Bilinen',
                value: '${statistic.totalCorrectWords}'),
            StatisticInfoRow(
                label: 'Pas Geçilen', value: '${statistic.totalSkippedWords}'),
            StatisticInfoRow(label: 'Kazanan', value: statistic.winningTeam),
            StatisticInfoRow(
                label: 'En Yüksek Skor', value: '${statistic.highestScore}'),

            const SizedBox(height: 16),

            // Team Scores using TeamScoreRow
            const Text(
              'Takım Skorları',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            ...statistic.teams.map((team) => TeamScoreRow(
                  team: team,
                  winningTeamName: statistic.winningTeam,
                )),

            // Show Detailed Statistics Button
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () =>
                    showDetailedStatisticsSheet(context, statistic),
                icon: const Icon(Icons.bar_chart, size: 20),
                label: const Text('Detaylı İstatistikler'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.amber.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
