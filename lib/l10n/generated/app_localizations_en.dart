// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tabubu';

  @override
  String get homeStartGame => 'Start Game';

  @override
  String get homeSettings => 'Settings';

  @override
  String get homeWords => 'Words';

  @override
  String get homeStatistics => 'Statistics';

  @override
  String get settingsTitle => 'Game Settings';

  @override
  String get settingsLoadError => 'Failed to load settings: ';

  @override
  String get settingsGameDuration => 'Round Duration';

  @override
  String settingsMaxPasses(int count) {
    return 'Maximum Passes: $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count passes';
  }

  @override
  String get settingsPassSettings => 'Pass Settings';

  @override
  String settingsPassPenalty(int seconds) {
    return 'Pass penalty: $seconds seconds';
  }

  @override
  String get settingsWordSettings => 'Word Settings';

  @override
  String get settingsShuffleWords => 'Shuffle Words';

  @override
  String get settingsShuffleHint =>
      'Word order is randomized at the start of every game.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageTurkish => 'Turkish';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'Arabic';

  @override
  String get settingsLanguageGerman => 'German';

  @override
  String get settingsLanguageFrench => 'French';

  @override
  String get settingsLanguageIndonesian => 'Indonesian';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statisticsLoadError => 'Failed to load statistics: ';

  @override
  String get statisticsEmptyTitle => 'No Statistics Yet';

  @override
  String get statisticsEmptySubtitle =>
      'Statistics will appear here after a game ends';

  @override
  String get statisticsDeleteTitle => 'Delete Statistic';

  @override
  String get statisticsDeleteSuccess => 'Statistic deleted successfully';

  @override
  String statisticsDeleteConfirm(String date) {
    return 'Are you sure you want to delete the statistic from $date?';
  }

  @override
  String get statisticsDetailedTitle => 'Detailed Statistics';

  @override
  String get statisticsCorrectWords => 'Correctly Guessed Words';

  @override
  String get statisticsCorrect => 'Correct';

  @override
  String get statisticsPassedWords => 'Passed Words';

  @override
  String get statisticsPassed => 'Passed';

  @override
  String get statisticsHighScore => 'Highest Score';

  @override
  String get statisticsTime => 'Time';

  @override
  String get statisticsTeamScores => 'Team Scores';

  @override
  String get statisticsWinnerTeam => 'Winning Team';

  @override
  String get statisticsTeamPerformance => 'Team Performance';

  @override
  String get statisticsWordDetails => 'Word Details';

  @override
  String get statisticsCorrectCount => 'Correct';

  @override
  String get statisticsPassCount => 'Pass';

  @override
  String get statisticsTabuCount => 'Taboo';

  @override
  String get statisticsGameDate => 'Game Date';

  @override
  String get statisticsScore => 'Score';

  @override
  String get statisticsNone => 'None';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count seconds';
  }

  @override
  String get commonClose => 'Close';

  @override
  String get teamSetupTitle => 'CREATE YOUR TEAMS';

  @override
  String get teamSetupHowMany => 'How many teams will play?';

  @override
  String teamSetupDefaultName(int index) {
    return 'Team $index';
  }

  @override
  String get gameErrorOccurred => 'An error occurred:\n\n';

  @override
  String get gameNewGame => 'NEW GAME';

  @override
  String get gameOver => 'GAME OVER';

  @override
  String get gameOverHero => 'WHAT A MATCH!';

  @override
  String get gameOverExit => 'EXIT';

  @override
  String get gameOverAgain => 'PLAY AGAIN';

  @override
  String get gameReadyHeader => 'CURRENT SCORES';

  @override
  String get gameReadyNextTeam => 'NEXT TEAM';

  @override
  String get gameReadyStart => 'START';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName is Ready';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName is Playing';
  }

  @override
  String get gameStatusFinished => 'Game Over';

  @override
  String get gameTeamSelection => 'Choose Team';

  @override
  String get gamePaused => 'Paused';

  @override
  String get gameCorrect => 'Correct';

  @override
  String get gamePass => 'Pass';

  @override
  String get gameTabu => 'Taboo';

  @override
  String get gameResume => 'RESUME';

  @override
  String gamePassCount(int used, int max) {
    return 'Pass ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'FORBIDDEN WORDS';

  @override
  String get gameNoWordsFound => 'No words found.';

  @override
  String get gameWordsLoadFail => 'Failed to load words.';

  @override
  String gameWordsLoadError(String error) {
    return 'Error loading words: $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'No words found. Please add words from the word management page.';

  @override
  String get exitConfirmExitTitle =>
      'Are you sure you want to end the game and go to the scoreboard?';

  @override
  String get exitConfirmUnevenTitle =>
      'Not every team played an equal number of rounds. Are you sure you want to exit?';

  @override
  String get wordsTitle => 'Word Management';

  @override
  String get wordsEditTitle => 'Edit Word';

  @override
  String get wordsResetList => 'Reset List';

  @override
  String get wordsBulkImport => 'Bulk Import';

  @override
  String get wordsBulkImportTitle => 'Bulk Word Import';

  @override
  String get wordsLabel => 'Word';

  @override
  String get wordsCancelEdit => 'Cancel Edit';

  @override
  String get wordsSave => 'Save';

  @override
  String get wordsUpdate => 'Update';

  @override
  String get wordsEdit => 'Edit';

  @override
  String get wordsAddButton => 'Add';

  @override
  String get wordsForbiddenLabel => 'Forbidden Word';

  @override
  String get wordsForbiddenList => 'Forbidden Words:';

  @override
  String get wordsForbiddenEmpty => 'No forbidden words added yet.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count forbidden words',
      one: '$count forbidden word',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt =>
      'Enter a word and add at least one forbidden word';

  @override
  String get wordsAddSuccess => 'New word added successfully';

  @override
  String get wordsUpdateSuccess => 'Word updated successfully';

  @override
  String get wordsDeleteSuccess => 'Word deleted successfully';

  @override
  String get wordsDeleteConfirm =>
      'Are you sure you want to delete this word? This action cannot be undone.';

  @override
  String get wordsForbiddenDuplicate => 'This forbidden word is already added';

  @override
  String get wordsEmpty => 'No saved words yet.';

  @override
  String wordsSavedCount(int count) {
    return 'Saved Words ($count)';
  }

  @override
  String get bulkPasteHint => 'Paste your JSON data here...';

  @override
  String get bulkPaste => 'Paste';

  @override
  String get bulkCancel => 'Cancel';

  @override
  String get bulkImport => 'Import';

  @override
  String get bulkEmpty => 'Please enter JSON data.';

  @override
  String get bulkInvalidFormat =>
      'Invalid JSON format. Each item must contain \"word\" and \"forbiddenWords\" (list).';

  @override
  String bulkJsonError(String message) {
    return 'JSON format error: $message';
  }

  @override
  String bulkImportError(String error) {
    return 'An error occurred during import: $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return '$success words imported successfully, $errors failed.';
  }

  @override
  String get dialogConfirmDelete => 'Yes, Delete';

  @override
  String get dialogCancel => 'Cancel';

  @override
  String get dialogWarning => 'Warning!';

  @override
  String get dialogYes => 'YES';

  @override
  String get dialogNo => 'NO';

  @override
  String get easterEggSurprise => 'Surprise!';

  @override
  String get reviewPromptTitle => 'Enjoying Tabubu?';

  @override
  String get reviewPromptMessage =>
      'If you like it, would you support us with a rating in the store?';

  @override
  String get reviewPromptRate => 'Rate';

  @override
  String get reviewPromptLater => 'Later';
}
