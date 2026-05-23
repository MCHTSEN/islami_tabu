import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('id'),
    Locale('tr')
  ];

  /// App display title
  ///
  /// In tr, this message translates to:
  /// **'Tabubu'**
  String get appTitle;

  /// No description provided for @homeStartGame.
  ///
  /// In tr, this message translates to:
  /// **'Oyunu Başlat'**
  String get homeStartGame;

  /// No description provided for @homeSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get homeSettings;

  /// No description provided for @homeWords.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeler'**
  String get homeWords;

  /// No description provided for @homeStatistics.
  ///
  /// In tr, this message translates to:
  /// **'İstatistikler'**
  String get homeStatistics;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Ayarları'**
  String get settingsTitle;

  /// No description provided for @settingsLoadError.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar yüklenirken hata oluştu: '**
  String get settingsLoadError;

  /// No description provided for @settingsGameDuration.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Süresi'**
  String get settingsGameDuration;

  /// No description provided for @settingsMaxPasses.
  ///
  /// In tr, this message translates to:
  /// **'Maksimum Pas: {count}'**
  String settingsMaxPasses(int count);

  /// No description provided for @settingsPassesLabel.
  ///
  /// In tr, this message translates to:
  /// **'{count} pas'**
  String settingsPassesLabel(int count);

  /// No description provided for @settingsPassSettings.
  ///
  /// In tr, this message translates to:
  /// **'Pas Geçme Ayarları'**
  String get settingsPassSettings;

  /// No description provided for @settingsPassPenalty.
  ///
  /// In tr, this message translates to:
  /// **'Pas Cezası: {seconds} saniye'**
  String settingsPassPenalty(int seconds);

  /// No description provided for @settingsWordSettings.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Ayarları'**
  String get settingsWordSettings;

  /// No description provided for @settingsShuffleWords.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeleri Karıştır'**
  String get settingsShuffleWords;

  /// No description provided for @settingsShuffleHint.
  ///
  /// In tr, this message translates to:
  /// **'Her oyun başlangıcında kelime sırası rastgele olur.'**
  String get settingsShuffleHint;

  /// No description provided for @settingsLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get settingsLanguageTurkish;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageArabic.
  ///
  /// In tr, this message translates to:
  /// **'Arapça'**
  String get settingsLanguageArabic;

  /// No description provided for @settingsLanguageGerman.
  ///
  /// In tr, this message translates to:
  /// **'Almanca'**
  String get settingsLanguageGerman;

  /// No description provided for @settingsLanguageFrench.
  ///
  /// In tr, this message translates to:
  /// **'Fransızca'**
  String get settingsLanguageFrench;

  /// No description provided for @settingsLanguageIndonesian.
  ///
  /// In tr, this message translates to:
  /// **'Endonezce'**
  String get settingsLanguageIndonesian;

  /// No description provided for @statisticsTitle.
  ///
  /// In tr, this message translates to:
  /// **'İstatistikler'**
  String get statisticsTitle;

  /// No description provided for @statisticsLoadError.
  ///
  /// In tr, this message translates to:
  /// **'İstatistikler yüklenirken hata oluştu: '**
  String get statisticsLoadError;

  /// No description provided for @statisticsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz İstatistik Yok'**
  String get statisticsEmptyTitle;

  /// No description provided for @statisticsEmptySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyun bitince istatistikler burada görünecek'**
  String get statisticsEmptySubtitle;

  /// No description provided for @statisticsDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'İstatistiği Sil'**
  String get statisticsDeleteTitle;

  /// No description provided for @statisticsDeleteSuccess.
  ///
  /// In tr, this message translates to:
  /// **'İstatistik başarıyla silindi'**
  String get statisticsDeleteSuccess;

  /// No description provided for @statisticsDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'{date} tarihli oyuna ait istatistiği silmek istediğinizden emin misiniz?'**
  String statisticsDeleteConfirm(String date);

  /// No description provided for @statisticsDetailedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Detaylı İstatistikler'**
  String get statisticsDetailedTitle;

  /// No description provided for @statisticsCorrectWords.
  ///
  /// In tr, this message translates to:
  /// **'Doğru Bilinen Kelimeler'**
  String get statisticsCorrectWords;

  /// No description provided for @statisticsCorrect.
  ///
  /// In tr, this message translates to:
  /// **'Doğru Bilinen'**
  String get statisticsCorrect;

  /// No description provided for @statisticsPassedWords.
  ///
  /// In tr, this message translates to:
  /// **'Pas Geçilen Kelimeler'**
  String get statisticsPassedWords;

  /// No description provided for @statisticsPassed.
  ///
  /// In tr, this message translates to:
  /// **'Pas Geçilen'**
  String get statisticsPassed;

  /// No description provided for @statisticsHighScore.
  ///
  /// In tr, this message translates to:
  /// **'En Yüksek Skor'**
  String get statisticsHighScore;

  /// No description provided for @statisticsTime.
  ///
  /// In tr, this message translates to:
  /// **'Süre'**
  String get statisticsTime;

  /// No description provided for @statisticsTeamScores.
  ///
  /// In tr, this message translates to:
  /// **'Takım Skorları'**
  String get statisticsTeamScores;

  /// No description provided for @statisticsWinnerTeam.
  ///
  /// In tr, this message translates to:
  /// **'Kazanan Takım'**
  String get statisticsWinnerTeam;

  /// No description provided for @statisticsTeamPerformance.
  ///
  /// In tr, this message translates to:
  /// **'Takım Performansları'**
  String get statisticsTeamPerformance;

  /// No description provided for @statisticsWordDetails.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Detayları'**
  String get statisticsWordDetails;

  /// No description provided for @statisticsCorrectCount.
  ///
  /// In tr, this message translates to:
  /// **'Doğru Sayısı'**
  String get statisticsCorrectCount;

  /// No description provided for @statisticsPassCount.
  ///
  /// In tr, this message translates to:
  /// **'Pas Sayısı'**
  String get statisticsPassCount;

  /// No description provided for @statisticsTabuCount.
  ///
  /// In tr, this message translates to:
  /// **'Tabu Sayısı'**
  String get statisticsTabuCount;

  /// No description provided for @statisticsGameDate.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Tarihi'**
  String get statisticsGameDate;

  /// No description provided for @statisticsScore.
  ///
  /// In tr, this message translates to:
  /// **'Skor'**
  String get statisticsScore;

  /// No description provided for @statisticsNone.
  ///
  /// In tr, this message translates to:
  /// **'Yok'**
  String get statisticsNone;

  /// No description provided for @statisticsDurationSeconds.
  ///
  /// In tr, this message translates to:
  /// **'{count} saniye'**
  String statisticsDurationSeconds(int count);

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @teamSetupTitle.
  ///
  /// In tr, this message translates to:
  /// **'TAKIMLARINI OLUŞTUR'**
  String get teamSetupTitle;

  /// No description provided for @teamSetupHowMany.
  ///
  /// In tr, this message translates to:
  /// **'Kaç takım yarışacak?'**
  String get teamSetupHowMany;

  /// No description provided for @teamSetupDefaultName.
  ///
  /// In tr, this message translates to:
  /// **'{index}. Takım'**
  String teamSetupDefaultName(int index);

  /// No description provided for @gameErrorOccurred.
  ///
  /// In tr, this message translates to:
  /// **'Bir Hata Oluştu:\n\n'**
  String get gameErrorOccurred;

  /// No description provided for @gameNewGame.
  ///
  /// In tr, this message translates to:
  /// **'YENİ OYUN'**
  String get gameNewGame;

  /// No description provided for @gameOver.
  ///
  /// In tr, this message translates to:
  /// **'OYUN BİTTİ'**
  String get gameOver;

  /// No description provided for @gameOverHero.
  ///
  /// In tr, this message translates to:
  /// **'MUHTEŞEM BİR MÜCADELEYDİ'**
  String get gameOverHero;

  /// No description provided for @gameOverExit.
  ///
  /// In tr, this message translates to:
  /// **'ÇIKIŞ'**
  String get gameOverExit;

  /// No description provided for @gameOverAgain.
  ///
  /// In tr, this message translates to:
  /// **'BİR DAHA'**
  String get gameOverAgain;

  /// No description provided for @gameReadyHeader.
  ///
  /// In tr, this message translates to:
  /// **'GÜNCEL SKORLAR'**
  String get gameReadyHeader;

  /// No description provided for @gameReadyNextTeam.
  ///
  /// In tr, this message translates to:
  /// **'SIRADAKİ TAKIM'**
  String get gameReadyNextTeam;

  /// No description provided for @gameReadyStart.
  ///
  /// In tr, this message translates to:
  /// **'BAŞLA'**
  String get gameReadyStart;

  /// No description provided for @gameTeamReady.
  ///
  /// In tr, this message translates to:
  /// **'{teamName} Hazır'**
  String gameTeamReady(String teamName);

  /// No description provided for @gameTeamPlaying.
  ///
  /// In tr, this message translates to:
  /// **'{teamName} Oynuyor'**
  String gameTeamPlaying(String teamName);

  /// No description provided for @gameStatusFinished.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Bitti'**
  String get gameStatusFinished;

  /// No description provided for @gameTeamSelection.
  ///
  /// In tr, this message translates to:
  /// **'Takım Seçimi'**
  String get gameTeamSelection;

  /// No description provided for @gamePaused.
  ///
  /// In tr, this message translates to:
  /// **'Duraklatıldı'**
  String get gamePaused;

  /// No description provided for @gameCorrect.
  ///
  /// In tr, this message translates to:
  /// **'Doğru'**
  String get gameCorrect;

  /// No description provided for @gamePass.
  ///
  /// In tr, this message translates to:
  /// **'Pas'**
  String get gamePass;

  /// No description provided for @gameTabu.
  ///
  /// In tr, this message translates to:
  /// **'Tabu'**
  String get gameTabu;

  /// No description provided for @gameResume.
  ///
  /// In tr, this message translates to:
  /// **'DEVAM ET'**
  String get gameResume;

  /// No description provided for @gamePassCount.
  ///
  /// In tr, this message translates to:
  /// **'Pas ({used}/{max})'**
  String gamePassCount(int used, int max);

  /// No description provided for @gameForbiddenHeader.
  ///
  /// In tr, this message translates to:
  /// **'YASAKLI KELİMELER'**
  String get gameForbiddenHeader;

  /// No description provided for @gameNoWordsFound.
  ///
  /// In tr, this message translates to:
  /// **'Kelime bulunamadı.'**
  String get gameNoWordsFound;

  /// No description provided for @gameWordsLoadFail.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeler yüklenemedi.'**
  String get gameWordsLoadFail;

  /// No description provided for @gameWordsLoadError.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeler yüklenirken hata oluştu: {error}'**
  String gameWordsLoadError(String error);

  /// No description provided for @gameNoWordsAddPrompt.
  ///
  /// In tr, this message translates to:
  /// **'Kelime bulunamadı. Lütfen kelime yönetimi sayfasından kelime ekleyin.'**
  String get gameNoWordsAddPrompt;

  /// No description provided for @exitConfirmExitTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyunu bitirip skor tablosuna gitmek istediğinize emin misiniz?'**
  String get exitConfirmExitTitle;

  /// No description provided for @exitConfirmUnevenTitle.
  ///
  /// In tr, this message translates to:
  /// **'Her takım eşit sayıda tur oynamadı. Yine de çıkmak istediğinize emin misiniz?'**
  String get exitConfirmUnevenTitle;

  /// No description provided for @wordsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Yönetimi'**
  String get wordsTitle;

  /// No description provided for @wordsEditTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeyi Düzenle'**
  String get wordsEditTitle;

  /// No description provided for @wordsResetList.
  ///
  /// In tr, this message translates to:
  /// **'Listeyi Sıfırla'**
  String get wordsResetList;

  /// No description provided for @wordsBulkImport.
  ///
  /// In tr, this message translates to:
  /// **'Toplu Yükleme'**
  String get wordsBulkImport;

  /// No description provided for @wordsBulkImportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Toplu Kelime Yükleme'**
  String get wordsBulkImportTitle;

  /// No description provided for @wordsLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kelime'**
  String get wordsLabel;

  /// No description provided for @wordsCancelEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenlemeyi İptal Et'**
  String get wordsCancelEdit;

  /// No description provided for @wordsSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get wordsSave;

  /// No description provided for @wordsUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get wordsUpdate;

  /// No description provided for @wordsEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get wordsEdit;

  /// No description provided for @wordsAddButton.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get wordsAddButton;

  /// No description provided for @wordsForbiddenLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yasaklı Kelime'**
  String get wordsForbiddenLabel;

  /// No description provided for @wordsForbiddenList.
  ///
  /// In tr, this message translates to:
  /// **'Yasaklı Kelimeler:'**
  String get wordsForbiddenList;

  /// No description provided for @wordsForbiddenEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz yasaklı kelime eklenmedi.'**
  String get wordsForbiddenEmpty;

  /// No description provided for @wordsForbiddenCount.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, =1{{count} yasaklı kelime} other{{count} yasaklı kelime}}'**
  String wordsForbiddenCount(int count);

  /// No description provided for @wordsAddPrompt.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeyi girin ve en az bir yasaklı kelime ekleyin'**
  String get wordsAddPrompt;

  /// No description provided for @wordsAddSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kelime başarıyla eklendi'**
  String get wordsAddSuccess;

  /// No description provided for @wordsUpdateSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Kelime başarıyla güncellendi'**
  String get wordsUpdateSuccess;

  /// No description provided for @wordsDeleteSuccess.
  ///
  /// In tr, this message translates to:
  /// **'Kelime başarıyla silindi'**
  String get wordsDeleteSuccess;

  /// No description provided for @wordsDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bu kelimeyi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'**
  String get wordsDeleteConfirm;

  /// No description provided for @wordsForbiddenDuplicate.
  ///
  /// In tr, this message translates to:
  /// **'Bu yasaklı kelime zaten eklenmiş'**
  String get wordsForbiddenDuplicate;

  /// No description provided for @wordsEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kaydedilmiş kelime yok.'**
  String get wordsEmpty;

  /// No description provided for @wordsSavedCount.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilmiş Kelimeler ({count})'**
  String wordsSavedCount(int count);

  /// No description provided for @bulkPasteHint.
  ///
  /// In tr, this message translates to:
  /// **'JSON verisini buraya yapıştırın...'**
  String get bulkPasteHint;

  /// No description provided for @bulkPaste.
  ///
  /// In tr, this message translates to:
  /// **'Yapıştır'**
  String get bulkPaste;

  /// No description provided for @bulkCancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get bulkCancel;

  /// No description provided for @bulkImport.
  ///
  /// In tr, this message translates to:
  /// **'İçe Aktar'**
  String get bulkImport;

  /// No description provided for @bulkEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen JSON verisini girin.'**
  String get bulkEmpty;

  /// No description provided for @bulkInvalidFormat.
  ///
  /// In tr, this message translates to:
  /// **'Geçersiz JSON formatı. Her öğe \"word\" ve \"forbiddenWords\" (liste) içermelidir.'**
  String get bulkInvalidFormat;

  /// No description provided for @bulkJsonError.
  ///
  /// In tr, this message translates to:
  /// **'JSON Format Hatası: {message}'**
  String bulkJsonError(String message);

  /// No description provided for @bulkImportError.
  ///
  /// In tr, this message translates to:
  /// **'İçe aktarma sırasında bir hata oluştu: {error}'**
  String bulkImportError(String error);

  /// No description provided for @bulkImportResult.
  ///
  /// In tr, this message translates to:
  /// **'{success} kelime başarıyla, {errors} kelime hatayla içe aktarıldı.'**
  String bulkImportResult(int success, int errors);

  /// No description provided for @dialogConfirmDelete.
  ///
  /// In tr, this message translates to:
  /// **'Evet, Sil'**
  String get dialogConfirmDelete;

  /// No description provided for @dialogCancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get dialogCancel;

  /// No description provided for @dialogWarning.
  ///
  /// In tr, this message translates to:
  /// **'Dikkat!'**
  String get dialogWarning;

  /// No description provided for @dialogYes.
  ///
  /// In tr, this message translates to:
  /// **'EVET'**
  String get dialogYes;

  /// No description provided for @dialogNo.
  ///
  /// In tr, this message translates to:
  /// **'HAYIR'**
  String get dialogNo;

  /// No description provided for @easterEggSurprise.
  ///
  /// In tr, this message translates to:
  /// **'Sürpriz!'**
  String get easterEggSurprise;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'fr',
        'id',
        'tr'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
