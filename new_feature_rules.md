# İslami Tabu - Yeni Özellikler İçin Geliştirme Kuralları

## Genel Mimari Kuralları

### Clean Architecture
Uygulama Clean Architecture prensiplerine sadık kalarak geliştirilmelidir:

1. **Domain Katmanı**
   - Entities: Uygulamanın temel veri modelleri
   - Repositories (Interface): Veri katmanı için soyut arayüzler
   - Use Cases: İş mantığı için kullanım durumları

2. **Data Katmanı**
   - Models: Domain entity'lerinin implementasyonları
   - Repositories (Implementation): Repository interface'lerinin implementasyonları
   - Data Sources: Veri kaynaklarına erişim sağlayan sınıflar

3. **Presentation Katmanı**
   - ViewModels: UI state'ini yöneten sınıflar
   - Screens: Kullanıcı arayüzü bileşenleri
   - Widgets: Yeniden kullanılabilir UI bileşenleri

### Bağımlılık Yönetimi
- Bağımlılıklar her zaman içeriden dışarıya doğru akmalıdır
- Domain katmanı hiçbir katmana bağımlı olmamalıdır
- Data katmanı domain katmanına bağımlı olabilir
- Presentation katmanı hem domain hem de data katmanına bağımlı olabilir

### Dependency Injection (GetIt)
- ServiceLocator sınıfı ile bağımlılıklar merkezi olarak yönetilmelidir
- Kayıt türleri doğru kullanılmalıdır:
  - **registerSingleton**: Tek örnek (instance) gerektiğinde (Repository'ler için)
  - **registerLazySingleton**: Tek örnek gerektiğinde, ancak ilk kullanımda oluşturulması istendiğinde (Use Case'ler için)
  - **registerFactory**: Her talep edildiğinde yeni bir örnek oluşturulması gerektiğinde (ViewModel'ler için)
- ViewModel'ler provider'lar içinde GetIt'ten alınmalıdır
- Doğrudan `locator.get<T>()` kullanımı yerine constructor injection tercih edilmelidir

## Kod Yazım Kuralları

### Genel Kurallar
- Tüm kod ve dokümantasyon İngilizce olmalıdır (UI metinleri Türkçe olabilir)
- Her değişken ve fonksiyonun tipi açıkça belirtilmelidir
- Fonksiyonlar tek bir amaca hizmet etmeli ve 20 satırı geçmemelidir
- Sınıflar tek bir sorumluluğa sahip olmalı ve SOLID prensiplerine uymalıdır

### İsimlendirme Kuralları
- Sınıflar için PascalCase kullanılmalıdır
- Değişkenler ve fonksiyonlar için camelCase kullanılmalıdır
- Dosya ve dizin isimleri için snake_case kullanılmalıdır
- Boolean değişkenler is, has, can gibi yardımcı fiillerle başlamalıdır
- Fonksiyonlar bir fiil ile başlamalıdır

### UI Komponentlerinde Dikkat Edilecekler
- Widgetlar küçük ve yeniden kullanılabilir olmalıdır
- Karmaşık widget ağaçları yerine düz yapılar tercih edilmelidir
- Widget ağacı derinliği performans sorunlarına yol açabileceğinden minimumda tutulmalıdır
- UI state'i Riverpod ile yönetilmelidir
- Hata durumları SelectableText.rich ile görüntülenmelidir
- Görsel öğeler temaya uygun olmalıdır

## Veri Tabanı Kuralları

### Hive Kullanımı
- Entity sınıfları domain katmanında, model sınıfları data katmanında tanımlanmalıdır
- Her entity için bir adapter oluşturulmalıdır
- TypeId'ler çakışmayacak şekilde benzersiz olmalıdır
- Modeller arasında döngüsel bağımlılıklar olmamalıdır

### Repository Pattern
- Her entity için bir repository interface'i ve implementasyonu olmalıdır
- Repository sınıfları CRUD işlemlerini desteklemelidir
- Repository interface'leri domain katmanında, implementasyonları data katmanında olmalıdır

## State Yönetimi

### Riverpod
- Global state için StateNotifierProvider kullanılmalıdır
- UI state'i için AsyncValue kullanılmalıdır
- State'ler immutable olmalıdır
- Provider'lar GetIt ile entegre edilmelidir
- Mümkün olduğunca az provider oluşturulmalıdır

## Test Edilebilirlik
- Her public fonksiyon için unit test yazılmalıdır
- Her modül için kabul testi yazılmalıdır
- Testler arrange-act-assert düzeninde olmalıdır
- Test değişkenleri açık ve anlaşılır olmalıdır (inputX, mockX, actualX, expectedX)
- GetIt için test modları oluşturulmalıdır (registerFactoryMock, registerSingletonMock)

## UI/UX Standartları
- Uygulama responsive tasarım prensiplerine uygun olmalıdır
- İslami temayla uyumlu bir renk paleti kullanılmalıdır
- Kullanıcı geri bildirimleri (hatalar, başarı mesajları) net ve anlaşılır olmalıdır
- Formlar validation içermelidir
- Yükleme durumları ve boş durumlar ele alınmalıdır
- İnternet bağlantısı olmadan oynanabilirlik sağlanmalıdır

## Paketler
- freezed kullanma 