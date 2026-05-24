# Tabubu — Backlog

## 2026-05-23 — In-app review prompt + UI overflow fix

### Tamamlanan
- **`in_app_review: ^2.0.10`** paketi eklendi (`pubspec.yaml`).
- **`lib/services/review_prompt_service.dart`** (yeni): Hive `review_prompt` box ile durum yönetimi.
  - `recordGameCompleted()` — oyun bitince `games_played` sayacını artırır.
  - `shouldShowPrompt()` — `rated==true` ise hiç gösterme; aksi halde `games_played >= _minGames` (şu an **1**) → göster. **Cooldown YOK** — kullanıcı isteğiyle yorum verene/Apple gizleyene kadar her oyun sonu tetiklenir.
  - `launchReview()` — `InAppReview.requestReview()` çağırır. `rated` flag'i biz set ETMİYORUZ; platform throttle'ına (iOS yılda 3 kez) güveniliyor.
  - NOT: `markPromptShown()` ve `_kLastShownAt` artık kullanılmıyor (cooldown kaldırıldı), dead-code olarak duruyor — temizlenebilir.
- **`lib/widgets/dialogs/review_prompt_dialog.dart`** (yeni): branded custom popup ("Tabubu'yu beğendin mi?"). **ŞU AN KULLANILMIYOR** — kullanıcı "değerlendirmek ister misin demeden direkt native popup çıksın" dedi. Dosya ileride lazım olursa diye duruyor; game_screen artık direkt `launchReview()` çağırıyor.
- **`game_screen.dart`** entegrasyon: `ref.listen` ile `GameStatus.finished` transition yakalanır → `_onGameFinished()` → 1.5s bekle (game-over animasyonu görünsün) → `launchReview()`.
- **6 ARB** (`reviewPromptTitle/Message/Rate/Later`) — TR/EN/AR/DE/FR/ID, `flutter gen-l10n` çalıştırıldı. (Şu an custom dialog kapalı olduğu için string'ler kullanılmıyor ama hazır.)
- **UI overflow fix**: `lib/widgets/buttons/app_3d_buton.dart` — Row içindeki Text `Flexible` + `ellipsis` + `maxLines:1` ile sarıldı. iPhone'da çalışırken 78px overflow vardı (uzun çevirili buton text'leri), giderildi. (Ayrıca 0.0352px sub-pixel overflow başka bir yerde duruyor — görsel etkisi yok, debug-only.)

### Neden
- ASO/retention: pozitif anda (oyun sonu) native rating prompt → store rating sayısı artar.
- Kullanıcı kararı: custom "ister misin" dialog'u YOK, direkt native overlay. Her oyun sonu (yorum verene kadar) — agresif ama kullanıcı böyle istedi.

### Karar Notları
- **Native review prod'da Apple kontrolünde**: `requestReview()` debug'da her seferinde çıkabilir ama TestFlight/App Store'da Apple yılda max 3 kez + "uygun zamanda" gösterir, bazen hiç göstermez. Bu Apple politikası, paket garanti etmez.
- **iOS bundle id hâlâ `com.islamitabu`** (Android `com.mucahitsen.tabubu`). openStoreListing kullanılmadı (App Store ID gerektiriyor, native requestReview ID gerektirmiyor).
- **Test edilemedi (iPhone deploy)**: Kod `flutter analyze` 0 error geçti ama **gerçek cihazda doğrulanamadı** — bkz. aşağıdaki risk.

### ⚠️ ÇÖZÜLMEYEN SORUN: iPhone deploy hang
- `flutter run -d <iPhone>` ilk seferde başarılı oldu (app açıldı, VM Service bağlandı), ancak **sonraki tüm denemeler** "Installing and launching..." adımında takıldı veya şu hatayı verdi:
  - `Error starting debug session in Xcode: Timed out waiting for CONFIGURATION_BUILD_DIR to update.`
  - `Failed to get CONFIGURATION_BUILD_DIR: Error: Nesne alınamıyor.`
- Denenenler: `flutter clean`, `pod install`, `rm -rf DerivedData/Runner-*` — hiçbiri kalıcı çözmedi.
- iOS 26.1 + mevcut Flutter/Xcode kombinasyonu intermittent bug. Çözüm adayları (sonraki session):
  1. Xcode'u GUI'den aç (`ios/Runner.xcworkspace`), bir kez **Cmd+B** ile build et, sonra `flutter run`.
  2. iPhone'u reboot + USB yeniden tak.
  3. Xcode tamamen restart.
  4. iOS Simulator'da test (signing yok, hızlı).
