import 'package:flutter/material.dart';

class EmptyStatisticsState extends StatelessWidget {
  const EmptyStatisticsState({super.key});

  @override
  Widget build(BuildContext context) {
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
}
