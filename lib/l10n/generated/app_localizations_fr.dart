// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tabubu';

  @override
  String get homeStartGame => 'Commencer la partie';

  @override
  String get homeSettings => 'Paramètres';

  @override
  String get homeWords => 'Mots';

  @override
  String get homeStatistics => 'Statistiques';

  @override
  String get settingsTitle => 'Paramètres du jeu';

  @override
  String get settingsLoadError => 'Échec du chargement des paramètres : ';

  @override
  String get settingsGameDuration => 'Durée du tour';

  @override
  String settingsMaxPasses(int count) {
    return 'Passes maximum : $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count passes';
  }

  @override
  String get settingsPassSettings => 'Paramètres de passage';

  @override
  String settingsPassPenalty(int seconds) {
    return 'Pénalité par passe : $seconds secondes';
  }

  @override
  String get settingsWordSettings => 'Paramètres des mots';

  @override
  String get settingsShuffleWords => 'Mélanger les mots';

  @override
  String get settingsShuffleHint =>
      'L\'ordre des mots est aléatoire au début de chaque partie.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageTurkish => 'Turc';

  @override
  String get settingsLanguageEnglish => 'Anglais';

  @override
  String get settingsLanguageArabic => 'Arabe';

  @override
  String get settingsLanguageGerman => 'Allemand';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageIndonesian => 'Indonésien';

  @override
  String get statisticsTitle => 'Statistiques';

  @override
  String get statisticsLoadError => 'Échec du chargement des statistiques : ';

  @override
  String get statisticsEmptyTitle => 'Aucune statistique';

  @override
  String get statisticsEmptySubtitle =>
      'Les statistiques apparaîtront ici après une partie';

  @override
  String get statisticsDeleteTitle => 'Supprimer la statistique';

  @override
  String get statisticsDeleteSuccess => 'Statistique supprimée avec succès';

  @override
  String statisticsDeleteConfirm(String date) {
    return 'Voulez-vous vraiment supprimer la statistique du $date ?';
  }

  @override
  String get statisticsDetailedTitle => 'Statistiques détaillées';

  @override
  String get statisticsCorrectWords => 'Mots devinés correctement';

  @override
  String get statisticsCorrect => 'Corrects';

  @override
  String get statisticsPassedWords => 'Mots passés';

  @override
  String get statisticsPassed => 'Passés';

  @override
  String get statisticsHighScore => 'Meilleur score';

  @override
  String get statisticsTime => 'Durée';

  @override
  String get statisticsTeamScores => 'Scores des équipes';

  @override
  String get statisticsWinnerTeam => 'Équipe gagnante';

  @override
  String get statisticsTeamPerformance => 'Performances des équipes';

  @override
  String get statisticsWordDetails => 'Détails des mots';

  @override
  String get statisticsCorrectCount => 'Corrects';

  @override
  String get statisticsPassCount => 'Passés';

  @override
  String get statisticsTabuCount => 'Tabous';

  @override
  String get statisticsGameDate => 'Date de la partie';

  @override
  String get statisticsScore => 'Score';

  @override
  String get statisticsNone => 'Aucun';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count secondes';
  }

  @override
  String get commonClose => 'Fermer';

  @override
  String get teamSetupTitle => 'CRÉEZ VOS ÉQUIPES';

  @override
  String get teamSetupHowMany => 'Combien d\'équipes participent ?';

  @override
  String teamSetupDefaultName(int index) {
    return 'Équipe $index';
  }

  @override
  String get gameErrorOccurred => 'Une erreur s\'est produite :\n\n';

  @override
  String get gameNewGame => 'NOUVELLE PARTIE';

  @override
  String get gameOver => 'FIN DE PARTIE';

  @override
  String get gameOverHero => 'QUEL MATCH !';

  @override
  String get gameOverExit => 'QUITTER';

  @override
  String get gameOverAgain => 'REJOUER';

  @override
  String get gameReadyHeader => 'SCORES ACTUELS';

  @override
  String get gameReadyNextTeam => 'ÉQUIPE SUIVANTE';

  @override
  String get gameReadyStart => 'COMMENCER';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName est prête';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName joue';
  }

  @override
  String get gameStatusFinished => 'Partie terminée';

  @override
  String get gameTeamSelection => 'Choisir l\'équipe';

  @override
  String get gamePaused => 'En pause';

  @override
  String get gameCorrect => 'Correct';

  @override
  String get gamePass => 'Passer';

  @override
  String get gameTabu => 'Tabou';

  @override
  String get gameResume => 'REPRENDRE';

  @override
  String gamePassCount(int used, int max) {
    return 'Passer ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'MOTS INTERDITS';

  @override
  String get gameNoWordsFound => 'Aucun mot trouvé.';

  @override
  String get gameWordsLoadFail => 'Impossible de charger les mots.';

  @override
  String gameWordsLoadError(String error) {
    return 'Erreur lors du chargement des mots : $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'Aucun mot trouvé. Veuillez ajouter des mots depuis la page de gestion des mots.';

  @override
  String get exitConfirmExitTitle =>
      'Voulez-vous vraiment terminer la partie et aller au tableau des scores ?';

  @override
  String get exitConfirmUnevenTitle =>
      'Toutes les équipes n\'ont pas joué le même nombre de tours. Voulez-vous vraiment quitter ?';

  @override
  String get wordsTitle => 'Gestion des mots';

  @override
  String get wordsEditTitle => 'Modifier le mot';

  @override
  String get wordsResetList => 'Réinitialiser la liste';

  @override
  String get wordsBulkImport => 'Importation groupée';

  @override
  String get wordsBulkImportTitle => 'Importation groupée de mots';

  @override
  String get wordsLabel => 'Mot';

  @override
  String get wordsCancelEdit => 'Annuler la modification';

  @override
  String get wordsSave => 'Enregistrer';

  @override
  String get wordsUpdate => 'Mettre à jour';

  @override
  String get wordsEdit => 'Modifier';

  @override
  String get wordsAddButton => 'Ajouter';

  @override
  String get wordsForbiddenLabel => 'Mot interdit';

  @override
  String get wordsForbiddenList => 'Mots interdits :';

  @override
  String get wordsForbiddenEmpty => 'Aucun mot interdit ajouté.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mots interdits',
      one: '$count mot interdit',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt =>
      'Entrez un mot et ajoutez au moins un mot interdit';

  @override
  String get wordsAddSuccess => 'Nouveau mot ajouté avec succès';

  @override
  String get wordsUpdateSuccess => 'Mot mis à jour avec succès';

  @override
  String get wordsDeleteSuccess => 'Mot supprimé avec succès';

  @override
  String get wordsDeleteConfirm =>
      'Voulez-vous vraiment supprimer ce mot ? Cette action est irréversible.';

  @override
  String get wordsForbiddenDuplicate => 'Ce mot interdit est déjà ajouté';

  @override
  String get wordsEmpty => 'Aucun mot enregistré.';

  @override
  String wordsSavedCount(int count) {
    return 'Mots enregistrés ($count)';
  }

  @override
  String get bulkPasteHint => 'Collez vos données JSON ici...';

  @override
  String get bulkPaste => 'Coller';

  @override
  String get bulkCancel => 'Annuler';

  @override
  String get bulkImport => 'Importer';

  @override
  String get bulkEmpty => 'Veuillez saisir des données JSON.';

  @override
  String get bulkInvalidFormat =>
      'Format JSON invalide. Chaque élément doit contenir \"word\" et \"forbiddenWords\" (liste).';

  @override
  String bulkJsonError(String message) {
    return 'Erreur de format JSON : $message';
  }

  @override
  String bulkImportError(String error) {
    return 'Une erreur s\'est produite lors de l\'importation : $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return '$success mots importés avec succès, $errors échec(s).';
  }

  @override
  String get dialogConfirmDelete => 'Oui, supprimer';

  @override
  String get dialogCancel => 'Annuler';

  @override
  String get dialogWarning => 'Attention !';

  @override
  String get dialogYes => 'OUI';

  @override
  String get dialogNo => 'NON';

  @override
  String get easterEggSurprise => 'Surprise !';
}
