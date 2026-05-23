import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';
import '../../domain/entities/game_statistics_entity.dart';
import '../../domain/entities/team_entity.dart';
import '../statistics/statistic_info_row.dart';

Future<void> showDetailedStatisticsSheet(
  BuildContext context,
  GameStatisticsEntity statistic,
) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) =>
        _DetailedStatisticsContent(statistic: statistic),
  );
}

class _DetailedStatisticsContent extends StatelessWidget {
  final GameStatisticsEntity statistic;

  const _DetailedStatisticsContent({required this.statistic});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dateFormat = DateFormat('dd MMMM yyyy, HH:mm');

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(25)),
            border: Border.all(color: Colors.teal.shade700, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.statisticsDetailedTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade300,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey.shade400),
                      onPressed: () => Navigator.pop(context),
                      tooltip: l10n.commonClose,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.teal.shade700.withOpacity(0.5)),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  children: [
                    StatisticInfoRow(
                      label: l10n.statisticsGameDate,
                      value: dateFormat.format(statistic.timestamp),
                    ),
                    StatisticInfoRow(
                      label: l10n.settingsGameDuration,
                      value: l10n
                          .statisticsDurationSeconds(statistic.gameDuration),
                    ),
                    StatisticInfoRow(
                      label: l10n.statisticsWinnerTeam,
                      value: statistic.winningTeam,
                    ),
                    StatisticInfoRow(
                      label: l10n.statisticsHighScore,
                      value: '${statistic.highestScore}',
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.statisticsTeamPerformance,
                        style: TextStyle(
                            color: Colors.teal.shade200,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...statistic.teams
                        .map((team) => _buildTeamDetail(team, l10n)),
                    const SizedBox(height: 16),
                    Text(l10n.statisticsWordDetails,
                        style: TextStyle(
                            color: Colors.teal.shade200,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildWordList(
                        l10n.statisticsCorrectWords,
                        statistic.correctWords,
                        Colors.green.shade300,
                        l10n.statisticsNone),
                    const SizedBox(height: 12),
                    _buildWordList(
                        l10n.statisticsPassedWords,
                        statistic.skippedWords,
                        Colors.orange.shade300,
                        l10n.statisticsNone),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTeamDetail(TeamEntity team, AppLocalizations l10n) {
    return Card(
      color: Colors.blueGrey.shade800.withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              team.name,
              style: TextStyle(
                  color: team.name == statistic.winningTeam
                      ? Colors.amber.shade300
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            StatisticInfoRow(
                label: l10n.statisticsScore, value: '${team.score}'),
            StatisticInfoRow(
                label: l10n.statisticsCorrectCount,
                value: '${team.correctCount}'),
            StatisticInfoRow(
                label: l10n.statisticsPassCount,
                value: '${team.passCount}'),
            StatisticInfoRow(
                label: l10n.statisticsTabuCount,
                value: '${team.tabuCount}'),
          ],
        ),
      ),
    );
  }

  Widget _buildWordList(
      String title, List<String> words, Color color, String emptyLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (words.isEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0, top: 4.0),
            child:
                Text(emptyLabel, style: TextStyle(color: Colors.grey.shade500)),
          )
        else
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: words
                .map((word) => Chip(
                      label: Text(word,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12)),
                      backgroundColor: color.withOpacity(0.2),
                      side: BorderSide(color: color.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
