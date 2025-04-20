import '../../domain/entities/word_entity.dart';

// Initial hardcoded list of words.
// The WordManagementScreen will modify this list in memory via a Riverpod provider.
// Changes will NOT persist after app restarts.
final List<WordEntity> initialHardcodedWords = [
  WordEntity(
    id: '1',
    word: 'Namaz',
    forbiddenWords: ['Secde', 'Rüku', 'Kıyam', 'Abdest', 'Vakit'],
  ),
  WordEntity(
    id: '2',
    word: 'Oruç',
    forbiddenWords: ['Ramazan', 'Sahur', 'İftar', 'Açlık', 'İmsak'],
  ),
  WordEntity(
    id: '3',
    word: 'Zekat',
    forbiddenWords: ['Sadaka', 'Mal', 'Zengin', 'Fakir', 'Yardım'],
  ),
  WordEntity(
    id: '4',
    word: 'Hac',
    forbiddenWords: ['Kabe', 'Mekke', 'Medine', 'İhram', 'Tavaf'],
  ),
  WordEntity(
    id: '5',
    word: 'Peygamber',
    forbiddenWords: ['Resul', 'Nebi', 'Elçi', 'Vahiy', 'Hz Muhammed'],
  ),
  WordEntity(
    id: '6',
    word: 'Kuran',
    forbiddenWords: ['Kitap', 'Ayet', 'Sure', 'Vahiy', 'Allah Kelamı'],
  ),
  WordEntity(
    id: '7',
    word: 'Allah',
    forbiddenWords: ['Tanrı', 'Rab', 'İlah', 'Yaratıcı', 'Tek'],
  ),
  WordEntity(
    id: '8',
    word: 'Mescit',
    forbiddenWords: ['Cami', 'Namazgah', 'İbadet', 'Mihrap', 'Minber'],
  ),
  WordEntity(
    id: '9',
    word: 'Abdest',
    forbiddenWords: ['Namaz', 'Temizlik', 'Su', 'El', 'Yüz'],
  ),
  WordEntity(
    id: '10',
    word: 'Hadis',
    forbiddenWords: ['Söz', 'Peygamber', 'Rivayet', 'Sünnet', 'Kaynak'],
  ),
  WordEntity(
    id: '11',
    word: 'Sünnet',
    forbiddenWords: ['Peygamber', 'Davranış', 'Adet', 'Gelenek', 'Yaşam'],
  ),
  WordEntity(
    id: '12',
    word: 'Şeytan',
    forbiddenWords: ['İblis', 'Kötülük', 'Vesvese', 'Günah', 'Şer'],
  ),
  WordEntity(
    id: '13',
    word: 'Melek',
    forbiddenWords: ['Cebrail', 'Kanat', 'Nur', 'Vahiy', 'Görev'],
  ),
  WordEntity(
    id: '14',
    word: 'Cennet',
    forbiddenWords: ['Uçmak', 'Huri', 'Ebedi', 'Güzellik', 'Mükafat'],
  ),
  WordEntity(
    id: '15',
    word: 'Cehennem',
    forbiddenWords: ['Ateş', 'Azap', 'Kötü', 'Ebedi', 'Günahkar'],
  ),
  WordEntity(
    id: '16',
    word: 'Secde',
    forbiddenWords: ['Namaz', 'Alın', 'Yer', 'Yüz', 'Kapanmak'],
  ),
  WordEntity(
    id: '17',
    word: 'Tesbih',
    forbiddenWords: ['Zikir', 'İp', 'Boncuk', 'Sayı', 'Allah'],
  ),
  WordEntity(
    id: '18',
    word: 'Hutbe',
    forbiddenWords: ['Cuma', 'Vaaz', 'Minber', 'Konuşma', 'Nasihat'],
  ),
  WordEntity(
    id: '19',
    word: 'Kıble',
    forbiddenWords: ['Yön', 'Kabe', 'Namaz', 'Mekke', 'Dönmek'],
  ),
  WordEntity(
    id: '20',
    word: 'Müslüman',
    forbiddenWords: ['İslam', 'İnanan', 'Ümmet', 'Din', 'Allah'],
  ),
  WordEntity(
    id: '21',
    word: 'Vakıf',
    forbiddenWords: ['Bağış', 'Yardım', 'Hayır', 'Kurum', 'Eser'],
  ),
  WordEntity(
    id: '22',
    word: 'Helal',
    forbiddenWords: ['Caiz', 'Uygun', 'Din', 'Serbest', 'Yiyecek'],
  ),
  WordEntity(
    id: '23',
    word: 'Haram',
    forbiddenWords: ['Yas', 'Yasak', 'Günah', 'Din', 'Uygunsuz'],
  ),
  WordEntity(
    id: '24',
    word: 'Şehit',
    forbiddenWords: ['Ölüm', 'Savaş', 'Vatan', 'Din', 'Kahraman'],
  ),
  WordEntity(
    id: '25',
    word: 'Gusül',
    forbiddenWords: ['Boy', 'Abdest', 'Temizlik', 'Niyet', 'Su'],
  ),
  WordEntity(
    id: '26',
    word: 'Kelime-i Şehadet',
    forbiddenWords: ['Eşhedü', 'Allah', 'Peygamber', 'İslam', 'İman'],
  ),
  WordEntity(
    id: '27',
    word: 'Salavat',
    forbiddenWords: ['Peygamber', 'Dua', 'Allahümme', 'Salli', 'Bereket'],
  ),
  WordEntity(
    id: '28',
    word: 'Tilavet',
    forbiddenWords: ['Kuran', 'Okumak', 'Ses', 'Güzel', 'Tecvid'],
  ),
  WordEntity(
    id: '29',
    word: 'Tecvid',
    forbiddenWords: ['Kuran', 'Okuma', 'Kuralları', 'Harf', 'Mahreç'],
  ),
  WordEntity(
    id: '30',
    word: 'Mahreç',
    forbiddenWords: ['Harf', 'Ses', 'Çıkış', 'Yer', 'Tecvid'],
  ),
  WordEntity(
    id: '31',
    word: 'Ezan',
    forbiddenWords: ['Namaz', 'Çağrı', 'Müezzin', 'Vakit', 'Ses'],
  ),
  WordEntity(
    id: '32',
    word: 'Kamet',
    forbiddenWords: ['Namaz', 'Başlama', 'İkaz', 'Ezan', 'Sözler'],
  ),
  WordEntity(
    id: '33',
    word: 'Müezzin',
    forbiddenWords: ['Ezan', 'Okuyan', 'Cami', 'Ses', 'Namaz'],
  ),
  WordEntity(
    id: '34',
    word: 'İmam',
    forbiddenWords: ['Namaz', 'Ön', 'Kıldırmak', 'Cami', 'Lider'],
  ),
  WordEntity(
    id: '35',
    word: 'Cemaat',
    forbiddenWords: ['Namaz', 'Topluluk', 'Cami', 'Birlikte', 'Saf'],
  ),
  WordEntity(
    id: '36',
    word: 'Mihrap',
    forbiddenWords: ['Cami', 'Yön', 'Kıble', 'İmam', 'Oyuk'],
  ),
  WordEntity(
    id: '37',
    word: 'Minber',
    forbiddenWords: ['Cami', 'Hutbe', 'Yüksek', 'Merdiven', 'Konuşma'],
  ),
  WordEntity(
    id: '38',
    word: 'Vaaz',
    forbiddenWords: ['Hutbe', 'Nasihat', 'Konuşma', 'Cami', 'Din'],
  ),
  WordEntity(
    id: '39',
    word: 'Kadir Gecesi',
    forbiddenWords: ['Ramazan', 'Bin', 'Ay', 'Değerli', 'İbadet'],
  ),
  WordEntity(
    id: '40',
    word: 'Bayram',
    forbiddenWords: ['Ramazan', 'Kurban', 'Sevinç', 'Tatil', 'Ziyaret'],
  ),
  WordEntity(
    id: '41',
    word: 'Fitre',
    forbiddenWords: ['Sadaka', 'Ramazan', 'Bayram', 'Para', 'Fakir'],
  ),
  WordEntity(
    id: '42',
    word: 'Kefaret',
    forbiddenWords: ['Günah', 'Ödeme', 'Oruç', 'Sadaka', 'Ceza'],
  ),
  WordEntity(
    id: '43',
    word: 'Tevekkül',
    forbiddenWords: ['Allah', 'Güvenmek', 'Dayanmak', 'Sabır', 'İş'],
  ),
  WordEntity(
    id: '44',
    word: 'Şükür',
    forbiddenWords: ['Nimet', 'Hamd', 'Allah', 'Teşekkür', 'İyilik'],
  ),
  WordEntity(
    id: '45',
    word: 'Tövbe',
    forbiddenWords: ['Pişmanlık', 'Günah', 'Af', 'Allah', 'İstiğfar'],
  ),
  WordEntity(
    id: '46',
    word: 'İhlas',
    forbiddenWords: ['Samimiyet', 'Allah', 'Rıza', 'Kalp', 'Niyet'],
  ),
  WordEntity(
    id: '47',
    word: 'Takva',
    forbiddenWords: ['Sakınmak', 'Allah', 'Korku', 'Hassasiyet', 'Günah'],
  ),
  WordEntity(
    id: '48',
    word: 'Zikir',
    forbiddenWords: ['Allah', 'Anmak', 'Tekrar', 'Tesbih', 'Kalp'],
  ),
  WordEntity(
    id: '49',
    word: 'Dua',
    forbiddenWords: ['İstemek', 'Allah', 'Yakarmak', 'El', 'Açmak'],
  ),
  WordEntity(
    id: '50',
    word: 'Sabır',
    forbiddenWords: ['Dayanmak', 'Zorluk', 'Tahammül', 'Allah', 'Beklemek'],
  ),
  WordEntity(
    id: '51',
    word: 'Kanaat',
    forbiddenWords: ['Yetinmek', 'Az', 'Şükür', 'Memnun', 'Hal'],
  ),
  WordEntity(
    id: '52',
    word: 'Tefekkür',
    forbiddenWords: ['Düşünmek', 'Evren', 'Allah', 'Akıl', 'Yaratılış'],
  ),
  WordEntity(
    id: '53',
    word: 'İstiğfar',
    forbiddenWords: ['Af', 'Dilemek', 'Günah', 'Tövbe', 'Allah'],
  ),
  WordEntity(
    id: '54',
    word: 'Mümin',
    forbiddenWords: ['İnanan', 'Allah', 'Kalp', 'İman', 'Güven'],
  ),
  WordEntity(
    id: '55',
    word: 'Kafir',
    forbiddenWords: ['İnkar', 'Allah', 'Red', 'İman', 'Ateist'],
  ),
  WordEntity(
    id: '56',
    word: 'Münafık',
    forbiddenWords: ['İki', 'Yüzlü', 'Gizlemek', 'İnanç', 'Davranış'],
  ),
  WordEntity(
    id: '57',
    word: 'Fasık',
    forbiddenWords: ['Günahkar', 'Açık', 'Bozmak', 'Kural', 'Yol'],
  ),
  WordEntity(
    id: '58',
    word: 'Ehli Sünnet',
    forbiddenWords: ['Sünnet', 'Cemaat', 'Yol', 'İzlemek', 'Peygamber'],
  ),
  WordEntity(
    id: '59',
    word: 'Bidat',
    forbiddenWords: ['Yenilik', 'Din', 'Sonradan', 'Çıkarmak', 'Uygunsuz'],
  ),
  WordEntity(
    id: '60',
    word: 'İcma',
    forbiddenWords: ['Ulema', 'Görüş', 'Birliği', 'Din', 'Kaynak'],
  ),
  WordEntity(
    id: '61',
    word: 'Kıyas',
    forbiddenWords: ['Benzer', 'Durum', 'Hüküm', 'Çıkarmak', 'Akıl'],
  ),
  WordEntity(
    id: '62',
    word: 'Fetva',
    forbiddenWords: ['Hüküm', 'Soru', 'Cevap', 'Din', 'Alim'],
  ),
  WordEntity(
    id: '63',
    word: 'Müftü',
    forbiddenWords: ['Fetva', 'Veren', 'Alim', 'Din', 'Görevli'],
  ),
  WordEntity(
    id: '64',
    word: 'Kadı',
    forbiddenWords: ['Hakim', 'Şeriat', 'Hukuk', 'Karar', 'Adalet'],
  ),
  WordEntity(
    id: '65',
    word: 'Şahit',
    forbiddenWords: ['Tanık', 'Görmek', 'Duyumak', 'Söylemek', 'Doğru'],
  ),
  WordEntity(
    id: '66',
    word: 'Vasiyet',
    forbiddenWords: ['Ölüm', 'Sonra', 'İstek', 'Mal', 'Paylaşım'],
  ),
  WordEntity(
    id: '67',
    word: 'Miras',
    forbiddenWords: ['Ölüm', 'Kalan', 'Mal', 'Paylaşım', 'Hak'],
  ),
  WordEntity(
    id: '68',
    word: 'Nikah',
    forbiddenWords: ['Evlilik', 'Sözleşme', 'Kadın', 'Erkek', 'İmza'],
  ),
  WordEntity(
    id: '69',
    word: 'Talak',
    forbiddenWords: ['Boşanma', 'Ayrılık', 'Kadın', 'Erkek', 'Söz'],
  ),
  WordEntity(
    id: '70',
    word: 'Mehr',
    forbiddenWords: ['Evlilik', 'Para', 'Kadın', 'Hak', 'Verilen'],
  ),
  WordEntity(
    id: '71',
    word: 'İddet',
    forbiddenWords: ['Boşanma', 'Süre', 'Beklemek', 'Evlilik', 'Kadın'],
  ),
  WordEntity(
    id: '72',
    word: 'Nafaka',
    forbiddenWords: ['Boşanma', 'Sonra', 'Para', 'Kadın', 'Çocuk'],
  ),
  WordEntity(
    id: '73',
    word: 'Hicap',
    forbiddenWords: ['Utanmak', 'Edep', 'Haya', 'Göz', 'Sakınmak'],
  ),
  WordEntity(
    id: '74',
    word: 'Tesettür',
    forbiddenWords: ['Örtünmek', 'Kadın', 'Giyim', 'Vücut', 'Hicap'],
  ),
  WordEntity(
    id: '75',
    word: 'Mahrem',
    forbiddenWords: ['Yakın', 'Akraba', 'Evlilik', 'Uygun', 'Görmek'],
  ),
  WordEntity(
    id: '76',
    word: 'Harem',
    forbiddenWords: ['Kutsal', 'Yasak', 'Bölge', 'Mekke', 'Medine'],
  ),
  WordEntity(
    id: '77',
    word: 'Cihad',
    forbiddenWords: ['Savaş', 'Mücadele', 'Din', 'Uğruna', 'Çaba'],
  ),
  WordEntity(
    id: '78',
    word: 'Ganimet',
    forbiddenWords: ['Savaş', 'Elde', 'Edilen', 'Mal', 'Paylaşım'],
  ),
  WordEntity(
    id: '79',
    word: 'Hilafet',
    forbiddenWords: ['Yönetim', 'İslam', 'Devlet', 'Halife', 'Lider'],
  ),
  WordEntity(
    id: '80',
    word: 'Şeriat',
    forbiddenWords: ['Hukuk', 'İslam', 'Kuralları', 'Din', 'Kanun'],
  ),
  WordEntity(
    id: '81',
    word: 'Ehl-i Kitap',
    forbiddenWords: ['Kitap', 'İnanan', 'Hristiyan', 'Yahudi', 'Din'],
  ),
  WordEntity(
    id: '82',
    word: 'Zımmi',
    forbiddenWords: ['Gayrimüslim', 'İslam', 'Devlet', 'Yaşayan', 'Vergi'],
  ),
  WordEntity(
    id: '83',
    word: 'Cizye',
    forbiddenWords: ['Vergi', 'Gayrimüslim', 'İslam', 'Devlet', 'Ödeme'],
  ),
  WordEntity(
    id: '84',
    word: 'Darülharp',
    forbiddenWords: ['Savaş', 'Bölge', 'İslam', 'Olmayan', 'Ülke'],
  ),
  WordEntity(
    id: '85',
    word: 'Darülislam',
    forbiddenWords: ['İslam', 'Bölge', 'Ülke', 'Yönetim', 'Hukuk'],
  ),
  WordEntity(
    id: '86',
    word: 'Sırat Köprüsü',
    forbiddenWords: ['Cehennem', 'Cennet', 'Geçmek', 'İnce', 'Kıl'],
  ),
  WordEntity(
    id: '87',
    word: 'Mahşer',
    forbiddenWords: ['Kıyamet', 'Toplanmak', 'Hesap', 'Gün', 'Yer'],
  ),
  WordEntity(
    id: '88',
    word: 'Mizan',
    forbiddenWords: ['Terazi', 'Tartmak', 'Amel', 'Günah', 'Hesap'],
  ),
  WordEntity(
    id: '89',
    word: 'Arş',
    forbiddenWords: ['Allah', 'Taht', 'Gökyüzü', 'En', 'Yüksek'],
  ),
  WordEntity(
    id: '90',
    word: 'Kevser',
    forbiddenWords: ['Cennet', 'Irmak', 'Su', 'Peygamber', 'İkram'],
  ),
  WordEntity(
    id: '91',
    word: 'Tuba Ağacı',
    forbiddenWords: ['Cennet', 'Ağaç', 'Gölge', 'Büyük', 'Kök'],
  ),
  WordEntity(
    id: '92',
    word: 'Huri',
    forbiddenWords: ['Cennet', 'Kadın', 'Güzel', 'Eş', 'Mükafat'],
  ),
  WordEntity(
    id: '93',
    word: 'Gılman',
    forbiddenWords: ['Cennet', 'Erkek', 'Hizmet', 'Genç', 'Ebedi'],
  ),
  WordEntity(
    id: '94',
    word: 'Kabir',
    forbiddenWords: ['Mezar', 'Ölüm', 'Toprak', 'Sorgu', 'Alem'],
  ),
  WordEntity(
    id: '95',
    word: 'Münker Nekir',
    forbiddenWords: ['Melek', 'Sorgu', 'Kabir', 'Soru', 'Cevap'],
  ),
  WordEntity(
    id: '96',
    word: 'Berzah',
    forbiddenWords: ['Kabir', 'Alem', 'Dünya', 'Ahiret', 'Arası'],
  ),
  WordEntity(
    id: '97',
    word: 'Sura Üflemek',
    forbiddenWords: ['Kıyamet', 'Melek', 'Ses', 'Borazan', 'İsrafil'],
  ),
  WordEntity(
    id: '98',
    word: 'Deccal',
    forbiddenWords: ['Kıyamet', 'Alameti', 'Fitne', 'Kötü', 'Zaman'],
  ),
  WordEntity(
    id: '99',
    word: 'Mehdi',
    forbiddenWords: ['Kıyamet', 'Önce', 'Gelecek', 'Kurtarıcı', 'Zaman'],
  ),
  WordEntity(
    id: '100',
    word: 'Yecüc Mecüc',
    forbiddenWords: ['Kıyamet', 'Alameti', 'Kavim', 'Set', 'Aşmak'],
  ),
  WordEntity(
    id: '101',
    word: 'Dabbet-ül Arz',
    forbiddenWords: ['Kıyamet', 'Alameti', 'Hayvan', 'Yer', 'Çıkmak'],
  ),
  WordEntity(
    id: '102',
    word: 'Güneşin Batıdan Doğması',
    forbiddenWords: ['Kıyamet', 'Alameti', 'Ters', 'Doğa', 'Olay'],
  ),
  WordEntity(
    id: '103',
    word: 'Ahiret',
    forbiddenWords: ['Ölüm', 'Sonrası', 'Yaşam', 'Cennet', 'Cehennem'],
  ),
  WordEntity(
    id: '104',
    word: 'Amel Defteri',
    forbiddenWords: ['Yazılan', 'İyi', 'Kötü', 'Günah', 'Sevab'],
  ),
  WordEntity(
    id: '105',
    word: 'Hesap Günü',
    forbiddenWords: ['Kıyamet', 'Sorgu', 'Amel', 'Karşılık', 'Ödeme'],
  ),
  WordEntity(
    id: '106',
    word: 'Kıyamet Alametleri',
    forbiddenWords: ['Küçük', 'Büyük', 'Belirti', 'Son', 'Zaman'],
  ),
  WordEntity(
    id: '107',
    word: 'İslamın Şartları',
    forbiddenWords: ['Beş', 'Temel', 'Esas', 'Namaz', 'Oruç'],
  ),
  WordEntity(
    id: '108',
    word: 'İmanın Şartları',
    forbiddenWords: ['Altı', 'Temel', 'Esas', 'Allah', 'Peygamber'],
  ),
  WordEntity(
    id: '109',
    word: 'Melekler',
    forbiddenWords: ['Cebrail', 'Azrail', 'Görevli', 'Nur', 'Kanat'],
  ),
  WordEntity(
    id: '110',
    word: 'Kitaplar',
    forbiddenWords: ['Kuran', 'Tevrat', 'İncil', 'Zebur', 'Vahiy'],
  ),
  WordEntity(
    id: '111',
    word: 'Peygamberler',
    forbiddenWords: ['Hz. Muhammed', 'Hz. İsa', 'Hz. Musa', 'Elçi', 'Vahiy'],
  ),
  WordEntity(
    id: '112',
    word: 'Kader',
    forbiddenWords: ['Alın', 'Yazısı', 'Allah', 'Takdir', 'Olacak'],
  ),
  WordEntity(
    id: '113',
    word: 'Ahiret Günü',
    forbiddenWords: ['Kıyamet', 'Ölüm', 'Sonra', 'Yaşam', 'Sonsuz'],
  ),
  WordEntity(
    id: '114',
    word: 'İslam Alimleri',
    forbiddenWords: ['Bilgin', 'Din', 'Ulema', 'Fetva', 'Hüküm'],
  ),
  WordEntity(
    id: '115',
    word: 'Tasavvuf',
    forbiddenWords: ['İrfan', 'Kalp', 'Allah', 'Aşk', 'Yol'],
  ),
  WordEntity(
    id: '116',
    word: 'Seyyid',
    forbiddenWords: ['Peygamber', 'Soy', 'Torun', 'Aile', 'Ünvan'],
  ),
  WordEntity(
    id: '117',
    word: 'Şerif',
    forbiddenWords: ['Peygamber', 'Soy', 'Temiz', 'Ünvan', 'Aile'],
  ),
  WordEntity(
    id: '118',
    word: 'Evliya',
    forbiddenWords: ['Allah', 'Dost', 'Keramet', 'Velilik', 'Kişi'],
  ),
  WordEntity(
    id: '119',
    word: 'Kutub',
    forbiddenWords: ['Evliya', 'En', 'Büyük', 'Lider', 'Zaman'],
  ),
  WordEntity(
    id: '120',
    word: 'Mürşid',
    forbiddenWords: ['Yol', 'Gösteren', 'Tasavvuf', 'Rehber', 'Öğretmen'],
  ),
  WordEntity(
    id: '121',
    word: 'Mürit',
    forbiddenWords: ['Tasavvuf', 'Öğrenci', 'Yol', 'İzleyen', 'Takip'],
  ),
  WordEntity(
    id: '122',
    word: 'Zaviye',
    forbiddenWords: ['Tekke', 'Tasavvuf', 'Yer', 'İbadet', 'Toplanma'],
  ),
  WordEntity(
    id: '123',
    word: 'Tekke',
    forbiddenWords: ['Zaviye', 'Tasavvuf', 'Yer', 'Derviş', 'İkamet'],
  ),
  WordEntity(
    id: '124',
    word: 'Derviş',
    forbiddenWords: ['Tasavvuf', 'Yol', 'Giren', 'Fakir', 'Hayat'],
  ),
  WordEntity(
    id: '125',
    word: 'Sufi',
    forbiddenWords: ['Tasavvuf', 'İle', 'Uğraşan', 'Kalp', 'Aşk'],
  ),
  WordEntity(
    id: '126',
    word: 'Vahdet-i Vücud',
    forbiddenWords: ['Birlik', 'Allah', 'Evren', 'Tek', 'Varoluş'],
  ),
  WordEntity(
    id: '127',
    word: 'Fenafillah',
    forbiddenWords: ['Allah', 'İçinde', 'Yok', 'Olmak', 'Ermek'],
  ),
  WordEntity(
    id: '128',
    word: 'Bektaşi',
    forbiddenWords: ['Alevi', 'Tarikat', 'Hacı Bektaş', 'Velayetname', 'Semah'],
  ),
  WordEntity(
    id: '129',
    word: 'Alevi',
    forbiddenWords: ['Bektaşi', 'Hz. Ali', 'On İki İmam', 'Cem', 'Semah'],
  ),
  WordEntity(
    id: '130',
    word: 'Cem',
    forbiddenWords: ['Alevi', 'Toplantı', 'İbadet', 'Semah', 'Dede'],
  ),
  WordEntity(
    id: '131',
    word: 'Semah',
    forbiddenWords: ['Alevi', 'Dönmek', 'Zikir', 'Cem', 'Müzik'],
  ),
  WordEntity(
    id: '132',
    word: 'Dede',
    forbiddenWords: ['Alevi', 'Lider', 'Din', 'Önder', 'Cem'],
  ),
  WordEntity(
    id: '133',
    word: 'On İki İmam',
    forbiddenWords: ['Hz. Ali', 'Torun', 'Alevi', 'İnanç', 'Kutsal'],
  ),
  WordEntity(
    id: '134',
    word: 'Muharrem',
    forbiddenWords: ['Ay', 'Hicri', 'Kerbela', 'Oruç', 'Matem'],
  ),
  WordEntity(
    id: '135',
    word: 'Kerbela',
    forbiddenWords: ['Şehir', 'Irak', 'Hz. Hüseyin', 'Şehit', 'Muharrem'],
  ),
  WordEntity(
    id: '136',
    word: 'Aşura',
    forbiddenWords: ['Muharrem', 'Oruç', 'Tatlı', 'Nuh', 'Gemi'],
  ),
  WordEntity(
    id: '137',
    word: 'Mevlid',
    forbiddenWords: ['Doğum', 'Peygamber', 'Kutlama', 'Kandil', 'Şiir'],
  ),
  WordEntity(
    id: '138',
    word: 'Kandil',
    forbiddenWords: ['Mevlid', 'Miraç', 'Berat', 'Regai', 'Kutlama'],
  ),
  WordEntity(
    id: '139',
    word: 'Miraç',
    forbiddenWords: ['Peygamber', 'Gökyüzü', 'Yükselmek', 'Allah', 'Gece'],
  ),
  WordEntity(
    id: '140',
    word: 'Berat',
    forbiddenWords: ['Affetmek', 'Günah', 'Temizlenmek', 'Kandil', 'Gece'],
  ),
  WordEntity(
    id: '141',
    word: 'Regai',
    forbiddenWords: ['Arzu', 'İstek', 'Kandil', 'Gece', 'Dua'],
  ),
  WordEntity(
    id: '142',
    word: 'Üç Aylar',
    forbiddenWords: ['Recep', 'Şaban', 'Ramazan', 'Oruç', 'İbadet'],
  ),
  WordEntity(
    id: '143',
    word: 'Receb',
    forbiddenWords: ['Üç', 'Aylar', 'İlk', 'Kandil', 'Miraç'],
  ),
  WordEntity(
    id: '144',
    word: 'Şaban',
    forbiddenWords: ['Üç', 'Aylar', 'Ortası', 'Berat', 'Gece'],
  ),
  WordEntity(
    id: '145',
    word: 'Arefe',
    forbiddenWords: ['Bayram', 'Önce', 'Gün', 'Hazırlık', 'Ziyaret'],
  ),
  WordEntity(
    id: '146',
    word: 'Kabir Ziyareti',
    forbiddenWords: ['Ölüm', 'Hatırlamak', 'Dua', 'Fatiha', 'Okumak'],
  ),
  WordEntity(
    id: '147',
    word: 'Sadaka-i Cariye',
    forbiddenWords: ['Devamlı', 'Yardım', 'Hayır', 'Ölüm', 'Sonrası'],
  ),
  WordEntity(
    id: '148',
    word: 'Veda Hutbesi',
    forbiddenWords: ['Peygamber', 'Son', 'Konuşma', 'Nasihat', 'Önemli'],
  ),
  WordEntity(
    id: '149',
    word: 'Hılful Fudul',
    forbiddenWords: ['Peygamber', 'Katıldığı', 'Antlaşma', 'Adalet', 'Yardım'],
  ),
  WordEntity(
    id: '150',
    word: 'Darül Erkam',
    forbiddenWords: ['İlk', 'Okul', 'Mekke', 'Eğitim', 'Gizli'],
  ),
  WordEntity(
    id: '151',
    word: 'Hicret',
    forbiddenWords: ['Mekke', 'Medine', 'Göç', 'Peygamber', 'Sahabe'],
  ),
  WordEntity(
    id: '152',
    word: 'Ensar',
    forbiddenWords: ['Medine', 'Yardım', 'Muhacir', 'Ev', 'Paylaşmak'],
  ),
  WordEntity(
    id: '153',
    word: 'Muhacir',
    forbiddenWords: ['Mekke', 'Göç', 'Medine', 'Terketmek', 'Ev'],
  ),
  WordEntity(
    id: '154',
    word: 'Bedir Savaşı',
    forbiddenWords: ['İlk', 'Savaş', 'Müslüman', 'Zafer', 'Mekke'],
  ),
  WordEntity(
    id: '155',
    word: 'Uhud Savaşı',
    forbiddenWords: ['Savaş', 'Okçu', 'Hata', 'Yenilgi', 'Peygamber'],
  ),
  WordEntity(
    id: '156',
    word: 'Hendek Savaşı',
    forbiddenWords: ['Çukur', 'Savunma', 'Medine', 'Kuşatma', 'Düşman'],
  ),
];
