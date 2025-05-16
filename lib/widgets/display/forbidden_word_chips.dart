import 'package:flutter/material.dart';

class ForbiddenWordChips extends StatelessWidget {
  final List<String> forbiddenWords;
  final Function(int) onDelete;

  const ForbiddenWordChips({
    super.key,
    required this.forbiddenWords,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (forbiddenWords.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Text(
          'Henüz yasaklı kelime eklenmedi.',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade800.withOpacity(0.5)),
      ),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: List<Widget>.generate(forbiddenWords.length, (index) {
          return Chip(
            label: Text(
              forbiddenWords[index],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red.shade900.withOpacity(0.7),
            deleteIcon: const Icon(Icons.cancel, size: 18),
            deleteIconColor: Colors.red.shade200,
            onDeleted: () => onDelete(index),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.red.shade700.withOpacity(0.5)),
            ),
          );
        }),
      ),
    );
  }
}
