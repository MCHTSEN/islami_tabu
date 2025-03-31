# İslami Tabu Uygulaması - İlerleme Takibi

## 📊 MVP (Minimum Viable Product) Yol Haritası İlerlemesi

### ✅ 1. Ana Ekran Tasarımı ve Navigasyon
- [x] Ana ekranın temel tasarımını oluştur  
- [x] Oyun, Ayarlar ve Kelime Yönetimi sayfalarına yönlendiren butonlar ekle  
- [x] Sayfalar arası geçiş için `Navigator` kullan  
- [x] Kullanıcı dostu bir arayüz tasarla   
- [x] UI testleri gerçekleştir  

**Yapılan İşlemler:**
- Görsel açıdan etkileyici, koyu tonlarda bir ana ekran tasarlandı
- Animasyonlu orb butonlar ile sayfalara geçiş sağlandı
- Islamic ve holographic temalar birleştirilerek özgün bir tasarım ortaya çıkarıldı
- Responsive tasarım ile farklı ekran boyutlarına uyumlu hale getirildi
- Dinamik renk geçişleri ve animasyonlar eklendi

---

### ✅ 2. Yeni Kelime Ekleme ve Yönetim Paneli
- [x] Kullanıcıların yeni kelimeler ekleyebileceği bir form tasarla  
- [x] Kelimeye ait yasaklı kelimelerin eklenmesini sağla  
- [x] Hive kullanarak kelimeleri lokal olarak sakla  
- [x] Kelime listesini görüntüleme ve düzenleme seçenekleri ekle  
- [x] Silme ve güncelleme fonksiyonlarını oluştur  
- [x] UI testleri ve hata ayıklamaları yap  

**Yapılan İşlemler (Tarih: 31.03.2024):**
- Clean Architecture prensiplerine uygun kod yapısı kuruldu:
  - Domain katmanı (entity, repository interfaces, use cases)
  - Data katmanı (models, repository implementations)
  - Presentation katmanı (viewmodels, UI widgets)
- Hive veritabanı entegrasyonu yapıldı:
  - WordEntity domain modeli oluşturuldu
  - WordModel Hive adapteri ile uygulandı
  - TypeAdapter otomatik olarak oluşturuldu (build_runner)
- CRUD işlemleri için tüm gerekli use case'ler oluşturuldu:
  - GetWordsUseCase
  - AddWordUseCase
  - UpdateWordUseCase
  - DeleteWordUseCase
- Kelime yönetim ekranı için kullanıcı dostu arayüz tasarlandı:
  - Yeni kelime ve yasaklı kelimeler ekleme formu
  - Mevcut kelimeleri listeleme, düzenleme ve silme
  - Chip widget'ları ile yasaklı kelimelerin görsel sunumu
  - ExpansionTile ile kelime detaylarına erişim
  - RefreshIndicator ile verileri yenileme özelliği
- Error state'lerinde SelectableText.rich ile hata görüntüleme
- Riverpod StateNotifier kullanılarak state yönetimi sağlandı
- Kelimeler kategorilere göre organize edildi
- Form validasyon ile gerekli alanların doldurulması kontrolü eklendi
- Silme işlemleri için onay dialogu eklendi

**Güncellemeler (Tarih: 01.04.2024):**
- GetIt kütüphanesi ile dependency injection yapısı kuruldu:
  - ServiceLocator sınıfı oluşturuldu
  - Tüm bağımlılıklar merkezi olarak kayıt altına alındı
  - Singleton, LazySingleton ve Factory kayıt türleri kullanıldı
  - Repository'ler singleton olarak tanımlandı
  - Use case'ler lazy singleton olarak tanımlandı
  - ViewModel'ler factory olarak tanımlandı
- Riverpod provider'ları GetIt ile entegre edildi
- Daha temiz ve modüler bir yapı oluşturuldu
- Dependency injection testleri yapıldı

---

### ✅ 3. Oyun Ekranı (Kelime Gösterimi, Yasaklı Kelimeler, Süre)  
- [x] Oyun ekranının temel tasarımını oluştur  
- [x] Rastgele kelime seçimi için bir mekanizma hazırla  
- [x] Yasaklı kelimeleri ekrana listele  
- [x] Süre sayacı entegre et  
- [x] Oyuncuların geçme, doğru bilme gibi işlemleri yapabilmesi için butonlar ekle  
- [x] UI testleri ve hata ayıklamaları yap  

