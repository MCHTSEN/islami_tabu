// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تابوبو';

  @override
  String get homeStartGame => 'ابدأ اللعبة';

  @override
  String get homeSettings => 'الإعدادات';

  @override
  String get homeWords => 'الكلمات';

  @override
  String get homeStatistics => 'الإحصائيات';

  @override
  String get settingsTitle => 'إعدادات اللعبة';

  @override
  String get settingsLoadError => 'فشل تحميل الإعدادات: ';

  @override
  String get settingsGameDuration => 'مدة الجولة';

  @override
  String settingsMaxPasses(int count) {
    return 'الحد الأقصى للتمرير: $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count تمرير';
  }

  @override
  String get settingsPassSettings => 'إعدادات التمرير';

  @override
  String settingsPassPenalty(int seconds) {
    return 'عقوبة التمرير: $seconds ثانية';
  }

  @override
  String get settingsWordSettings => 'إعدادات الكلمات';

  @override
  String get settingsShuffleWords => 'خلط الكلمات';

  @override
  String get settingsShuffleHint =>
      'يتم تغيير ترتيب الكلمات بشكل عشوائي في بداية كل لعبة.';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageTurkish => 'التركية';

  @override
  String get settingsLanguageEnglish => 'الإنجليزية';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsLanguageGerman => 'الألمانية';

  @override
  String get settingsLanguageFrench => 'الفرنسية';

  @override
  String get settingsLanguageIndonesian => 'الإندونيسية';

  @override
  String get statisticsTitle => 'الإحصائيات';

  @override
  String get statisticsLoadError => 'فشل تحميل الإحصائيات: ';

  @override
  String get statisticsEmptyTitle => 'لا توجد إحصائيات بعد';

  @override
  String get statisticsEmptySubtitle =>
      'ستظهر الإحصائيات هنا بعد انتهاء اللعبة';

  @override
  String get statisticsDeleteTitle => 'حذف الإحصائية';

  @override
  String get statisticsDeleteSuccess => 'تم حذف الإحصائية بنجاح';

  @override
  String statisticsDeleteConfirm(String date) {
    return 'هل أنت متأكد من حذف إحصائية لعبة $date؟';
  }

  @override
  String get statisticsDetailedTitle => 'إحصائيات مفصلة';

  @override
  String get statisticsCorrectWords => 'الكلمات المخمنة بشكل صحيح';

  @override
  String get statisticsCorrect => 'صحيح';

  @override
  String get statisticsPassedWords => 'الكلمات المتجاوزة';

  @override
  String get statisticsPassed => 'تم تجاوزها';

  @override
  String get statisticsHighScore => 'أعلى نتيجة';

  @override
  String get statisticsTime => 'الوقت';

  @override
  String get statisticsTeamScores => 'نتائج الفرق';

  @override
  String get statisticsWinnerTeam => 'الفريق الفائز';

  @override
  String get statisticsTeamPerformance => 'أداء الفريق';

  @override
  String get statisticsWordDetails => 'تفاصيل الكلمة';

  @override
  String get statisticsCorrectCount => 'صحيح';

  @override
  String get statisticsPassCount => 'تمرير';

  @override
  String get statisticsTabuCount => 'تابو';

  @override
  String get statisticsGameDate => 'تاريخ اللعبة';

  @override
  String get statisticsScore => 'النتيجة';

  @override
  String get statisticsNone => 'لا يوجد';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count ثانية';
  }

  @override
  String get commonClose => 'إغلاق';

  @override
  String get teamSetupTitle => 'كوّن فرقك';

  @override
  String get teamSetupHowMany => 'كم فريقاً سيتنافس؟';

  @override
  String teamSetupDefaultName(int index) {
    return 'الفريق $index';
  }

  @override
  String get gameErrorOccurred => 'حدث خطأ:\n\n';

  @override
  String get gameNewGame => 'لعبة جديدة';

  @override
  String get gameOver => 'انتهت اللعبة';

  @override
  String get gameOverHero => 'يا لها من مباراة!';

  @override
  String get gameOverExit => 'خروج';

  @override
  String get gameOverAgain => 'مرة أخرى';

  @override
  String get gameReadyHeader => 'النتائج الحالية';

  @override
  String get gameReadyNextTeam => 'الفريق التالي';

  @override
  String get gameReadyStart => 'ابدأ';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName جاهز';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName يلعب';
  }

  @override
  String get gameStatusFinished => 'انتهت اللعبة';

  @override
  String get gameTeamSelection => 'اختر الفريق';

  @override
  String get gamePaused => 'متوقف مؤقتاً';

  @override
  String get gameCorrect => 'صحيح';

  @override
  String get gamePass => 'تمرير';

  @override
  String get gameTabu => 'تابو';

  @override
  String get gameResume => 'استئناف';

  @override
  String gamePassCount(int used, int max) {
    return 'تمرير ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'الكلمات الممنوعة';

  @override
  String get gameNoWordsFound => 'لم يتم العثور على كلمات.';

  @override
  String get gameWordsLoadFail => 'فشل تحميل الكلمات.';

  @override
  String gameWordsLoadError(String error) {
    return 'خطأ في تحميل الكلمات: $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'لم يتم العثور على كلمات. الرجاء إضافة كلمات من صفحة إدارة الكلمات.';

  @override
  String get exitConfirmExitTitle =>
      'هل أنت متأكد من إنهاء اللعبة والذهاب إلى لوحة النتائج؟';

  @override
  String get exitConfirmUnevenTitle =>
      'لم تلعب كل الفرق نفس عدد الجولات. هل ما زلت تريد الخروج؟';

  @override
  String get wordsTitle => 'إدارة الكلمات';

  @override
  String get wordsEditTitle => 'تعديل الكلمة';

  @override
  String get wordsResetList => 'إعادة تعيين القائمة';

  @override
  String get wordsBulkImport => 'استيراد جماعي';

  @override
  String get wordsBulkImportTitle => 'استيراد كلمات جماعي';

  @override
  String get wordsLabel => 'الكلمة';

  @override
  String get wordsCancelEdit => 'إلغاء التعديل';

  @override
  String get wordsSave => 'حفظ';

  @override
  String get wordsUpdate => 'تحديث';

  @override
  String get wordsEdit => 'تعديل';

  @override
  String get wordsAddButton => 'إضافة';

  @override
  String get wordsForbiddenLabel => 'كلمة ممنوعة';

  @override
  String get wordsForbiddenList => 'الكلمات الممنوعة:';

  @override
  String get wordsForbiddenEmpty => 'لم تتم إضافة أي كلمات ممنوعة بعد.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count كلمات ممنوعة',
      two: 'كلمتان ممنوعتان',
      one: 'كلمة ممنوعة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt => 'أدخل كلمة وأضف كلمة ممنوعة واحدة على الأقل';

  @override
  String get wordsAddSuccess => 'تمت إضافة الكلمة الجديدة بنجاح';

  @override
  String get wordsUpdateSuccess => 'تم تحديث الكلمة بنجاح';

  @override
  String get wordsDeleteSuccess => 'تم حذف الكلمة بنجاح';

  @override
  String get wordsDeleteConfirm =>
      'هل أنت متأكد من حذف هذه الكلمة؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get wordsForbiddenDuplicate => 'هذه الكلمة الممنوعة مضافة بالفعل';

  @override
  String get wordsEmpty => 'لا توجد كلمات محفوظة بعد.';

  @override
  String wordsSavedCount(int count) {
    return 'الكلمات المحفوظة ($count)';
  }

  @override
  String get bulkPasteHint => 'الصق بيانات JSON هنا...';

  @override
  String get bulkPaste => 'لصق';

  @override
  String get bulkCancel => 'إلغاء';

  @override
  String get bulkImport => 'استيراد';

  @override
  String get bulkEmpty => 'الرجاء إدخال بيانات JSON.';

  @override
  String get bulkInvalidFormat =>
      'تنسيق JSON غير صالح. يجب أن يحتوي كل عنصر على \"word\" و \"forbiddenWords\" (قائمة).';

  @override
  String bulkJsonError(String message) {
    return 'خطأ في تنسيق JSON: $message';
  }

  @override
  String bulkImportError(String error) {
    return 'حدث خطأ أثناء الاستيراد: $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return 'تم استيراد $success كلمة بنجاح، فشل $errors.';
  }

  @override
  String get dialogConfirmDelete => 'نعم، احذف';

  @override
  String get dialogCancel => 'إلغاء';

  @override
  String get dialogWarning => 'تنبيه!';

  @override
  String get dialogYes => 'نعم';

  @override
  String get dialogNo => 'لا';

  @override
  String get easterEggSurprise => 'مفاجأة!';

  @override
  String get reviewPromptTitle => 'هل أعجبك تابوبو؟';

  @override
  String get reviewPromptMessage => 'إذا أعجبك، هل تدعمنا بتقييمنا في المتجر؟';

  @override
  String get reviewPromptRate => 'قيِّم';

  @override
  String get reviewPromptLater => 'لاحقًا';
}
