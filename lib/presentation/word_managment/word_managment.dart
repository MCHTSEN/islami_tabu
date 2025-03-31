import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/word_entity.dart';
import '../../presentation/viewmodels/word_viewmodel.dart';

class WordManagementScreen extends ConsumerStatefulWidget {
  const WordManagementScreen({super.key});

  @override
  ConsumerState<WordManagementScreen> createState() =>
      _WordManagementScreenState();
}

class _WordManagementScreenState extends ConsumerState<WordManagementScreen> {
  // Controllers for form fields
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  // Temporary state for forbidden words before submission
  List<String> _forbiddenWords = [];
  final TextEditingController _forbiddenWordController =
      TextEditingController();

  // For edit mode
  bool _isEditMode = false;
  String? _editingWordId;

  @override
  void dispose() {
    _wordController.dispose();
    _categoryController.dispose();
    _forbiddenWordController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _wordController.clear();
    _categoryController.clear();
    _forbiddenWordController.clear();
    setState(() {
      _forbiddenWords = [];
      _isEditMode = false;
      _editingWordId = null;
    });
  }

  void _addForbiddenWord() {
    final forbiddenWord = _forbiddenWordController.text.trim();
    if (forbiddenWord.isNotEmpty) {
      setState(() {
        _forbiddenWords.add(forbiddenWord);
        _forbiddenWordController.clear();
      });
    }
  }

  void _removeForbiddenWord(int index) {
    setState(() {
      _forbiddenWords.removeAt(index);
    });
  }

  void _submitForm() {
    final word = _wordController.text.trim();
    final category = _categoryController.text.trim();

    if (word.isEmpty || category.isEmpty || _forbiddenWords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Tüm alanları doldurun ve en az bir yasaklı kelime ekleyin')),
      );
      return;
    }

    if (_isEditMode && _editingWordId != null) {
      final updatedWord = WordEntity(
        id: _editingWordId!,
        word: word,
        forbiddenWords: _forbiddenWords,
        category: category,
      );
      ref.read(wordViewModelProvider.notifier).updateWord(updatedWord);
    } else {
      ref
          .read(wordViewModelProvider.notifier)
          .addWord(word, _forbiddenWords, category);
    }

    _resetForm();
  }

  void _editWord(WordEntity word) {
    setState(() {
      _isEditMode = true;
      _editingWordId = word.id;
      _wordController.text = word.word;
      _categoryController.text = word.category;
      _forbiddenWords = List.from(word.forbiddenWords);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wordsState = ref.watch(wordViewModelProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelime Yönetimi',
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
              Colors.blueGrey.shade800,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Form section
              Card(
                color: Colors.blueGrey.shade900.withOpacity(0.7),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.amber.shade700, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isEditMode ? 'Kelimeyi Düzenle' : 'Yeni Kelime Ekle',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade300,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Word input
                      TextField(
                        controller: _wordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Kelime',
                          labelStyle: TextStyle(color: Colors.amber.shade200),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Category input
                      TextField(
                        controller: _categoryController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Kategori',
                          labelStyle: TextStyle(color: Colors.amber.shade200),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.amber.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Forbidden words section
                      Text(
                        'Yasaklı Kelimeler',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade300,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _forbiddenWordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Yasaklı Kelime',
                                labelStyle:
                                    TextStyle(color: Colors.amber.shade200),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.teal.shade700),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade400),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addForbiddenWord,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Ekle'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Display forbidden words chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            List.generate(_forbiddenWords.length, (index) {
                          return Chip(
                            label: Text(_forbiddenWords[index]),
                            backgroundColor: Colors.teal.shade700,
                            labelStyle: const TextStyle(color: Colors.white),
                            deleteIconColor: Colors.white,
                            onDeleted: () => _removeForbiddenWord(index),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      // Submit buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_isEditMode)
                            TextButton(
                              onPressed: _resetForm,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                              ),
                              child: const Text('İptal'),
                            ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(_isEditMode ? 'Güncelle' : 'Kaydet'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Words list section
              Expanded(
                child: Card(
                  color: Colors.blueGrey.shade900.withOpacity(0.7),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.teal.shade700, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelimeler',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade300,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: wordsState.when(
                            data: (words) {
                              if (words.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Henüz kelime eklenmemiş',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: () async {
                                  await ref
                                      .read(wordViewModelProvider.notifier)
                                      .loadWords();
                                },
                                child: ListView.builder(
                                  itemCount: words.length,
                                  itemBuilder: (context, index) {
                                    final word = words[index];
                                    return Card(
                                      color: Colors.blueGrey.shade800,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: ExpansionTile(
                                        title: Text(
                                          word.word,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Kategori: ${word.category}',
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit,
                                                  color: Colors.amber),
                                              onPressed: () => _editWord(word),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.redAccent),
                                              onPressed: () {
                                                // Show confirmation dialog
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor: Colors
                                                        .blueGrey.shade900,
                                                    title: Text(
                                                      'Kelimeyi Sil',
                                                      style: TextStyle(
                                                          color: Colors
                                                              .amber.shade300),
                                                    ),
                                                    content: Text(
                                                      '${word.word} kelimesini silmek istediğinize emin misiniz?',
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                            'İptal',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          ref
                                                              .read(
                                                                  wordViewModelProvider
                                                                      .notifier)
                                                              .deleteWord(
                                                                  word.id);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text('Sil',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Yasaklı Kelimeler:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal.shade300,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: word.forbiddenWords
                                                      .map((forbidden) {
                                                    return Chip(
                                                      label: Text(forbidden),
                                                      backgroundColor: Colors
                                                          .redAccent
                                                          .withOpacity(0.7),
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            loading: () => const Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.amber),
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
                                        style: TextStyle(
                                            color: Colors.red.shade300),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  