Below is a comprehensive set of UI and Structural Guidelines for adding new features to your "Kelime Yolculuğu" app. This document establishes rules to maintain consistency in the UI design and enforces a robust architecture using MVVM (Model-View-ViewModel), Clean Architecture (with Use Cases), and Atomic Design principles. These guidelines ensure scalability, maintainability, and a cohesive, stunning UI across all screens.
UI and Structural Guidelines for "Kelime Yolculuğu"
General Principles
Islamic Aesthetic:
Use a color palette inspired by Islamic art: emerald green (Colors.teal), gold (Colors.amber), deep blue (Colors.indigo), and white accents.
Incorporate subtle Islamic motifs (e.g., crescent moons, geometric patterns) in animations or backgrounds.
Maintain a celestial, serene vibe with gradients and glowing effects.
Responsiveness:
Use MediaQuery for dynamic sizing (e.g., screenWidth * 0.3 for buttons, screenHeight * 0.05 for spacing).
Wrap content in SafeArea and SingleChildScrollView to ensure visibility on all screen sizes.
Test on small (e.g., 4-inch phones) and large (e.g., tablets) screens.
Typography:
Use an Arabic-style font (e.g., "Amiri") for titles and key text.
Scale font sizes responsively (e.g., screenWidth * 0.1 for titles, size * 0.12 for button text).
Apply glowing shadows (e.g., amber or teal) for a luxurious effect.
Animations:
Use lightweight animations (e.g., AnimatedContainer, AnimatedBuilder) for smooth transitions.
Limit animation duration to 300ms-2s to balance performance and visual appeal.
Examples: orbiting crescents, ripple effects, opacity pulses.
Consistency:
Reuse the orb button design (circular, gradient, levitating shadow) across screens.
Maintain the gradient background style (radial, teal-gold-indigo) unless a specific screen requires variation.
Architectural Rules
1. MVVM (Model-View-ViewModel)
Model: Represents data and business logic.
Store raw data (e.g., words, forbidden words, scores) in entities (e.g., WordEntity).
Use repositories (e.g., WordRepository) for data access (local via Hive, remote if added later).
View: UI layer, purely declarative.
Use Flutter widgets (e.g., Scaffold, Container) with no business logic.
Leverage ConsumerStatefulWidget for state management with Riverpod.
ViewModel: Mediates between Model and View.
Expose state (e.g., AsyncValue<List<Word>>) and methods (e.g., addWord, startGame) to the View.
Use Riverpod providers (e.g., StateNotifierProvider) to manage state.
Example Structure:
dart
// Model (Entity)
class WordEntity {
  final String word;
  final List<String> forbiddenWords;
  WordEntity(this.word, this.forbiddenWords);
}

// Repository
abstract class WordRepository {
  Future<List<WordEntity>> getWords();
  Future<void> addWord(WordEntity word);
}

// ViewModel (Riverpod)
class WordViewModel extends StateNotifier<AsyncValue<List<WordEntity>>> {
  final WordRepository repository;
  WordViewModel(this.repository) : super(const AsyncValue.loading()) {
    loadWords();
  }

  Future<void> loadWords() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await repository.getWords());
  }

  Future<void> addWord(String word, List<String> forbiddenWords) async {
    await repository.addWord(WordEntity(word, forbiddenWords));
    loadWords();
  }
}

final wordViewModelProvider = StateNotifierProvider<WordViewModel, AsyncValue<List<WordEntity>>>(
  (ref) => WordViewModel(ref.read(wordRepositoryProvider)),
);

