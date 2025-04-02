import 'package:flutter/material.dart';

class StatisticInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const StatisticInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            // Allow value to wrap if needed
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis, // Handle long values
            ),
          ),
        ],
      ),
    );
  }
}
