import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'dart:convert'; // No longer needed here
import '../../domain/entities/word_entity.dart';
import '../../presentation/viewmodels/word_viewmodel.dart';

// Import new widgets
import 'package:islami_tabu/widgets/dialogs/bulk_import_dialog.dart';
import 'package:islami_tabu/widgets/inputs/forbidden_word_input.dart';
import 'package:islami_tabu/widgets/display/forbidden_word_chips.dart';
import 'package:islami_tabu/widgets/lists/word_list_item.dart';
import 'package:islami_tabu/widgets/decorations/background_gradient.dart'; // Assuming you want the standard background

class WordManagementScreen extends ConsumerStatefulWidget {
  const WordManagementScreen({super.key});

  @override
  ConsumerState<WordManagementScreen> createState() =>
      _WordManagementScreenState();
}

class _WordManagementScreenState extends ConsumerState<WordManagementScreen> {
  // Controllers for form fields
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _forbiddenWordController =
      TextEditingController();
  // final TextEditingController _bulkImportController = TextEditingController(); // Moved to dialog
  final FocusNode _wordFocusNode = FocusNode();
  final FocusNode _forbiddenWordFocusNode = FocusNode();

  // Temporary state for forbidden words before submission
  List<String> _forbiddenWords = [];

  // For edit mode
  bool _isEditMode = false;
  String? _editingWordId;

  @override
  void dispose() {
    _wordController.dispose();
    _forbiddenWordController.dispose();
    // _bulkImportController.dispose(); // Moved
    _wordFocusNode.dispose();
    _forbiddenWordFocusNode.dispose();
    super.dispose();
  }

  void _resetForm() {
    _wordController.clear();
    _forbiddenWordController.clear();
    setState(() {
      _forbiddenWords = [];
      _isEditMode = false;
      _editingWordId = null;
    });
    _wordFocusNode.requestFocus();
  }

