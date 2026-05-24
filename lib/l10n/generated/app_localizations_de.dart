// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tabubu';

  @override
  String get homeStartGame => 'Spiel starten';

  @override
  String get homeSettings => 'Einstellungen';

  @override
  String get homeWords => 'Wörter';

  @override
  String get homeStatistics => 'Statistiken';

  @override
  String get settingsTitle => 'Spieleinstellungen';

  @override
  String get settingsLoadError =>
      'Einstellungen konnten nicht geladen werden: ';

  @override
  String get settingsGameDuration => 'Rundendauer';

  @override
  String settingsMaxPasses(int count) {
    return 'Maximale Pässe: $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count Pässe';
  }

  @override
  String get settingsPassSettings => 'Passe-Einstellungen';

  @override
  String settingsPassPenalty(int seconds) {
    return 'Passe-Strafe: $seconds Sekunden';
  }

  @override
  String get settingsWordSettings => 'Worteinstellungen';

  @override
  String get settingsShuffleWords => 'Wörter mischen';

  @override
  String get settingsShuffleHint =>
      'Die Wortreihenfolge wird zu Beginn jedes Spiels zufällig gewählt.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageTurkish => 'Türkisch';

  @override
  String get settingsLanguageEnglish => 'Englisch';

  @override
  String get settingsLanguageArabic => 'Arabisch';

  @override
  String get settingsLanguageGerman => 'Deutsch';

  @override
  String get settingsLanguageFrench => 'Französisch';

  @override
  String get settingsLanguageIndonesian => 'Indonesisch';

  @override
  String get statisticsTitle => 'Statistiken';

  @override
  String get statisticsLoadError =>
      'Statistiken konnten nicht geladen werden: ';

  @override
  String get statisticsEmptyTitle => 'Noch keine Statistiken';

  @override
  String get statisticsEmptySubtitle =>
      'Statistiken erscheinen hier nach Spielende';

  @override
  String get statisticsDeleteTitle => 'Statistik löschen';

  @override
  String get statisticsDeleteSuccess => 'Statistik erfolgreich gelöscht';

  @override
  String statisticsDeleteConfirm(String date) {
    return 'Möchtest du die Statistik vom $date wirklich löschen?';
  }

  @override
  String get statisticsDetailedTitle => 'Detaillierte Statistiken';

  @override
  String get statisticsCorrectWords => 'Richtig erratene Wörter';

  @override
  String get statisticsCorrect => 'Richtig';

  @override
  String get statisticsPassedWords => 'Gepasste Wörter';

  @override
  String get statisticsPassed => 'Gepasst';

  @override
  String get statisticsHighScore => 'Höchste Punktzahl';

  @override
  String get statisticsTime => 'Zeit';

  @override
  String get statisticsTeamScores => 'Teampunkte';

  @override
  String get statisticsWinnerTeam => 'Gewinnerteam';

  @override
  String get statisticsTeamPerformance => 'Teamleistungen';

  @override
  String get statisticsWordDetails => 'Wortdetails';

  @override
  String get statisticsCorrectCount => 'Richtig';

  @override
  String get statisticsPassCount => 'Gepasst';

  @override
  String get statisticsTabuCount => 'Tabu';

  @override
  String get statisticsGameDate => 'Spieldatum';

  @override
  String get statisticsScore => 'Punkte';

  @override
  String get statisticsNone => 'Keine';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count Sekunden';
  }

  @override
  String get commonClose => 'Schließen';

  @override
  String get teamSetupTitle => 'TEAMS ERSTELLEN';

  @override
  String get teamSetupHowMany => 'Wie viele Teams spielen mit?';

  @override
  String teamSetupDefaultName(int index) {
    return 'Team $index';
  }

  @override
  String get gameErrorOccurred => 'Ein Fehler ist aufgetreten:\n\n';

  @override
  String get gameNewGame => 'NEUES SPIEL';

  @override
  String get gameOver => 'SPIEL VORBEI';

  @override
  String get gameOverHero => 'WAS FÜR EIN SPIEL!';

  @override
  String get gameOverExit => 'BEENDEN';

  @override
  String get gameOverAgain => 'NOCHMAL SPIELEN';

  @override
  String get gameReadyHeader => 'PUNKTESTAND';

  @override
  String get gameReadyNextTeam => 'NÄCHSTES TEAM';

  @override
  String get gameReadyStart => 'STARTEN';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName ist bereit';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName spielt';
  }

  @override
  String get gameStatusFinished => 'Spiel beendet';

  @override
  String get gameTeamSelection => 'Team auswählen';

  @override
  String get gamePaused => 'Pausiert';

  @override
  String get gameCorrect => 'Richtig';

  @override
  String get gamePass => 'Passe';

  @override
  String get gameTabu => 'Tabu';

  @override
  String get gameResume => 'WEITER';

  @override
  String gamePassCount(int used, int max) {
    return 'Passe ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'VERBOTENE WÖRTER';

  @override
  String get gameNoWordsFound => 'Keine Wörter gefunden.';

  @override
  String get gameWordsLoadFail => 'Wörter konnten nicht geladen werden.';

  @override
  String gameWordsLoadError(String error) {
    return 'Fehler beim Laden der Wörter: $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'Keine Wörter gefunden. Bitte füge Wörter in der Wortverwaltung hinzu.';

  @override
  String get exitConfirmExitTitle =>
      'Möchtest du das Spiel wirklich beenden und zur Rangliste gehen?';

  @override
  String get exitConfirmUnevenTitle =>
      'Nicht jedes Team hat gleich viele Runden gespielt. Möchtest du wirklich beenden?';

  @override
  String get wordsTitle => 'Wortverwaltung';

  @override
  String get wordsEditTitle => 'Wort bearbeiten';

  @override
  String get wordsResetList => 'Liste zurücksetzen';

  @override
  String get wordsBulkImport => 'Massenimport';

  @override
  String get wordsBulkImportTitle => 'Wörter massenimportieren';

  @override
  String get wordsLabel => 'Wort';

  @override
  String get wordsCancelEdit => 'Bearbeitung abbrechen';

  @override
  String get wordsSave => 'Speichern';

  @override
  String get wordsUpdate => 'Aktualisieren';

  @override
  String get wordsEdit => 'Bearbeiten';

  @override
  String get wordsAddButton => 'Hinzufügen';

  @override
  String get wordsForbiddenLabel => 'Verbotenes Wort';

  @override
  String get wordsForbiddenList => 'Verbotene Wörter:';

  @override
  String get wordsForbiddenEmpty => 'Noch keine verbotenen Wörter hinzugefügt.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count verbotene Wörter',
      one: '$count verbotenes Wort',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt =>
      'Gib ein Wort ein und füge mindestens ein verbotenes Wort hinzu';

  @override
  String get wordsAddSuccess => 'Neues Wort erfolgreich hinzugefügt';

  @override
  String get wordsUpdateSuccess => 'Wort erfolgreich aktualisiert';

  @override
  String get wordsDeleteSuccess => 'Wort erfolgreich gelöscht';

  @override
  String get wordsDeleteConfirm =>
      'Möchtest du dieses Wort wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get wordsForbiddenDuplicate =>
      'Dieses verbotene Wort wurde bereits hinzugefügt';

  @override
  String get wordsEmpty => 'Noch keine gespeicherten Wörter.';

  @override
  String wordsSavedCount(int count) {
    return 'Gespeicherte Wörter ($count)';
  }

  @override
  String get bulkPasteHint => 'JSON-Daten hier einfügen...';

  @override
  String get bulkPaste => 'Einfügen';

  @override
  String get bulkCancel => 'Abbrechen';

  @override
  String get bulkImport => 'Importieren';

  @override
  String get bulkEmpty => 'Bitte JSON-Daten eingeben.';

  @override
  String get bulkInvalidFormat =>
      'Ungültiges JSON-Format. Jedes Element muss \"word\" und \"forbiddenWords\" (Liste) enthalten.';

  @override
  String bulkJsonError(String message) {
    return 'JSON-Formatfehler: $message';
  }

  @override
  String bulkImportError(String error) {
    return 'Beim Import ist ein Fehler aufgetreten: $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return '$success Wörter erfolgreich importiert, $errors fehlgeschlagen.';
  }

  @override
  String get dialogConfirmDelete => 'Ja, löschen';

  @override
  String get dialogCancel => 'Abbrechen';

  @override
  String get dialogWarning => 'Achtung!';

  @override
  String get dialogYes => 'JA';

  @override
  String get dialogNo => 'NEIN';

  @override
  String get easterEggSurprise => 'Überraschung!';

  @override
  String get reviewPromptTitle => 'Gefällt dir Tabubu?';

  @override
  String get reviewPromptMessage =>
      'Wenn ja, würdest du uns mit einer Bewertung im Store unterstützen?';

  @override
  String get reviewPromptRate => 'Bewerten';

  @override
  String get reviewPromptLater => 'Später';
}
