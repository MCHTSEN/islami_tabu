import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../viewmodels/statistics_viewmodel.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade900,
              Colors.blueGrey.shade900,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: statisticsState.when(
          data: (statistics) {
            if (statistics.isEmpty) {
              return _buildEmptyState();
            }
            return _buildStatisticsList(context, statistics, ref);
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
                      text: 'Bir hata oluştu: ',
                      style: TextStyle(color: Colors.red.shade300),
                    ),
                    TextSpan(
                      text: '$error',
                      style: TextStyle(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 80,
            color: Colors.amber.shade300.withOpacity(0.7),
          ),
          const SizedBox(height: 24),
          Text(
            'Henüz İstatistik Yok',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade300,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Oyun bitince istatistikler burada görünecek',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsList(
    BuildContext context,
    List<GameStatisticsEntity> statistics,
    WidgetRef ref,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(statisticsViewModelProvider.notifier).loadStatistics();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: statistics.length,
        itemBuilder: (context, index) {
          final statistic = statistics[index];
          return _buildStatisticCard(context, statistic, ref);
        },
      ),
    );
  }

  Widget _buildStatisticCard(
    BuildContext context,
    GameStatisticsEntity statistic,
    WidgetRef ref,
  ) {
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
                  onPressed: () =>
                      _confirmDeleteStatistic(context, statistic, ref),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            const SizedBox(height: 8),

            // Game Details
            _buildInfoRow('Süre:', '${statistic.gameDuration} saniye'),
            _buildInfoRow('Toplam Kelime:', '${statistic.totalWords}'),
            _buildInfoRow('Doğru Bilinen:', '${statistic.totalCorrectWords}'),
            _buildInfoRow('Pas Geçilen:', '${statistic.totalSkippedWords}'),
            _buildInfoRow('Kazanan:', statistic.winningTeam),
            _buildInfoRow('En Yüksek Skor:', '${statistic.highestScore}'),

            const SizedBox(height: 16),

            // Team Scores
            const Text(
              'Takım Skorları',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),

            ...statistic.teams
                .map((team) => _buildTeamScore(team, statistic.winningTeam)),

            // Expand button
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: () => _showDetailedStatistics(context, statistic),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamScore(TeamEntity team, String winningTeam) {
    final isWinner = team.name == winningTeam;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (isWinner)
                const Icon(Icons.emoji_events, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                team.name,
                style: TextStyle(
                  color: isWinner ? Colors.amber : Colors.white70,
                  fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Text(
            '${team.score} puan',
            style: TextStyle(
              color: isWinner ? Colors.amber : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteStatistic(
    BuildContext context,
    GameStatisticsEntity statistic,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade800,
        title: const Text('İstatistiği Sil',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Bu istatistiği silmek istediğinize emin misiniz?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('İptal', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(statisticsViewModelProvider.notifier)
                  .deleteStatistics(statistic.id);
              Navigator.of(context).pop();
            },
            child: const Text('Sil', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDetailedStatistics(
    BuildContext context,
    GameStatisticsEntity statistic,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.blueGrey.shade900,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Title
                const Text(
                  'Detaylı İstatistikler',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),

                // Team Details
                ...statistic.teams.map(
                    (team) => _buildTeamDetails(team, statistic.winningTeam)),

                const SizedBox(height: 16),

                // Overall Performance
                const Text(
                  'Genel Performans',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),

                // Calculate some derived statistics
                _buildPerformanceRow(
                  'Doğru Bilme Oranı:',
                  statistic.totalWords == 0
                      ? '0%'
                      : '${((statistic.totalCorrectWords / statistic.totalWords) * 100).toStringAsFixed(1)}%',
                ),
                _buildPerformanceRow(
                  'Pas Geçme Oranı:',
                  statistic.totalWords == 0
                      ? '0%'
                      : '${((statistic.totalSkippedWords / statistic.totalWords) * 100).toStringAsFixed(1)}%',
                ),
                _buildPerformanceRow(
                  'Ortalama Takım Puanı:',
                  statistic.teams.isEmpty
                      ? '0'
                      : (statistic.teams.fold<int>(
                                  0, (sum, team) => sum + team.score) /
                              statistic.teams.length)
                          .toStringAsFixed(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamDetails(TeamEntity team, String winningTeam) {
    final isWinner = team.name == winningTeam;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isWinner ? Colors.amber.withOpacity(0.5) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isWinner)
                    const Icon(Icons.emoji_events,
                        color: Colors.amber, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    team.name,
                    style: TextStyle(
                      color: isWinner ? Colors.amber : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Text(
                '${team.score} puan',
                style: TextStyle(
                  color: isWinner ? Colors.amber : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Team performance
          _buildPerformanceRow(
            'Doğru Bilinen:',
            '${team.correctWords.length}',
          ),
          _buildPerformanceRow(
            'Pas Geçilen:',
            '${team.skippedWords.length}',
          ),

          // Words lists if not empty
          if (team.correctWords.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Doğru Bilinen Kelimeler:',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: team.correctWords
                  .map((word) => Chip(
                        label: Text(word),
                        backgroundColor: Colors.green.shade900.withOpacity(0.5),
                        labelStyle: const TextStyle(color: Colors.white),
                      ))
                  .toList(),
            ),
          ],

          if (team.skippedWords.isNotEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Pas Geçilen Kelimeler:',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: team.skippedWords
                  .map((word) => Chip(
                        label: Text(word),
                        backgroundColor:
                            Colors.orange.shade900.withOpacity(0.5),
                        labelStyle: const TextStyle(color: Colors.white),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