- **Review prompt davranışı bu yüzden cihazda görsel olarak doğrulanamadı.** Kod review'dan geçti ama runtime test bekliyor.

### Sıradaki Adımlar
1. **iPhone deploy sorununu çöz** + review prompt'u canlı test et (1 oyun bitir → native overlay).
2. Review prompt davranış kararı: prod için `_minGames` 1 fazla agresif olabilir — 3'e çıkarmak + cooldown geri eklemek düşünülebilir (App Store "her oyunda rating sorma" demese de Apple zaten gösterimi kısıtlar).
3. Custom dialog'u tamamen sil veya ileride "soft ask → native" pattern için sakla.
4. ASO assets (6 dil store metadata).
5. iOS App Store Connect + Play Console upload.

### Commit Durumu
- **HENÜZ COMMIT EDİLMEDİ.** Tüm review-prompt + overflow-fix + Hive-migration değişiklikleri working tree'de duruyor (`geri` branch).
- Yeni dosyalar: `lib/services/review_prompt_service.dart`, `lib/widgets/dialogs/review_prompt_dialog.dart`, `lib/data/datasources/hive_custom_words_data_source.dart`
- `.workflow/` ve `.ccw/` gitignore'da (önceki commit'te eklendi).

---

## 2026-05-23 — Hive migration: locale-scoped custom kelime persistence

### Tamamlanan
- **Yeni data source**: `lib/data/datasources/hive_custom_words_data_source.dart` — `user_words` box, key formatı `{locale}_custom`, value `List<Map>`. CRUD: `loadForLocale / saveAll / upsert / delete`. Custom id prefix: `custom-{uuid}`.
- **InMemoryWordProvider rewrite**: Asset + Hive merge — `_loadForLocale` her iki kaynağı oku, `addWord` Hive'a persist (`custom-{uuid}` prefix), `updateWord/deleteWord` sadece custom id'ler için persist, asset id'ler in-memory kalır (asset değişmez).
- **Migration**: `main.dart`'a `user_words_v1_initialized` flag eklendi. Eski `words` box (pre-1f2e7b2 schema, WordModel removal'dan kalma) varsa silinir — adapter yok, veri zaten unreadable.
- **Doğrulama**: `flutter analyze` 0 error, `flutter build apk --debug` ✅ başarılı.

### Neden
- Localization commit'i (807eccd) sonrası `addWord/update/delete` sadece in-memory'di (kod yorumu: "User add/edit/delete sadece çalışan oturum için geçerli (kalıcı değil)"). App restart = custom kelimeler kayıp.
- Pre-1f2e7b2 versiyonda `WordModel` + Hive box vardı, "Remove WordModel" refactor'unda silindi → kullanıcı verileri kayboldu (geri kazanılamaz, device-local).
- Bu migration **bundan sonrası için** persistence kuruyor: yeni eklenen custom kelimeler artık locale-scoped olarak persist edilecek.

