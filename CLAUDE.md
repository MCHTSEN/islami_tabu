# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

İslami Tabu is a Flutter-based word guessing game with Islamic themes. It's a Turkish-language app ("İslami" means "Islamic", "Tabu" means "Taboo") where teams compete by having one player describe a word without using forbidden words.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Generate Hive adapters (after modifying models with @HiveType)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Generate app icons (after modifying pubspec.yaml flutter_launcher_icons section)
flutter pub run flutter_launcher_icons
```

## Architecture

The project follows **Clean Architecture** with three layers:

### Domain Layer (`lib/domain/`)
- **Entities**: Core business objects (`GameStateEntity`, `WordEntity`, `TeamEntity`, `GameSettingsEntity`, `GameStatisticsEntity`)
- **Repositories**: Abstract interfaces defining data contracts
- **Use Cases**: Single-responsibility business operations (e.g., `GetGameSettingsUseCase`, `SaveGameStatisticsUseCase`)

### Data Layer (`lib/data/`)
- **Models**: Hive-annotated classes with `.g.dart` generated adapters (e.g., `GameSettingsModel`, `TeamModel`)
- **Repository Implementations**: Concrete implementations using Hive for local storage

### Presentation Layer (`lib/presentation/`)
- **Screens**: Page-level widgets organized by feature (`home/`, `game_screen/`, `settings/`, `statistics/`, `word_managment/`)
- **ViewModels**: State management using Riverpod's `StateNotifier`

## State Management

**Dual approach using Riverpod and GetIt:**
- **Riverpod**: Primary state management for UI reactivity. ViewModels are `StateNotifier<AsyncValue<T>>` exposed via `StateNotifierProvider`
- **GetIt**: Service locator for dependency injection, set up in `lib/core/di/service_locator.dart`

Key providers:
- `gameViewModelProvider` - Main game state (in `presentation/viewmodels/game_viewmodel.dart`)
- `inMemoryWordProvider` - Word list management (in `providers/in_memory_word_provider.dart`)

## Data Persistence

**Hive** is used for local storage:
- Boxes: `settings`, `statistics`, `migrations`
- Adapters are generated via `build_runner` for models with `@HiveType` and `@HiveField` annotations
- Migration system exists in `main.dart` for schema changes

## Game Flow

1. **Setup** (`GameStatus.setup`): Initial state, loading words
2. **Ready** (`GameStatus.ready`): Teams configured, waiting to start
3. **Playing** (`GameStatus.playing`): Active gameplay with timer
4. **Paused** (`GameStatus.paused`): Game temporarily stopped
5. **Finished** (`GameStatus.finished`): Game ended, showing scores

## Key Files

- `lib/main.dart` - App entry point, Hive initialization, migration logic
- `lib/core/di/service_locator.dart` - GetIt dependency injection setup
- `lib/presentation/viewmodels/game_viewmodel.dart` - Core game logic and state
- `lib/core/constants/hardcoded_words.dart` - Default word list (Islamic-themed Turkish words)
- `lib/providers/in_memory_word_provider.dart` - Runtime word list management

## Language

The app is in **Turkish**. Error messages, UI text, and word content are all in Turkish. The word list contains Islamic terminology in Turkish.
