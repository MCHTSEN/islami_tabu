import 'package:flutter/material.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';

class EmptyStatisticsState extends StatelessWidget {
  const EmptyStatisticsState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
            l10n.statisticsEmptyTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade300,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.statisticsEmptySubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