// View
class WordManagementScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordsState = ref.watch(wordViewModelProvider);
    return Scaffold(
      body: wordsState.when(
        data: (words) => ListView.builder(
          itemCount: words.length,
          itemBuilder: (context, index) => Text(words[index].word),
        ),
        loading: () => CircularProgressIndicator(),
        error: (error, _) => Text('Hata: $error'),
      ),
    );
  }
}
2. Clean Architecture
Layers:
Domain: Core business logic, independent of frameworks.
Define entities (e.g., WordEntity).
Use cases (e.g., AddWordUseCase, GetWordsUseCase) encapsulate logic.
Data: Data sources and repositories.
Implement repositories (e.g., WordRepositoryImpl) using Hive or other storage.
Presentation: UI and ViewModels.
Connect ViewModels to use cases via dependency injection (Riverpod).
Directory Structure:
lib/
├── core/
│   ├── constants.dart        # Colors, sizes, etc.
│   └── theme.dart           # App theme
├── data/
│   ├── models/              # Data models (e.g., WordModel)
│   └── repositories/        # Repository implementations
├── domain/
│   ├── entities/           # Business entities (e.g., WordEntity)
│   ├── repositories/       # Abstract repositories
│   └── usecases/           # Use cases (e.g., AddWordUseCase)
├── presentation/
│   ├── screens/            # UI screens (e.g., HomePage)
│   ├── viewmodels/         # ViewModels (e.g., WordViewModel)
│   └── widgets/            # Reusable widgets (atoms, molecules, etc.)
└── main.dart
Use Case Example:
dart
// Domain Use Case
class AddWordUseCase {
  final WordRepository repository;
  AddWordUseCase(this.repository);

  Future<void> call(String word, List<String> forbiddenWords) {
    return repository.addWord(WordEntity(word, forbiddenWords));
  }
}

// Repository Implementation (Data Layer)
class WordRepositoryImpl implements WordRepository {
  final HiveDataSource dataSource;
  WordRepositoryImpl(this.dataSource);

  @override
  Future<void> addWord(WordEntity word) => dataSource.saveWord(word);
}
3. Atomic Design
Atoms: Smallest UI building blocks.
Example: _buildOrbButton (custom button with gradient and shadow).
Rules: Keep simple, reusable, no complex logic.
Molecules: Combinations of atoms.
Example: A row of two orb buttons (e.g., "Ayarlar" and "Kelime Yönetimi").
Rules: Combine atoms logically, maintain responsiveness.
Organisms: Complex UI sections.
Example: The entire button layout in HomePage (title + button column).
Rules: Encapsulate functionality, connect to ViewModel.
Templates: Screen layouts.
Example: HomePage layout with background, title, and buttons.
Rules: Define structure, remain flexible for content.
Pages: Final screens.
Example: HomePage, GameScreen.
Rules: Assemble organisms, bind to ViewModel via Riverpod.
Example Widget:
dart
// Atom: OrbButton
class OrbButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double size;

  const OrbButton({required this.text, required this.onTap, required this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.amber.shade600, Colors.teal.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 20, offset: Offset(0, 10)),
            BoxShadow(color: Colors.teal.withOpacity(0.5), blurRadius: 20, offset: Offset(0, -10)),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size * 0.12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(color: Colors.amber.withOpacity(0.8), blurRadius: 10)],
            ),
          ),
        ),
      ),
    );
  }
}

// Molecule: ButtonPair
class ButtonPair extends StatelessWidget {
  final double screenWidth;

  const ButtonPair({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrbButton(
          text: 'Ayarlar',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
          size: screenWidth * 0.3,
        ),
        SizedBox(width: screenWidth * 0.1),
        OrbButton(
          text: 'Kelime Yönetimi',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WordManagementScreen())),
          size: screenWidth * 0.3,
        ),
      ],
    );
  }
}
Rules for Adding Features
UI Consistency:
Match the Islamic theme (colors, motifs).
Use OrbButton or similar atoms for interactive elements.
Ensure responsiveness with MediaQuery-based sizing.
Architecture:
Define new entities and use cases in domain/.
Implement data access in data/ (e.g., Hive storage).
Create a ViewModel in presentation/viewmodels/ with Riverpod.
Build the screen in presentation/screens/ using widgets from presentation/widgets/.
Feature Example (Statistics):
Entity: StatisticsEntity (e.g., games played, wins).
Use Case: GetStatisticsUseCase.
Repository: StatisticsRepository.
ViewModel: StatisticsViewModel (Riverpod provider).
Screen: StatisticsScreen using orb buttons and a list.
