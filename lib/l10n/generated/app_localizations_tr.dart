// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Tabubu';

  @override
  String get homeStartGame => 'Oyunu Başlat';

  @override
  String get homeSettings => 'Ayarlar';

  @override
  String get homeWords => 'Kelimeler';

  @override
  String get homeStatistics => 'İstatistikler';

  @override
  String get settingsTitle => 'Oyun Ayarları';

  @override
  String get settingsLoadError => 'Ayarlar yüklenirken hata oluştu: ';

  @override
  String get settingsGameDuration => 'Oyun Süresi';

  @override
  String settingsMaxPasses(int count) {
    return 'Maksimum Pas: $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count pas';
  }

  @override
  String get settingsPassSettings => 'Pas Geçme Ayarları';

  @override
  String settingsPassPenalty(int seconds) {
    return 'Pas Cezası: $seconds saniye';
  }

  @override
  String get settingsWordSettings => 'Kelime Ayarları';

  @override
  String get settingsShuffleWords => 'Kelimeleri Karıştır';

  @override
  String get settingsShuffleHint =>
      'Her oyun başlangıcında kelime sırası rastgele olur.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageTurkish => 'Türkçe';

  @override
  String get settingsLanguageEnglish => 'İngilizce';

  @override
  String get settingsLanguageArabic => 'Arapça';

  @override
  String get settingsLanguageGerman => 'Almanca';

  @override
  String get settingsLanguageFrench => 'Fransızca';

  @override
  String get settingsLanguageIndonesian => 'Endonezce';

  @override
  String get statisticsTitle => 'İstatistikler';

  @override
  String get statisticsLoadError => 'İstatistikler yüklenirken hata oluştu: ';

  @override
  String get statisticsEmptyTitle => 'Henüz İstatistik Yok';

  @override
  String get statisticsEmptySubtitle =>
      'Oyun bitince istatistikler burada görünecek';

  @override
  String get statisticsDeleteTitle => 'İstatistiği Sil';

  @override
  String get statisticsDeleteSuccess => 'İstatistik başarıyla silindi';

  @override
  String statisticsDeleteConfirm(String date) {
    return '$date tarihli oyuna ait istatistiği silmek istediğinizden emin misiniz?';
  }

  @override
  String get statisticsDetailedTitle => 'Detaylı İstatistikler';

  @override
  String get statisticsCorrectWords => 'Doğru Bilinen Kelimeler';

  @override
  String get statisticsCorrect => 'Doğru Bilinen';

  @override
  String get statisticsPassedWords => 'Pas Geçilen Kelimeler';

  @override
  String get statisticsPassed => 'Pas Geçilen';

  @override
  String get statisticsHighScore => 'En Yüksek Skor';

  @override
  String get statisticsTime => 'Süre';

  @override
  String get statisticsTeamScores => 'Takım Skorları';

  @override
  String get statisticsWinnerTeam => 'Kazanan Takım';

  @override
  String get statisticsTeamPerformance => 'Takım Performansları';

  @override
  String get statisticsWordDetails => 'Kelime Detayları';

  @override
  String get statisticsCorrectCount => 'Doğru Sayısı';

  @override
  String get statisticsPassCount => 'Pas Sayısı';

  @override
  String get statisticsTabuCount => 'Tabu Sayısı';

  @override
  String get statisticsGameDate => 'Oyun Tarihi';

  @override
  String get statisticsScore => 'Skor';

  @override
  String get statisticsNone => 'Yok';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count saniye';
  }

  @override
  String get commonClose => 'Kapat';

  @override
  String get teamSetupTitle => 'TAKIMLARINI OLUŞTUR';

  @override
  String get teamSetupHowMany => 'Kaç takım yarışacak?';

  @override
  String teamSetupDefaultName(int index) {
    return '$index. Takım';
  }

  @override
  String get gameErrorOccurred => 'Bir Hata Oluştu:\n\n';

  @override
  String get gameNewGame => 'YENİ OYUN';

  @override
  String get gameOver => 'OYUN BİTTİ';

  @override
  String get gameOverHero => 'MUHTEŞEM BİR MÜCADELEYDİ';

  @override
  String get gameOverExit => 'ÇIKIŞ';

  @override
  String get gameOverAgain => 'BİR DAHA';

  @override
  String get gameReadyHeader => 'GÜNCEL SKORLAR';

  @override
  String get gameReadyNextTeam => 'SIRADAKİ TAKIM';

  @override
  String get gameReadyStart => 'BAŞLA';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName Hazır';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName Oynuyor';
  }

  @override
  String get gameStatusFinished => 'Oyun Bitti';

  @override
  String get gameTeamSelection => 'Takım Seçimi';

  @override
  String get gamePaused => 'Duraklatıldı';

  @override
  String get gameCorrect => 'Doğru';

  @override
  String get gamePass => 'Pas';

  @override
  String get gameTabu => 'Tabu';

  @override
  String get gameResume => 'DEVAM ET';

  @override
  String gamePassCount(int used, int max) {
    return 'Pas ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'YASAKLI KELİMELER';

  @override
  String get gameNoWordsFound => 'Kelime bulunamadı.';

  @override
  String get gameWordsLoadFail => 'Kelimeler yüklenemedi.';

  @override
  String gameWordsLoadError(String error) {
    return 'Kelimeler yüklenirken hata oluştu: $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'Kelime bulunamadı. Lütfen kelime yönetimi sayfasından kelime ekleyin.';

  @override
  String get exitConfirmExitTitle =>
      'Oyunu bitirip skor tablosuna gitmek istediğinize emin misiniz?';

  @override
  String get exitConfirmUnevenTitle =>
      'Her takım eşit sayıda tur oynamadı. Yine de çıkmak istediğinize emin misiniz?';

  @override
  String get wordsTitle => 'Kelime Yönetimi';

  @override
  String get wordsEditTitle => 'Kelimeyi Düzenle';

  @override
  String get wordsResetList => 'Listeyi Sıfırla';

  @override
  String get wordsBulkImport => 'Toplu Yükleme';

  @override
  String get wordsBulkImportTitle => 'Toplu Kelime Yükleme';

  @override
  String get wordsLabel => 'Kelime';

  @override
  String get wordsCancelEdit => 'Düzenlemeyi İptal Et';

  @override
  String get wordsSave => 'Kaydet';

  @override
  String get wordsUpdate => 'Güncelle';

  @override
  String get wordsEdit => 'Düzenle';

  @override
  String get wordsAddButton => 'Ekle';

  @override
  String get wordsForbiddenLabel => 'Yasaklı Kelime';

  @override
  String get wordsForbiddenList => 'Yasaklı Kelimeler:';

  @override
  String get wordsForbiddenEmpty => 'Henüz yasaklı kelime eklenmedi.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yasaklı kelime',
      one: '$count yasaklı kelime',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt =>
      'Kelimeyi girin ve en az bir yasaklı kelime ekleyin';

  @override
  String get wordsAddSuccess => 'Yeni kelime başarıyla eklendi';

  @override
  String get wordsUpdateSuccess => 'Kelime başarıyla güncellendi';

  @override
  String get wordsDeleteSuccess => 'Kelime başarıyla silindi';

  @override
  String get wordsDeleteConfirm =>
      'Bu kelimeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.';

  @override
  String get wordsForbiddenDuplicate => 'Bu yasaklı kelime zaten eklenmiş';

  @override
  String get wordsEmpty => 'Henüz kaydedilmiş kelime yok.';

  @override
  String wordsSavedCount(int count) {
    return 'Kaydedilmiş Kelimeler ($count)';
  }

  @override
  String get bulkPasteHint => 'JSON verisini buraya yapıştırın...';

  @override
  String get bulkPaste => 'Yapıştır';

  @override
  String get bulkCancel => 'İptal';

  @override
  String get bulkImport => 'İçe Aktar';

  @override
  String get bulkEmpty => 'Lütfen JSON verisini girin.';

  @override
  String get bulkInvalidFormat =>
      'Geçersiz JSON formatı. Her öğe \"word\" ve \"forbiddenWords\" (liste) içermelidir.';

  @override
  String bulkJsonError(String message) {
    return 'JSON Format Hatası: $message';
  }

  @override
  String bulkImportError(String error) {
    return 'İçe aktarma sırasında bir hata oluştu: $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return '$success kelime başarıyla, $errors kelime hatayla içe aktarıldı.';
  }

  @override
  String get dialogConfirmDelete => 'Evet, Sil';

  @override
  String get dialogCancel => 'İptal';

  @override
  String get dialogWarning => 'Dikkat!';

  @override
  String get dialogYes => 'EVET';

  @override
  String get dialogNo => 'HAYIR';

  @override
  String get easterEggSurprise => 'Sürpriz!';
}
