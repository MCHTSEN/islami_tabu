import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/word_entity.dart';

class WordListItem extends ConsumerWidget {
  final WordEntity word;
  final Function(WordEntity) onEdit;
  final Function(String) onDeleteConfirmed; // Renamed for clarity

  const WordListItem({
    super.key,
    required this.word,
    required this.onEdit,
    required this.onDeleteConfirmed,
  });

  Future<void> _showDeleteConfirmationDialog(BuildContext context,
      WidgetRef ref, String wordId, String wordText) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          '"$wordText" Kelimesini Sil',
          style: TextStyle(
              color: Colors.red.shade300, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Bu kelimeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'İptal',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Evet, Sil'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );

    if (confirmed == true) {
      onDeleteConfirmed(wordId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.blueGrey.shade800.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.teal.shade700.withOpacity(0.5)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade700,
          child: Text(
            word.word.substring(0, 1).toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          word.word,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          '${word.forbiddenWords.length} yasaklı kelime',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        iconColor: Colors.teal.shade300,
        collapsedIconColor: Colors.teal.shade400,
        children: [
          Text(
            'Yasaklı Kelimeler:',
            style: TextStyle(
                color: Colors.teal.shade200, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: word.forbiddenWords
                .map((forbidden) => Chip(
                      label: Text(forbidden,
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red.shade900.withOpacity(0.6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide.none,
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon:
                    Icon(Icons.edit_note_rounded, color: Colors.amber.shade300),
                tooltip: 'Düzenle',
                onPressed: () => onEdit(word),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.delete_forever_rounded,
                    color: Colors.red.shade300),
                tooltip: 'Sil',
                onPressed: () => _showDeleteConfirmationDialog(
                    context, ref, word.id, word.word),
              ),
            ],
          )
        ],
      ),
    );
  }
}
