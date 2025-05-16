import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import '../../domain/entities/word_entity.dart';
import '../../core/constants/hardcoded_words.dart';

// Notifier to manage the in-memory list of words
class InMemoryWordNotifier extends StateNotifier<AsyncValue<List<WordEntity>>> {
  final Uuid _uuid =
      const Uuid(); // Helper to generate unique IDs for new words

  InMemoryWordNotifier() : super(const AsyncValue.loading()) {
    _loadInitialWords();
  }

  void _loadInitialWords() {
    // Start with a copy of the hardcoded list
    state = AsyncValue.data(List<WordEntity>.from(initialHardcodedWords));
  }

  // Method to get the current list of words (synchronously if loaded)
  List<WordEntity> getCurrentWords() {
    return state.value ?? [];
  }

  void addWord(String word, List<String> forbiddenWords) {
    state.whenData((words) {
      final newWord = WordEntity(
        id: _uuid.v4(), // Generate a unique ID
        word: word,
        forbiddenWords: forbiddenWords,
      );
      // Create a new list with the added word
      state = AsyncValue.data([...words, newWord]);
    });
  }

  void updateWord(WordEntity updatedWord) {
    state.whenData((words) {
      // Create a new list with the updated word
      final updatedList = words.map((w) {
        return w.id == updatedWord.id ? updatedWord : w;
      }).toList();
      state = AsyncValue.data(updatedList);
    });
  }

  void deleteWord(String wordId) {
    state.whenData((words) {
      // Create a new list excluding the deleted word
      final updatedList = words.where((w) => w.id != wordId).toList();
      state = AsyncValue.data(updatedList);
    });
  }

  // Optional: Method to refresh/reload the list (resets to initial hardcoded state)
  void refreshWords() {
    _loadInitialWords();
  }
}

// The provider for the in-memory word list
final inMemoryWordProvider =
    StateNotifierProvider<InMemoryWordNotifier, AsyncValue<List<WordEntity>>>(
  (ref) => InMemoryWordNotifier(),
);