**Yapılan İşlemler (Tarih: 01.04.2024):**
- Oyun ekranı için domain entityleri oluşturuldu:
  - GameSettingsEntity: Oyun ayarlarını temsil eden entity
  - GameStateEntity: Oyun durumunu temsil eden entity
  - GameStatus enum: Hazır, oynuyor, duraklatıldı, bitti durumları
- Oyun için use caseler eklendi:
  - GetRandomWordsUseCase: Rastgele kelimeler getirme
  - GetAvailableCategoriesUseCase: Mevcut kategorileri getirme
  - GetGameSettingsUseCase ve SaveGameSettingsUseCase: Oyun ayarlarını yönetme
- Repository pattern uygulandı:
  - GameSettingsRepository: Oyun ayarlarını persist etme
  - GameSettingsRepositoryImpl: Hive ile implementasyon
- Riverpod state management:
  - GameViewModel: Tüm oyun mantığını ve state'i yöneten ViewModel
  - AsyncValue ile loading, error ve data durumları yönetildi
  - Zamanlayıcı, puan hesaplama, doğru/pas geçme işlemleri
- Görsel tasarım:
  - İslami tema ile uyumlu gradient arkaplan
  - Animasyonlu kelime gösterimi
  - Yasaklı kelimeler listesi
  - Süre sayacı ve durum göstergesi
  - Doğru/Pas butonları
  - Sonuç ekranı
- Özel özellikler:
  - Kelime pulser animasyonu (scale)
  - Süre cezaları ve sınırlı geçiş hakkı
  - Oyunun duraklatılabilmesi ve devam ettirilebilmesi
  - Oyun bittikten sonra detaylı istatistikler
  - Oyun tekrar başlatma mekanizması
- GetIt ile dependency injection:
  - GameSettingsModel için Hive adapter oluşturuldu
  - ServiceLocator'a yeni dependency'ler eklendi
  - Oyun ile ilgili tüm dependency'ler için uygun lifetime'lar ayarlandı

---

### ✅ 4. Oyun Ayarları  
- [x] Kullanıcının oyun süresini ayarlayabilmesi için seçenekler ekle  
- [x] Yasaklı kelime sayısını ayarlayabileceği bir seçenek sun  
- [x] Kullanıcıların kendi kelime havuzlarını oluşturmasına izin ver  
- [x] Tema ayarlarını (Dark/Light Mode) oyun içinde değiştirme imkanı tanı  
- [x] Ayarları lokal veritabanına kaydet  
- [x] UI testleri gerçekleştir  

**Yapılan İşlemler (Tarih: 02.04.2024):**
- Settings ekranı oluşturuldu:
  - Oyun süresi ayarı (30-180 saniye arası)
  - Pas geçme limiti (1-5 arası)
  - Pas cezası süresi (0-10 saniye arası)
  - Kelime karıştırma seçeneği
  - Kategori seçimi
- SettingsViewModel implementasyonu:
  - GetGameSettingsUseCase ve SaveGameSettingsUseCase entegrasyonu
  - AsyncValue ile state yönetimi
  - Tüm ayarlar için update metodları
- GetIt ile dependency injection:
  - SettingsViewModel factory olarak kaydedildi
  - Gerekli use case'ler inject edildi
- UI/UX özellikleri:
  - Slider'lar ile kolay ayar yapma
  - Switch ile boolean ayarlar
  - Dropdown ile kategori seçimi
  - İslami tema ile uyumlu tasarım
  - Responsive layout
  - Error handling ve loading states
- Hive ile lokal depolama:
  - GameSettingsModel adapter'ı
  - Otomatik kayıt ve yükleme
  - Default değerler

---

### ✅ 5. Düzeltme - game_screen.dart
- [x] game_screen.dart deki oyunu tek kişilik yapmıştık ama bu yanlış. Şu şekilde düzeltildi:
- [x] game_screen.dart açılınca kaç kişi oynanacağı seçilmeli (min 2 takım, max 8 takım)
- [x] yeni bir ekran oluşturma. game_screen.dart üzerinden devam et, gerekli değişiklikleri yap.
- [x] girilen takımların adlarını sistem otomatik olarak 1.takım, 2.takım, ... diye sırala
- [x] Ekipler arasında kelimeleri paylaşacak bir mekanizma hazırla
- [x] süresi bitince diğer takımın sırası gelsin. oyunu bitir gibi bir butona tıklayana kadar devam etsin.
- [x] oyun sonunda ekiplerin skorlarını göster
- [x] oyun sonuçlarını kaydet