  void _addForbiddenWord() {
    final forbiddenWord = _forbiddenWordController.text.trim();
    if (forbiddenWord.isNotEmpty) {
      if (_forbiddenWords.contains(forbiddenWord)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Bu yasaklı kelime zaten eklenmiş'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.orange.shade800,
            margin: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );
        return;
      }
      setState(() {
        _forbiddenWords.add(forbiddenWord);
        _forbiddenWordController.clear();
      });
      _forbiddenWordFocusNode.requestFocus();
    }
  }

  void _removeForbiddenWord(int index) {
    setState(() {
      _forbiddenWords.removeAt(index);
    });
  }

  void _submitForm() {
    final word = _wordController.text.trim();

    if (word.isEmpty || _forbiddenWords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Kelimeyi girin ve en az bir yasaklı kelime ekleyin'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    if (_isEditMode && _editingWordId != null) {
      final updatedWord = WordEntity(
        id: _editingWordId!,
        word: word,
        forbiddenWords: _forbiddenWords,
      );
      ref.read(wordViewModelProvider.notifier).updateWord(updatedWord);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Kelime başarıyla güncellendi'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } else {
      ref.read(wordViewModelProvider.notifier).addWord(word, _forbiddenWords);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Yeni kelime başarıyla eklendi'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }

    _resetForm();
  }

  void _editWord(WordEntity word) {
    setState(() {
      _isEditMode = true;
      _editingWordId = word.id;
      _wordController.text = word.word;
      _forbiddenWords = List.from(word.forbiddenWords);
    });
    _wordFocusNode.requestFocus();
  }

  // Method to handle confirmed deletion from WordListItem
  void _deleteWordConfirmed(String wordId) {
    ref.read(wordViewModelProvider.notifier).deleteWord(wordId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Kelime başarıyla silindi'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade700,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    // If the deleted word was being edited, reset the form
    if (_isEditMode && _editingWordId == wordId) {
      _resetForm();
    }
  }

  // No longer needed: void _showBulkImportDialog()

  @override
  Widget build(BuildContext context) {
    final wordState = ref.watch(wordViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Kelimeyi Düzenle' : 'Kelime Yönetimi',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade900,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Bulk Import Button
          IconButton(
            icon: const Icon(Icons.file_upload_outlined),
            tooltip: 'Toplu Yükleme',
            onPressed: () =>
                showBulkImportDialog(context), // Use extracted dialog function
          ),
          // Refresh Button
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Yenile',
            onPressed: () =>
                ref.read(wordViewModelProvider.notifier).loadWords(),
          ),
        ],
      ),
      body: BackgroundGradient(
        // Add background gradient
        child: RefreshIndicator(
          onRefresh: () => ref.read(wordViewModelProvider.notifier).loadWords(),
          color: Colors.amber.shade700,
          backgroundColor: Colors.blueGrey.shade800,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Word Form Section
              _buildWordForm(context),
              const SizedBox(height: 24),
              Divider(
                  color: Colors.teal.shade700.withOpacity(0.5), thickness: 1),
              const SizedBox(height: 16),
              // Word List Section
              _buildWordList(context, wordState),
            ],
          ),
        ),
      ),
    );
  }

  // Keep form building logic here for now, using extracted widgets
  Widget _buildWordForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade700.withOpacity(0.5)),
                    ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
          // Word Input
                            TextField(
                              controller: _wordController,
                              focusNode: _wordFocusNode,
            style: const TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                labelText: 'Kelime',
              labelStyle: TextStyle(color: Colors.teal.shade200),
              filled: true,
              fillColor: Colors.blueGrey.shade800.withOpacity(0.5),
              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.teal.shade300, width: 2),
              ),
              suffixIcon: _isEditMode
                  ? IconButton(
                      icon: Icon(Icons.cancel_outlined,
                          color: Colors.grey.shade400),
                      tooltip: 'Düzenlemeyi İptal Et',
                      onPressed: _resetForm,
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
                            ),
                            const SizedBox(height: 16),

          // Use ForbiddenWordInput widget
          ForbiddenWordInput(
                                    controller: _forbiddenWordController,
                                    focusNode: _forbiddenWordFocusNode,
            onAdd: _addForbiddenWord,
          ),

          // Use ForbiddenWordChips widget
          ForbiddenWordChips(
            forbiddenWords: _forbiddenWords,
            onDelete: _removeForbiddenWord,
          ),
          const SizedBox(height: 20),

          // Submit Button
                            ElevatedButton.icon(
            onPressed: _submitForm,
                              icon: Icon(
                _isEditMode ? Icons.save_alt_rounded : Icons.add_task_rounded,
                size: 20),
            label: Text(_isEditMode ? 'Güncelle' : 'Kaydet'),
                              style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isEditMode ? Colors.amber.shade800 : Colors.green.shade700,
                                foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
    );
  }

  // Keep word list building logic here, using extracted WordListItem
  Widget _buildWordList(
      BuildContext context, AsyncValue<List<WordEntity>> wordState) {
    return wordState.when(
      data: (words) {
        if (words.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                'Henüz kaydedilmiş kelime yok.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
              'Kaydedilmiş Kelimeler (${words.length})',
                                style: TextStyle(
                color: Colors.teal.shade200,
                fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
            const SizedBox(height: 12),
            ListView.builder(
                                      shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                                      itemCount: words.length,
                                      itemBuilder: (context, index) {
                                        final word = words[index];
                // Use WordListItem widget
                return WordListItem(
                  word: word,
                  onEdit: _editWord,
                  onDeleteConfirmed:
                      _deleteWordConfirmed, // Pass confirmation handler
                                                            );
                                                          },
                                                        ),
                                                      ],
        );
      },
                              loading: () => const Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: CircularProgressIndicator(color: Colors.amber),
      )),
                              error: (error, stackTrace) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16),
          child: SelectableText.rich(
            TextSpan(
                                  children: [
                TextSpan(
                  text: 'Kelimeler yüklenirken hata oluştu: \n',
                  style: TextStyle(color: Colors.red.shade300, fontSize: 16),
                ),
                TextSpan(
                  text: '$error',
                                      style: TextStyle(
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                            ),
                          ),
                        ],
                      ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