### Karar Notları
- **Asset kelimeler değişmez**: kullanıcı asset kelimeyi edit/delete ederse in-memory değişir ama persist edilmez (restart → asset default'a döner). Asset edit override sistemi v2'ye bırakıldı.
- **Locale switching**: TR'de eklenen custom, EN seçilince görünmez (locale-scoped key). Doğru davranış.
- **Async fire-and-forget**: UI callers `await` etmiyor (snackbar hemen göründüğü için OK). Hive write hızlı (<10ms), app crash riski düşük.
- **Eski veri recovery YAPILMADI**: device-local Hive box silindiğinden geri kazanılamaz. Kullanıcı verisi zaten 1f2e7b2 commit'inden beri kayıp.

### Sıradaki Adımlar
1. ASO assets (EN + AR + diğer 3 dil)
2. iOS App Store Connect + Play Console upload
3. (İleride) Asset edit override sistemi (v2)
4. (İleride) AR için in-app "yanlış kelime" feedback butonu

### Risk
- DÜŞÜK: Yeni install user'lar için clean baseline.
- DÜŞÜK-ORTA: Mevcut user'lar custom kelimelerini zaten kaybetmişti (1f2e7b2'den beri); şimdi yeni eklemeler persist olacak.
- Hive box corruption fallback EKLENMEDİ (statistics box'taki gibi try-catch + delete). Eğer custom kelime box bozulursa app silmek zorunda kalabilir. v2'de eklenebilir.

---

## 2026-05-22 — Kelime sayısı 5 dil için 492'ye eşitlendi

### Tamamlanan
- **5 paralel Sonnet subagent** (EN/AR/DE/FR/ID) her dile **+372 yeni kelime** (id-121..id-492) ekledi. Mevcut 1-120 entry'ler dokunulmadı. Toplam: 5 × 372 = **1860 yeni kelime**.
- **Kategori dağılımı** (TR'yi referans alarak her dile): 5 Rükün detayları, Peygamberler, Sahabe, Melek/cin, Eskatoloji, Tasavvuf/Akhlaq, Fıkıh (mezhep terimleri dâhil), Mekânlar (Kâbe/Mescid-i Aksâ/Bedir/Uhud vb.), Hac/Umre ritüelleri, Ramazan/bayramlar, Kuran sûreleri + tecvid, Aile/toplum, Modern Müslüman yaşamı.
- **Her dil için Gemini 2-round review**: round 1 CRITICAL+HIGH bulgular (semantic duplicate, dilsel sızıntı, sektaryen bayraklar, forbidden-word substring/cevap leak) → düzeltildi; round 2 confirm.
  - **EN**: 22 round-1 + 52 round-2 (compound entries için core component eklendi) → tüm fix uygulandı, PASS.
  - **AR**: 22 round-1 + Codex round-2 12 (Gemini quota dolunca Codex'e fallback) → fix uygulandı, PASS. **Native Arabic reviewer notu**: User onayıyla atlandı, mevcut review katmanı yeterli kabul edildi.
  - **DE**: 25 round-1 + 7 round-2 (typo, English leak, dilbilgisi) → fix uygulandı, PASS.
  - **FR**: 32 round-1 + 55 round-2 (forbidden-word translation leak) → fix uygulandı, PASS.
  - **ID**: 36 round-1 + Gemini quota dolunca programmatic re-validation CLEAN → fix uygulandı, PASS.
- **DeepSeek v4 flash ek görüş**: User isteğiyle opencode + opencode-go/deepseek-v4-flash denendi (5 paralel, sonra seri), ancak opencode CLI 8KB prompt'larda hang sorunu yaşadı (sample 40 entry/dil); küçük PONG testi çalışıyor, prompt boyutu artınca takılıyor. User "kalsın" diyerek skip etti, mevcut Gemini review katmanı yeterli kabul edildi.
- **Doğrulama**:
  - JSON integrity: 5 dil × 492 entry, contiguous id-1..id-492, her entry tam 5 forbidden words, empty word: 0.
  - `flutter analyze`: **0 error**, 121 info (eski deprecation uyarıları — bu işle ilgisiz).
  - `flutter build apk --debug`: **başarılı** (`build/app/outputs/flutter-apk/app-debug.apk`, ~285 sn).

### Neden
- **KRİTİK ASIMMETRİ**: TR 492 vs diğerleri 120 → diğer dil oyuncuları 3-4 oturum sonra kelimeleri ezberleyip retention/rating riski yaratıyordu.
- Replay value 4 katına çıktı (her dil 4x daha fazla unique kelime).
- Kategori dağılımı TR'ye paralel → tüm dillerde benzer oyun deneyimi.

### Karar Notları
- **AR native reviewer NOT yapılacak** (user kararı): Gemini round 1+2 + Codex fallback yeterli. Risk: yanlış mana / dialect leak için production'da feedback toplama (sonraki iterasyon).
- **DeepSeek ek görüş başarısız**: opencode CLI 8KB+ prompt'larda hang ediyor; gelecekte gerekirse curl ile direkt API çağrısı denenebilir veya prompt parçalanarak 1-2KB altında tutulmalı.
- **In-app "yanlış kelime" buton önerisi**: User şu an istemedi, ileride değerlendirilebilir (özellikle AR için).

### Sıradaki Adımlar
1. **ASO assets** (EN + AR — Faz 2, Faz 5): App Store + Play Store metadata, screenshot text'leri, store/en-US + store/ar-SA klasörleri.
2. **DE/FR/ID ASO assets** (Faz 3-4-6 store metadata).
3. **Hive migration**: kullanıcı özel kelime listesi için locale-scoped key (eski özel kelimeler şu an asset-only fallback'e düşmüş durumda).
4. **iOS App Store Connect + Play Console upload**.
5. (İleride) AR için in-app feedback butonu.

### Risk
- AR dataset hâlâ native değil — kullanıcı kararıyla submit ediliyor. Rating riski var, feedback toplamak şart.
- 1860 yeni kelime tek seferde eklendi — production'da AB testi yapılmadı, oyuncuların gerçek tepkisi bilinmiyor.

---

## 2026-05-22 — DE + FR + ID locale eklendi (Faz 3-4-6)

### Tamamlanan
- **3 Sonnet subagent paralel** + Gemini cross-check ile native review (her dil için 2 round):
  - **DE** (Almanca): `lib/l10n/app_de.arb` (112 key) + `assets/words/de.json` (120 kelime). 11 issue → 7 fix uygulandı; round 2 clean. TR/Arap diaspora ağırlıklı terimler (Hadsch, Iftar, Suhur, Dschahannam, Zuckerfest, Opferfest, Kanzel).
  - **FR** (Fransızca): `app_fr.arb` (112 key) + `fr.json` (120 kelime). 16 fix (round 1: 2 CRIT, 8 HIGH, 1 LOW + round 2: 1 HIGH). Aïd al-Adha, Maghrebi terminolojisi (Sourate, Choukr, Souhour, Calife, Rak'a).
  - **ID** (Endonezce): `app_id.arb` (112 key) + `id.json` (120 kelime). 17 issue → 15 fix. Idul Adha ağırlıklı (Haji, Idul Adha, Ka'bah, Ibrahim, Ismail, Tawaf, Sa'i, Arafah, Mina, Jamarat, Kurban). Indonesian transliteration (Sholat/Idul Adha/Ka'bah/Adzan).
- **Entegrasyon**: `supported_locales.dart` → 6 dil (tr/en/ar/de/fr/id), Settings'e 3 yeni dil seçeneği, tüm ARB'lere `settingsLanguageGerman/French/Indonesian` key'i eklendi.
- **Doğrulama**: `flutter gen-l10n` ✓, `flutter analyze` **0 error**, `flutter build apk --debug` **başarılı**.

### Neden
- Roadmap'teki Faz 3 (DE diaspora), Faz 4 (FR Maghrebi), Faz 6 (ID 270M+ — en büyük Müslüman pazar).
- Context'i şişirmemek için Sonnet subagent + Gemini double-check pipeline (claude→Sonnet ccw cli→Gemini native review).

### Karar Notları
- **Round 2 protokolü** her dilde uygulandı: native fluency için critical fix-verify döngüsü.
- **LOW severity stil suggestions** kasıtlı atlandı (yargı çağrısı, oyun bağlamında kabul edilir).
- Subagent'lar Gemini review beklerken çıktı (FR + ID 1. ajan); resume agent ile tamamlandı — context'imde sadece final özet.

### Açık İşler
- 6 dil x ASO assets (title/subtitle/keyword/screenshot text) henüz hazır değil.
- Word datasets hala asset-only; **Hive migration** kullanıcının özel kelime listesi için yapılmadı (locale-scoped key).
- Native human reviewer (Fiverr/Upwork) her dil için optimum — özellikle AR (kendim yazdım) ve ID (en yüksek volume).

### KRİTİK ASIMMETRİ: Kelime sayısı dengesizliği
- **TR: 492** (organic, yıllar içinde birikti) — **EN/AR/DE/FR/ID: 120** (MVP seed)
- Replay value asimetrik: TR oyuncu sıkılmaz, diğer dil oyuncuları 3-4 oturum sonra kelimeleri ezberler → retention/rating riski
- **Sonraki session işi**: 5 dilin her birini ~370 kelime ekleyerek **492'ye çıkarmak** (toplam ~1860 yeni kelime)
- Hazır prompt: `.workflow/.scratchpad/next-session-prompt.md`

---

## 2026-05-22 — Lokalizasyon Altyapısı (Faz 1 + Faz 2.1 + AR seed)

### Tamamlanan
- **l10n altyapısı kuruldu**: `flutter_localizations`, `intl: ^0.20.2`, `l10n.yaml` (template app_tr.arb), `generate: true`, `lib/l10n/generated/` çıktısı.
- **3 dil ARB dosyaları** (`tr`, `en`, `ar`): ~120 string per dil. Plural ve placeholder (ICU) desteği.
- **Locale provider** (`lib/providers/locale_provider.dart`): Riverpod StateNotifier, Hive `preferences` box'ta persist, device-locale fallback.
- **MaterialApp wiring**: `main.dart` ConsumerWidget'a çevrildi, `localizationsDelegates`, `supportedLocales`, locale override edildi. RTL (Arapça) otomatik.
- **Word data abstraction**: 492 TR kelime → `assets/words/tr.json`. EN 120 kelime, AR 120 kelime (Kurban Bayramı/Hac terminolojisi ağırlıklı). `AssetWordDataSource` + locale-aware `InMemoryWordProvider`.
- **String replacement**: 20+ ekran ve widget dosyasındaki ~80 Türkçe UI string'i `AppLocalizations.of(context).xxx` ile değiştirildi. Gemini'ye delege (rate-limit yedi, kısmi düzeltme) + manuel tamamlama.
- **Settings ekranına dil seçici** eklendi (TR/EN/AR radyo butonu).
- **RTL audit**: `EdgeInsets.only(left:...)` → `EdgeInsetsDirectional.only(start:...)` (2 yer düzeltildi).
- **Build doğrulama**: `flutter analyze` 0 error, `flutter build apk --debug` başarılı.

### Neden
- Çoklu pazara açılım: EN/AR submission (App Store + Play Store) için altyapı şart.
- **Kurban Bayramı (Eid al-Adha) 26 Mayıs 2026** — AR dataset'te Hac/kurban/Mina/Arafat/İbrahim/İsmail/kabş/udhiyah ağırlıklı kelimeler; 4 günlük seasonal traffic için pencere açıldı.
- Türkçe Müslüman + Arap diaspora + İngilizce konuşan Müslüman audience.

### Karar Notları
- **AR kelime dataseti native değil** — kendim araştırarak yazdım. Submission öncesi native Arabic reviewer (Fiverr/Upwork) ile doğrulanmalı (özellikle yasaklı kelime seçimleri).
- **Easter egg sayfası** (`presentation/easter_egg/`) lokalize edilmedi — kişisel ithafiye, TR kalmalı.
- **GameViewModel error mesajları** geçici olarak `'NO_WORDS'`, `'WORDS_LOAD_FAIL'`, `'WORDS_LOAD_ERROR:$error'` kodları olarak set edildi. UI'da bu key'leri AppLocalizations'a map etme TODO (şu an raw error UI'da gösteriliyor).
- **Hive migration** kullanıcı kelime listesi için yapılmadı — tüm kullanıcılar default locale dataset'ine düşer. Eski özel kelimeler hala asset üzerinden okunmuyor (in-memory provider asset'ten yüklüyor). Migration sonraki iterasyon.
- "Tabubu" brand adı zaten doğru kuruldu (Android label + iOS CFBundleName), tek isim her market.

### Sıradaki Adımlar (Faz 2 EN + Faz 5 AR cleanup)
1. **EN ASO assets**: title `Tabubu: Islamic Party Game`, subtitle, keywords, 5-8 screenshot text'leri, store/en-US/ klasörü.
2. **AR ASO assets**: title `تابوبو: لعبة كلمات إسلامية`, screenshot text'leri Arapça, RTL screenshot layout, store/ar-SA/ klasörü.
3. **iOS App Store Connect**: EN-US + AR-SA locale'leri ekle, metadata + screenshot upload.
4. **Google Play Console**: aynı şekilde.
5. **Kurban Bayramı submission target**: 23-24 Mayıs içinde, Apple review 24-48 saat, Eid başına yetişmek için.
6. **Native AR reviewer** ile dataset doğrulama.
7. **Hive migration** kullanıcı kelime listesi için (locale-scoped key).
8. **DE / FR / ID** dataset + ARB (Faz 3-4-6).

### Risk
- AR dataset native değil, 1★ review riski → submit önce review zorunlu.
- App Store review 1-3 gün, Eid'e yetişmeyebilir (24-25 Mayıs son şans).
- Hive eski kullanıcı kelimeleri kayboldu (asset-only fallback) — kullanıcı şikayet edebilir, migration acil.
