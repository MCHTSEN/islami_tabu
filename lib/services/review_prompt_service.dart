import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';

/// Native in-app review akışını yöneten servis.
///
/// Hive `review_prompt` box'ında tutulan durum:
/// - `games_played` (int): tamamlanmış oyun sayısı.
/// - `last_shown_at` (int): son popup zamanı (ms epoch). null → hiç gösterilmedi.
/// - `rated` (bool): kullanıcı "Değerlendir" dedi mi? true → bir daha sorma.
///
/// Eligibility:
/// 1. `rated == true` → asla sorma.
/// 2. `games_played < _minGames` → bekle.
/// 3. `last_shown_at` boşsa veya `_cooldown` geçmişse → göster.
class ReviewPromptService {
  static const String _boxName = 'review_prompt';
  static const String _kGamesPlayed = 'games_played';
  static const String _kLastShownAt = 'last_shown_at';
  static const String _kRated = 'rated';

  static const int _minGames = 1;

  const ReviewPromptService();

  Future<Box> _box() async {
    if (Hive.isBoxOpen(_boxName)) return Hive.box(_boxName);
    return Hive.openBox(_boxName);
  }

  /// Oyun bittiğinde çağır. Sayaç artar.
  Future<void> recordGameCompleted() async {
    final box = await _box();
    final current = (box.get(_kGamesPlayed) as int?) ?? 0;
    await box.put(_kGamesPlayed, current + 1);
  }

  /// Pop-up gösterilmeli mi?
  ///
  /// Kullanıcı "Değerlendir" diyene kadar her oyun sonu (minGames sonrası) gösterilir.
  /// "Daha sonra" cooldown yok — kullanıcı yorum verene kadar tekrarlanır.
  Future<bool> shouldShowPrompt() async {
    final box = await _box();
    if (box.get(_kRated) == true) return false;
    final games = (box.get(_kGamesPlayed) as int?) ?? 0;
    return games >= _minGames;
  }

  /// Pop-up gösterildi — cooldown sayacını başlat.
  Future<void> markPromptShown() async {
    final box = await _box();
    await box.put(_kLastShownAt, DateTime.now().millisecondsSinceEpoch);
  }

  /// Native review UI'ı tetikle. Apple/Google kendi throttle'ını uygular
  /// (iOS yılda 3 kez, Play Console kendi kısıtı). Biz `rated` bayrağını
  /// set etmiyoruz — platform "yeterince soruldu" deyince kendisi gizler.
  Future<void> launchReview() async {
    final review = InAppReview.instance;
    if (await review.isAvailable()) {
      await review.requestReview();
    }
  }
}
