import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/word_entity.dart';
import '../../presentation/viewmodels/word_viewmodel.dart';

Future<void> showBulkImportDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => const _BulkImportDialogContent(),
  );
}

class _BulkImportDialogContent extends ConsumerStatefulWidget {
  const _BulkImportDialogContent();

  @override
  ConsumerState<_BulkImportDialogContent> createState() =>
      _BulkImportDialogContentState();
}

class _BulkImportDialogContentState
    extends ConsumerState<_BulkImportDialogContent> {
  final TextEditingController _bulkImportController = TextEditingController();

  @override
  void dispose() {
    _bulkImportController.dispose();
    super.dispose();
  }

  Future<void> _importWords() async {
    final jsonData = _bulkImportController.text.trim();
    if (jsonData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Lütfen JSON verisini girin.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    try {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final List<WordEntity> wordsToImport = decodedData.map((item) {
        if (item is! Map<String, dynamic> ||
            !item.containsKey('word') ||
            !item.containsKey('forbiddenWords') ||
            item['forbiddenWords'] is! List) {
          throw const FormatException(
              'Geçersiz JSON formatı. Her öğe "word" ve "forbiddenWords" (liste) içermelidir.');
        }
        return WordEntity(
          id: '',
          word: item['word'] as String,
          forbiddenWords: List<String>.from(item['forbiddenWords'] as List),
        );
      }).toList();

      int successCount = 0;
      for (final word in wordsToImport) {
        try {
          await ref
              .read(wordViewModelProvider.notifier)
              .addWord(word.word, word.forbiddenWords);
          successCount++;
        } catch (e) {
          print('Error adding word "${word.word}": $e');
        }
      }

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '$successCount / ${wordsToImport.length} kelime başarıyla içe aktarıldı.'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: successCount == wordsToImport.length
              ? Colors.green.shade800
              : Colors.orange.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } on FormatException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('JSON Format Hatası: ${e.message}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('İçe aktarma sırasında bir hata oluştu: $e'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.file_upload_outlined,
                    color: Colors.amber.shade300,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Toplu Kelime Yükleme',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade300,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () => Navigator.pop(context),
                  tooltip: 'Kapat',
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Input Field
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade800,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.teal.shade700,
                  width: 1,
                ),
              ),
              child: TextField(
                controller: _bulkImportController,
                maxLines: null,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'JSON verisini buraya yapıştırın...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 15,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade700.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final clipboardData =
                            await Clipboard.getData('text/plain');
                        if (clipboardData?.text != null) {
                          _bulkImportController.text = clipboardData!.text!;
                        }
                      },
                      icon: const Icon(Icons.paste_rounded),
                      tooltip: 'Yapıştır',
                      color: Colors.amber.shade300,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade400,
                  ),
                  child: const Text('İptal'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _importWords,
                  icon: const Icon(Icons.download_done_rounded),
                  label: const Text('İçe Aktar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
