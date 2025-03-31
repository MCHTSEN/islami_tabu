import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
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
  final TextEditingController _forbiddenWordController =
      TextEditingController();
  final TextEditingController _bulkImportController = TextEditingController();
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
    _bulkImportController.dispose();
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

  void _showBulkImportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.file_upload, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Text('Toplu Kelime Yükleme'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'JSON formatında kelime listesi yapıştırın:',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              'Örnek format:\n[{"word": "kelime", "forbiddenWords": ["yasak1", "yasak2"]}]',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bulkImportController,
              maxLines: 8,
              decoration: InputDecoration(
                helper: IconButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: _bulkImportController.text));
                  },
                  icon: const Icon(
                    Icons.paste,
                    color: Colors.black,
                  ),
                ),
                hintText: 'JSON verisini buraya yapıştırın...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.upload_file),
            label: const Text('İçe Aktar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber.shade700,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              _importWords();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _importWords() {
    try {
      final String jsonStr = _bulkImportController.text.trim();
      if (jsonStr.isEmpty) {
        _showErrorSnackBar('JSON verisi boş olamaz');
        return;
      }

      final List<dynamic> jsonList = json.decode(jsonStr);
      int successCount = 0;
      int errorCount = 0;

      for (var item in jsonList) {
        try {
          if (item is Map<String, dynamic> &&
              item.containsKey('word') &&
              item.containsKey('forbiddenWords')) {
            final String word = item['word'];
            final List<String> forbiddenWords = (item['forbiddenWords'] as List)
                .map((e) => e.toString())
                .toList();

            if (word.isNotEmpty && forbiddenWords.isNotEmpty) {
              ref
                  .read(wordViewModelProvider.notifier)
                  .addWord(word, forbiddenWords);
              successCount++;
            } else {
              errorCount++;
            }
          } else {
            errorCount++;
          }
        } catch (e) {
          errorCount++;
        }
      }

      _bulkImportController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '$successCount kelime başarıyla eklendi${errorCount > 0 ? ', $errorCount kelime eklenemedi' : ''}'),
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              successCount > 0 ? Colors.green.shade800 : Colors.orange.shade800,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } catch (e) {
      _showErrorSnackBar('Geçersiz JSON formatı');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red.shade800,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordsState = ref.watch(wordViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelime Yönetimi'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            tooltip: 'Toplu Kelime Yükle',
            onPressed: _showBulkImportDialog,
          ),
        ],
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.blueGrey.shade800.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _isEditMode ? Icons.edit_note : Icons.add_circle,
                              color: Colors.amber.shade300,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isEditMode
                                  ? 'Kelime Düzenle'
                                  : 'Yeni Kelime Ekle',
                              style: TextStyle(
                                color: Colors.amber.shade300,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _wordController,
                          focusNode: _wordFocusNode,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: 'Kelime',
                            labelStyle: TextStyle(color: Colors.amber.shade200),
                            prefixIcon: Icon(Icons.text_fields,
                                color: Colors.teal.shade300),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal.shade700),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.amber.shade400, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor:
                                Colors.blueGrey.shade900.withOpacity(0.3),
                          ),
                          onSubmitted: (_) =>
                              _forbiddenWordFocusNode.requestFocus(),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _forbiddenWordController,
                                focusNode: _forbiddenWordFocusNode,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  labelText: 'Yasaklı Kelime',
                                  labelStyle:
                                      TextStyle(color: Colors.amber.shade200),
                                  prefixIcon: Icon(Icons.block,
                                      color: Colors.red.shade300),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.teal.shade700),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.amber.shade400, width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  filled: true,
                                  fillColor:
                                      Colors.blueGrey.shade900.withOpacity(0.3),
                                ),
                                onSubmitted: (_) => _addForbiddenWord(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.amber.shade700,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                onPressed: _addForbiddenWord,
                                tooltip: 'Yasaklı Kelime Ekle',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Yasaklı Kelimeler',
                          style: TextStyle(
                            color: Colors.amber.shade200,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.teal.shade700),
                          ),
                          child: _forbiddenWords.isEmpty
                              ? Center(
                                  child: Text(
                                    'Henüz yasaklı kelime eklenmemiş',
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: Wrap(
                                      spacing: 8,
                                      children: _forbiddenWords
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final word = entry.value;
                                        return Chip(
                                          label: Text(
                                            word,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          backgroundColor: Colors.red.shade900
                                              .withOpacity(0.6),
                                          deleteIcon:
                                              const Icon(Icons.close, size: 18),
                                          deleteIconColor: Colors.white70,
                                          onDeleted: () =>
                                              _removeForbiddenWord(index),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            side: BorderSide(
                                                color: Colors.red.shade700),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          icon: Icon(
                            _isEditMode ? Icons.save : Icons.add_circle,
                            size: 24,
                          ),
                          label: Text(
                            _isEditMode ? 'Güncelle' : 'Ekle',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber.shade700,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          onPressed: _submitForm,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.blueGrey.shade800.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.list_alt,
                            color: Colors.amber.shade300,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Kelimeler',
                            style: TextStyle(
                              color: Colors.amber.shade300,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 300,
                        child: wordsState.when(
                          data: (words) => words.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.note_add,
                                        size: 48,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Henüz kelime eklenmemiş',
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: words.length,
                                  itemBuilder: (context, index) {
                                    final word = words[index];
                                    return Card(
                                      color: Colors.blueGrey.shade800,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                      child: ExpansionTile(
                                        leading: Icon(
                                          Icons.text_fields,
                                          color: Colors.teal.shade300,
                                        ),
                                        title: Text(
                                          word.word,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.block,
                                                      color:
                                                          Colors.red.shade300,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    const Text(
                                                      'Yasaklı Kelimeler:',
                                                      style: TextStyle(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                ...word.forbiddenWords
                                                    .map((forbiddenWord) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 16.0,
                                                      bottom: 4.0,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.remove_circle,
                                                          color: Colors
                                                              .red.shade300,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                          forbiddenWord,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    TextButton.icon(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      label:
                                                          const Text('Düzenle'),
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.amber,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8,
                                                        ),
                                                      ),
                                                      onPressed: () =>
                                                          _editWord(word),
                                                    ),
                                                    TextButton.icon(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      label: const Text('Sil'),
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.red,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 16,
                                                          vertical: 8,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Kelimeyi Sil'),
                                                            content: Text(
                                                              '"${word.word}" kelimesini silmek istediğinizden emin misiniz?',
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'İptal'),
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        context),
                                                              ),
                                                              TextButton(
                                                                child:
                                                                    const Text(
                                                                        'Sil'),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ref
                                                                      .read(wordViewModelProvider
                                                                          .notifier)
                                                                      .deleteWord(
                                                                          word.id);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          const Text(
                                                                              'Kelime başarıyla silindi'),
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red
                                                                              .shade800,
                                                                      margin: const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.amber),
                            ),
                          ),
                          error: (error, stackTrace) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red.shade300,
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Hata: $error',
                                  style: TextStyle(
                                    color: Colors.red.shade300,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
