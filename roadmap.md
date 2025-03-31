İşte her bir MVP özelliği için detaylı bir yol haritası:

### 🔹 MVP (Minimum Viable Product) Yol Haritası

#### 📌 1. Ana Ekran Tasarımı ve Navigasyon
- [x] Ana ekranın temel tasarımını oluştur  
- [x] Oyun, Ayarlar ve Kelime Yönetimi sayfalarına yönlendiren butonlar ekle  
- [x] Sayfalar arası geçiş için `GoRouter` veya `Navigator` kullan  
- [x] Kullanıcı dostu bir arayüz tasarla   
- [x] UI testleri gerçekleştir  

---

#### 📌 2. Yeni Kelime Ekleme ve Yönetim Paneli
- [x] Kullanıcıların yeni kelimeler ekleyebileceği bir form tasarla  
- [x] Kelimeye ait yasaklı kelimelerin eklenmesini sağla  
- [x] Hive kullanarak kelimeleri lokal olarak sakla  
- [x] Kelime listesini görüntüleme ve düzenleme seçenekleri ekle  
- [x] Silme ve güncelleme fonksiyonlarını oluştur  
- [x] UI testleri ve hata ayıklamaları yap  

---

#### 📌 3. Oyun Ekranı (Kelime Gösterimi, Yasaklı Kelimeler, Süre)  
- [x] Oyun ekranının temel tasarımını oluştur  
- [x] Rastgele kelime seçimi için bir mekanizma hazırla  
- [x] Yasaklı kelimeleri ekrana listele  
- [x] Süre sayacı entegre et  
- [x] Oyuncuların geçme, doğru bilme gibi işlemleri yapabilmesi için butonlar ekle  
- [x] UI testleri ve hata ayıklamaları yap  

---

#### 📌 4. Oyun Ayarları  
- [x] Kullanıcının oyun süresini ayarlayabilmesi için seçenekler ekle  
- [x] Yasaklı kelime sayısını ayarlayabileceği bir seçenek sun  
- [x] Kullanıcıların kendi kelime havuzlarını oluşturmasına izin ver  
- [x] Tema ayarlarını (Dark/Light Mode) oyun içinde değiştirme imkanı tanı  
- [x] Ayarları lokal veritabanına kaydet  
- [x] UI testleri gerçekleştir  

---

#### 📌 5. Düzeltme - game_screen.dart
- [ ] game_screen.dart deki oyunu tek kişilik yapmıştık ama bu yanlış. Şu şekilde düzeltilecek:
- [ ] game_screen.dart açılınca kaç kişi oynanacağı seçilmeli (min 2 takım, max 8 takım)
- [ ] yeni bir ekran oluşturma. game_screen.dart üzerinden devam et, gerekli değişiklikleri yap.
- [ ] girilen takımların adlarını sistem otomatik olarak 1.takım, 2.takım, ... diye sırala
- [ ] Ekipler arasında kelimeleri paylaşacak bir mekanizma hazırla
- [ ] süresi bitince diğer takımın sırası gelsin. oyunu bitir gibi bir butona tıklayana kadar devam etsin.
- [ ] oyun sonunda ekiplerin skorlarını göster
- [ ] oyun sonuçlarını kaydet
- [ ] roadmap_progress.md dosyasından önceden yapılan yanlış işlemlere bak ve bunları düzelt

---

#### 📌 6. Kategori Kaldırma  
- [ ] kategori seçimi kaldırılacak.
- [ ] kelimelerin kategorileri kaldırılacak.
- [ ] roadmap.md vs roadmap_progress.md dosyalarını incele ve kategori ile ilgili her şeyi kaldır.


---

#### 📌 7. Offline Oynanabilirlik  
- [x] Oyunun tüm verilerini lokal veritabanında saklayacak şekilde düzenle  
- [ ] Kullanıcı deneyimini artırmak için gerekli optimizasyonları yap  