**Yapılan İşlemler (Tarih: 03.04.2024):**
- Clean Architecture prensiplerine uygun olarak yeni entity'ler ve state yönetimi eklendi:
  - TeamEntity: Takım bilgilerini tutan entity
  - GameStateEntity: Çoklu takım desteği için güncellendi
  - GameStatus: Yeni setup durumu eklendi
- Takım kurulumu için yeni ekran oluşturuldu:
  - TeamSetupScreen: Takım sayısı ve isimlerini yönetme
  - Min 2, max 8 takım seçimi
  - Otomatik takım isimlendirme (1.Takım, 2.Takım, ...)
- Oyun mantığı çoklu takım için güncellendi:
  - GameViewModel: Takım bazlı puan ve kelime yönetimi
  - Sıralı takım geçişi
  - Süre bitiminde otomatik takım değişimi
  - Pas geçme ve doğru bilme işlemleri takım bazlı
- UI geliştirmeleri:
  - Aktif takım gösterimi
  - Takım puanları
  - Oyun sonu sıralaması
  - Responsive tasarım
  - Animasyonlu geçişler
- Hata yönetimi ve edge case'ler:
  - Oyun bitişi kontrolü
  - Süre kontrolü
  - Pas hakkı kontrolü
  - Kelime tükenmesi durumu

**Yapılan İyileştirmeler (Tarih: 03.04.2024 - 2):**
- Oyun akışı düzeltildi:
  - Her takım kendi süresini tam olarak kullanabilecek şekilde güncellendi
  - Süre bitiminde otomatik olarak sıradaki takıma geçiş eklendi
  - Her takım için "Hazır mısın?" ekranı eklendi
  - Takım geçişlerinde kelime havuzu korundu
- GameViewModel iyileştirmeleri:
  - moveToNextTeam metodu eklendi
  - Süre bitiminde otomatik takım geçişi
  - Her takım için pas hakları sıfırlama
  - Kelimeler bittiğinde karıştırılıp yeniden kullanma
- UI/UX geliştirmeleri:
  - Her takım için özel "Hazır mısın?" ekranı
  - Takım adı ve başlatma butonu
  - Oyun kontrollerinde iyileştirmeler
  - Daha net takım geçiş akışı
- Hata düzeltmeleri:
  - HomePage'e dönüş sorunu giderildi
  - Erken oyun bitirme sorunu çözüldü
  - Takım sırası karışması engellendi
  - Kelime havuzu yönetimi iyileştirildi

**Yapılan İyileştirmeler (Tarih: 03.04.2024 - 3):**
- Kategori sistemi kaldırıldı:
  - GameSettingsEntity'den selectedCategory alanı kaldırıldı
  - WordEntity ve WordModel'den category alanı kaldırıldı
  - GetRandomWordsUseCase'den kategori filtreleme kaldırıldı
  - Settings ekranından kategori seçimi kaldırıldı
  - WordManagementScreen'den kategori girişi kaldırıldı
  - GetAvailableCategoriesUseCase ve ilgili repository metodları kaldırıldı
  - Kelime yönetimi arayüzü sadeleştirildi
  - Tüm kelimeler tek bir havuzda toplanacak şekilde güncellendi
  - Gereksiz kod ve bağımlılıklar temizlendi

---

### 🏆 6. Puanlama Sistemi  
- [x] Doğru bilinen kelimeler için puan hesaplamasını oluştur  
- [x] Yanlış veya pas geçilen kelimeler için puan kaybı mekanizması geliştir  
- [x] Oyun sonunda toplam puanı hesaplayan bir ekran tasarla  
- [x] Ekipler için skor tablosu ekle  
- [x] UI testleri ve hata ayıklamaları yap  

**Yapılan İşlemler (Tarih: 05.04.2024):**
- Puan sisteminin mantığı iyileştirildi:
  - Her doğru kelime için 1 puan
  - Pas geçmek için maksimum hak sınırlaması
  - Pas geçme cezası olarak süre kesintisi
  - Süre bitiminde otomatik olarak diğer takıma geçiş
- Oyun sonu ekranı tasarlandı:
  - Takım puanlarını gösteren tablo
  - Skorlara göre sıralanmış takımlar
  - Kazanan takım vurgusu
  - Yeniden oynama seçeneği

---

### 📊 7. İstatistikler
- [x] Oyun sonunda ekiplerin performanslarını kaydet
- [x] İstatistik ekranı oluştur
- [x] Oyun geçmişini görüntüle
- [x] Detaylı istatistikleri görüntüle (doğru/yanlış kelime oranları, en çok bilinen kelimeler vb.)
- [x] İstatistikleri silme seçeneği ekle

**Yapılan İşlemler (Tarih: 10.04.2024):**
- Clean Architecture prensiplerine uygun olarak istatistik sistemi oluşturuldu:
  - GameStatisticsEntity: Oyun istatistiklerini temsil eden domain entity
  - GameStatisticsModel: Hive ile persistence için model sınıfı
  - GameStatisticsRepository: Veri erişim arayüzü
  - GameStatisticsRepositoryImpl: Hive ile repository implementasyonu
- İstatistik verilerini yönetmek için use case'ler eklendi:
  - GetGameStatisticsUseCase: Tüm oyun istatistiklerini getirme
  - SaveGameStatisticsUseCase: Oyun istatistiklerini kaydetme
  - DeleteGameStatisticsUseCase: İstatistik silme
- UI bileşenleri oluşturuldu:
  - StatisticsViewModel: İstatistik verilerini ve state'i yöneten ViewModel
  - StatisticsScreen: İstatistikleri görüntüleyen ana ekran
  - Boş durum yönetimi
  - Silme onayı dialog'u
  - İstatistik kartları ve detaylı istatistik görünümü
- Oyun sonunda istatistiklerin otomatik kaydedilmesi sağlandı:
  - GameViewModel'e _saveStatistics metodu eklendi
  - Oyun bitiminde istatistikleri kaydedecek mantık eklendi
  - UUID ile benzersiz istatistik ID'leri
- Detaylı istatistikler:
  - Doğru bilme/pas geçme oranları
  - Takım bazlı performans göstergeleri
  - Doğru bilinen kelimeler listesi
  - Pas geçilen kelimeler listesi
  - Zaman damgalı oyun geçmişi
- Hive entegrasyonu:
  - TeamModel ve GameStatisticsModel için Hive adapter'ları oluşturuldu
  - TypeId çakışmalarını önlemek için benzersiz ID'ler atandı
  - Box oluşturma ve servis locator kaydı yapıldı
- Kullanıcı deneyimi iyileştirmeleri:
  - Yenileme için RefreshIndicator
  - Silme işlemleri için onay
  - Detaylı istatistikler için modal bottom sheet
  - İslami tema ile uyumlu tasarım
  - Kazanan takım vurgusu

---

### 📚 8. Kategori Seçimi  
- [ ] Ön tanımlı kategorileri (Peygamberler, Sureler, Hadisler vb.) oluştur  
- [ ] Kullanıcının kategori seçmesine imkan tanıyan bir ekran ekle  
- [ ] Kategorilere göre kelime seçimi yapacak bir mekanizma hazırla  
- [ ] UI testleri gerçekleştir  

---

### 📱 9. Offline Oynanabilirlik  
- [x] Oyunun tüm verilerini lokal veritabanında saklayacak şekilde düzenle  
- [ ] İnternet bağlantısı olmadan tüm fonksiyonların çalıştığını test et  
- [ ] Kullanıcı deneyimini artırmak için gerekli optimizasyonları yap  

**Yapılan İşlemler:**
- Hive veritabanı ile kelime yönetimi için offline depolama uygulandı
- UUID kullanılarak benzersiz kelime ID'leri oluşturuldu
- GameSettings için Hive box oluşturuldu ve ayarlar lokal olarak saklandı
- Oyun istatistikleri için Hive box oluşturuldu

## 📄 Yeni Eklenen Belgeler

### new_feature_rules.md
- Yeni özellikler geliştirirken uyulması gereken kurallar tanımlandı
- Clean Architecture prensipleri detaylandırıldı
- Kod yazım ve isimlendirme kuralları belirlendi
- Hive ve Riverpod kullanımına dair standartlar açıklandı
- UI/UX standartları dokümante edildi

### roadmap_progress.md
- Proje ilerlemesini takip etmek için oluşturuldu
- Yapılan işlemlerin ayrıntılı dökümü sağlandı
- Kalan görevlerin takibi için yapılandırıldı