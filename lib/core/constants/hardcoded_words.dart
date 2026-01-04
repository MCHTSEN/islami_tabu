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
    word: 'Alevi',
    forbiddenWords: ['Hz. Ali', 'On İki İmam', 'Cem', 'Semah', 'Dede'],
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
  WordEntity(
    id: '157',
    word: 'Teravih',
    forbiddenWords: ['Ramazan', 'Namaz', 'Gece', 'Yirmi', 'Rekat'],
  ),
  WordEntity(
    id: '158',
    word: 'Sahabe',
    forbiddenWords: ['Peygamber', 'Arkadaş', 'Gören', 'Dost', 'Ashab'],
  ),
  WordEntity(
    id: '159',
    word: 'Hacer-ül Esved',
    forbiddenWords: ['Kabe', 'Taş', 'Siyah', 'Öpmek', 'Köşe'],
  ),
  WordEntity(
    id: '160',
    word: 'Makam-ı İbrahim',
    forbiddenWords: ['Kabe', 'Taş', 'Ayak', 'İzi', 'Namaz'],
  ),
  WordEntity(
    id: '161',
    word: 'Safa Merve',
    forbiddenWords: ['Hac', 'Tepe', 'Koşmak', 'Say', 'Hacer'],
  ),
  WordEntity(
    id: '162',
    word: 'Umre',
    forbiddenWords: ['Hac', 'Küçük', 'Ziyaret', 'Kabe', 'Tavaf'],
  ),
  WordEntity(
    id: '163',
    word: 'Kurban',
    forbiddenWords: ['Bayram', 'Kesmek', 'Hayvan', 'Allah', 'İbadet'],
  ),
  WordEntity(
    id: '164',
    word: 'Esma-ül Hüsna',
    forbiddenWords: ['Allah', 'İsim', 'Doksan', 'Dokuz', 'Güzel'],
  ),
  WordEntity(
    id: '165',
    word: 'Besmele',
    forbiddenWords: ['Bismillah', 'Başlamak', 'Rahman', 'Rahim', 'Söz'],
  ),
  WordEntity(
    id: '166',
    word: 'Fatiha',
    forbiddenWords: ['Sure', 'İlk', 'Açılış', 'Namaz', 'Okumak'],
  ),
  WordEntity(
    id: '167',
    word: 'Ayetel Kürsi',
    forbiddenWords: ['Bakara', 'Ayet', 'Koruma', 'Uzun', 'Okumak'],
  ),
  WordEntity(
    id: '168',
    word: 'Yasin',
    forbiddenWords: ['Sure', 'Kalp', 'Kuran', 'Okumak', 'Ölü'],
  ),
  WordEntity(
    id: '169',
    word: 'Mucize',
    forbiddenWords: ['Peygamber', 'Olağanüstü', 'Allah', 'İzin', 'Kanıt'],
  ),
  WordEntity(
    id: '170',
    word: 'Keramet',
    forbiddenWords: ['Evliya', 'Olağanüstü', 'Allah', 'Dost', 'İkram'],
  ),
  WordEntity(
    id: '171',
    word: 'Ruh',
    forbiddenWords: ['Can', 'Beden', 'Ölüm', 'Yaşam', 'Üflemek'],
  ),
  WordEntity(
    id: '172',
    word: 'Nefs',
    forbiddenWords: ['Benlik', 'Arzu', 'Kötü', 'Mücadele', 'Terbiye'],
  ),
  WordEntity(
    id: '173',
    word: 'Hidayet',
    forbiddenWords: ['Doğru', 'Yol', 'Allah', 'Rehber', 'Bulmak'],
  ),
  WordEntity(
    id: '174',
    word: 'Dalalet',
    forbiddenWords: ['Sapkınlık', 'Yol', 'Yanlış', 'Kaybolmak', 'Şaşmak'],
  ),
  WordEntity(
    id: '175',
    word: 'Şirk',
    forbiddenWords: ['Allah', 'Ortak', 'Koşmak', 'Günah', 'Büyük'],
  ),
  WordEntity(
    id: '176',
    word: 'Riya',
    forbiddenWords: ['Gösteriş', 'İbadet', 'İnsanlar', 'Samimiyetsiz', 'Gizli'],
  ),
  WordEntity(
    id: '177',
    word: 'Kibir',
    forbiddenWords: ['Büyüklenmek', 'Gurur', 'Üstünlük', 'Günah', 'Şeytan'],
  ),
  WordEntity(
    id: '178',
    word: 'Haset',
    forbiddenWords: ['Kıskançlık', 'İstemek', 'Başkası', 'Nimet', 'Günah'],
  ),
  WordEntity(
    id: '179',
    word: 'Gıybet',
    forbiddenWords: ['Arkadan', 'Konuşmak', 'Kötü', 'Söz', 'Günah'],
  ),
  WordEntity(
    id: '180',
    word: 'İftira',
    forbiddenWords: ['Yalan', 'Suçlamak', 'Atmak', 'Günah', 'Büyük'],
  ),
  WordEntity(
    id: '181',
    word: 'Faiz',
    forbiddenWords: ['Para', 'Fazla', 'Haram', 'Borç', 'Kazanç'],
  ),
  WordEntity(
    id: '182',
    word: 'Kumar',
    forbiddenWords: ['Şans', 'Oyun', 'Para', 'Haram', 'Bahis'],
  ),
  WordEntity(
    id: '183',
    word: 'Adak',
    forbiddenWords: ['Söz', 'Vermek', 'Allah', 'Yerine', 'Getirmek'],
  ),
  WordEntity(
    id: '184',
    word: 'Yemin',
    forbiddenWords: ['Allah', 'Söz', 'Ant', 'Kefaret', 'Bozmak'],
  ),
  WordEntity(
    id: '185',
    word: 'Emanet',
    forbiddenWords: ['Güven', 'Vermek', 'Saklamak', 'İade', 'Sorumluluk'],
  ),
  WordEntity(
    id: '186',
    word: 'Farz',
    forbiddenWords: ['Zorunlu', 'İbadet', 'Allah', 'Emir', 'Yapılması'],
  ),
  WordEntity(
    id: '187',
    word: 'Vacip',
    forbiddenWords: ['Gerekli', 'Farz', 'Yakın', 'İbadet', 'Yapılması'],
  ),
  WordEntity(
    id: '188',
    word: 'Müstehap',
    forbiddenWords: ['Sevap', 'Tavsiye', 'Edilen', 'Güzel', 'İbadet'],
  ),
  WordEntity(
    id: '189',
    word: 'Mekruh',
    forbiddenWords: ['Hoş', 'Görülmeyen', 'Çirkin', 'Yapmamak', 'Tercih'],
  ),
  WordEntity(
    id: '190',
    word: 'Mübah',
    forbiddenWords: ['Serbest', 'Günah', 'Sevap', 'Değil', 'İzin'],
  ),
  WordEntity(
    id: '191',
    word: 'Sevap',
    forbiddenWords: ['İyi', 'Amel', 'Mükafat', 'Allah', 'Kazanmak'],
  ),
  WordEntity(
    id: '192',
    word: 'Huşu',
    forbiddenWords: ['Namaz', 'Saygı', 'Korku', 'Kalp', 'Huzur'],
  ),
  WordEntity(
    id: '193',
    word: 'Vesvese',
    forbiddenWords: ['Şeytan', 'Fısıldamak', 'Şüphe', 'Kötü', 'Düşünce'],
  ),
  WordEntity(
    id: '194',
    word: 'Ravza',
    forbiddenWords: ['Medine', 'Peygamber', 'Kabir', 'Cennet', 'Bahçe'],
  ),
  WordEntity(
    id: '195',
    word: 'Zemzem',
    forbiddenWords: ['Su', 'Kabe', 'Kuyu', 'İçmek', 'Hacer'],
  ),
  WordEntity(
    id: '196',
    word: 'Arafat',
    forbiddenWords: ['Hac', 'Dağ', 'Vakfe', 'Durmak', 'Dua'],
  ),
  WordEntity(
    id: '197',
    word: 'Müzdelife',
    forbiddenWords: ['Hac', 'Gecelemek', 'Arafat', 'Mina', 'Arası'],
  ),
  WordEntity(
    id: '198',
    word: 'Mina',
    forbiddenWords: ['Hac', 'Şeytan', 'Taşlamak', 'Çadır', 'Kurban'],
  ),
  WordEntity(
    id: '199',
    word: 'Cemre',
    forbiddenWords: ['Şeytan', 'Taşlamak', 'Hac', 'Mina', 'Yedi'],
  ),
  WordEntity(
    id: '200',
    word: 'Telbiye',
    forbiddenWords: ['Lebbeyk', 'Hac', 'Söylemek', 'Çağrı', 'Cevap'],
  ),
  WordEntity(
    id: '201',
    word: 'Mikat',
    forbiddenWords: ['Hac', 'İhram', 'Sınır', 'Giyinmek', 'Yer'],
  ),
  WordEntity(
    id: '202',
    word: 'Rükn-ü Yemani',
    forbiddenWords: ['Kabe', 'Köşe', 'Yemen', 'Dokunmak', 'Tavaf'],
  ),
  WordEntity(
    id: '203',
    word: 'Hicr-i İsmail',
    forbiddenWords: ['Kabe', 'Duvar', 'Yarım', 'Daire', 'İçinde'],
  ),
  WordEntity(
    id: '204',
    word: 'Mültezem',
    forbiddenWords: ['Kabe', 'Kapı', 'Duvar', 'Yapışmak', 'Dua'],
  ),
  WordEntity(
    id: '205',
    word: 'Kıssa',
    forbiddenWords: ['Hikaye', 'Kuran', 'Anlatmak', 'Peygamber', 'Ders'],
  ),
  WordEntity(
    id: '206',
    word: 'Hz. Adem',
    forbiddenWords: ['İlk', 'İnsan', 'Peygamber', 'Cennet', 'Yasak'],
  ),
  WordEntity(
    id: '207',
    word: 'Hz. Nuh',
    forbiddenWords: ['Tufan', 'Gemi', 'Su', 'Peygamber', 'Oğul'],
  ),
  WordEntity(
    id: '208',
    word: 'Hz. İbrahim',
    forbiddenWords: ['Ateş', 'Kabe', 'Kurban', 'Halil', 'Peygamber'],
  ),
  WordEntity(
    id: '209',
    word: 'Hz. Musa',
    forbiddenWords: ['Firavun', 'Asa', 'Deniz', 'Tevrat', 'Peygamber'],
  ),
  WordEntity(
    id: '210',
    word: 'Hz. İsa',
    forbiddenWords: ['İncil', 'Meryem', 'Göğe', 'Çekilmek', 'Peygamber'],
  ),
  WordEntity(
    id: '211',
    word: 'Hz. Yusuf',
    forbiddenWords: ['Kuyu', 'Rüya', 'Mısır', 'Güzel', 'Kardeş'],
  ),
  WordEntity(
    id: '212',
    word: 'Hz. Süleyman',
    forbiddenWords: ['Kral', 'Cin', 'Hayvan', 'Konuşmak', 'Peygamber'],
  ),
  WordEntity(
    id: '213',
    word: 'Hz. Davud',
    forbiddenWords: ['Zebur', 'Kral', 'Ses', 'Güzel', 'Peygamber'],
  ),
  WordEntity(
    id: '214',
    word: 'Hz. Eyyüp',
    forbiddenWords: ['Sabır', 'Hastalık', 'Sınav', 'Şifa', 'Peygamber'],
  ),
  WordEntity(
    id: '215',
    word: 'Hz. Yunus',
    forbiddenWords: ['Balık', 'Deniz', 'Karın', 'Dua', 'Peygamber'],
  ),
  WordEntity(
    id: '216',
    word: 'Hz. Yakup',
    forbiddenWords: ['İsrail', 'Yusuf', 'Göz', 'Ağlamak', 'Peygamber'],
  ),
  WordEntity(
    id: '217',
    word: 'Hz. İsmail',
    forbiddenWords: ['Kurban', 'İbrahim', 'Oğul', 'Kabe', 'Hacer'],
  ),
  WordEntity(
    id: '218',
    word: 'Hz. Zekeriya',
    forbiddenWords: ['Yahya', 'Baba', 'Dua', 'Yaşlı', 'Peygamber'],
  ),
  WordEntity(
    id: '219',
    word: 'Hz. Yahya',
    forbiddenWords: ['Zekeriya', 'Oğul', 'Şehit', 'Genç', 'Peygamber'],
  ),
  WordEntity(
    id: '220',
    word: 'Hz. Meryem',
    forbiddenWords: ['İsa', 'Anne', 'Bakire', 'Kutsal', 'Kadın'],
  ),
  WordEntity(
    id: '221',
    word: 'Hz. Hatice',
    forbiddenWords: ['Peygamber', 'Eş', 'İlk', 'Müslüman', 'Kadın'],
  ),
  WordEntity(
    id: '222',
    word: 'Hz. Aişe',
    forbiddenWords: ['Peygamber', 'Eş', 'Hadis', 'Rivayet', 'Alim'],
  ),
  WordEntity(
    id: '223',
    word: 'Hz. Fatıma',
    forbiddenWords: ['Peygamber', 'Kız', 'Ali', 'Eş', 'Cennet'],
  ),
  WordEntity(
    id: '224',
    word: 'Hz. Ali',
    forbiddenWords: ['Halife', 'Dördüncü', 'Fatıma', 'Eş', 'Kahraman'],
  ),
  WordEntity(
    id: '225',
    word: 'Hz. Ömer',
    forbiddenWords: ['Halife', 'İkinci', 'Adalet', 'Güçlü', 'Fetih'],
  ),
  WordEntity(
    id: '226',
    word: 'Hz. Osman',
    forbiddenWords: ['Halife', 'Üçüncü', 'Kuran', 'Toplama', 'Hayâ'],
  ),
  WordEntity(
    id: '227',
    word: 'Hz. Ebubekir',
    forbiddenWords: ['Halife', 'İlk', 'Sıddık', 'Dost', 'Hicret'],
  ),
  WordEntity(
    id: '228',
    word: 'Cebrail',
    forbiddenWords: ['Melek', 'Vahiy', 'Getiren', 'Kanat', 'Büyük'],
  ),
  WordEntity(
    id: '229',
    word: 'Mikail',
    forbiddenWords: ['Melek', 'Rızık', 'Yağmur', 'Görevli', 'Tabiat'],
  ),
  WordEntity(
    id: '230',
    word: 'Azrail',
    forbiddenWords: ['Melek', 'Ölüm', 'Can', 'Almak', 'Görevli'],
  ),
  WordEntity(
    id: '231',
    word: 'İsrafil',
    forbiddenWords: ['Melek', 'Sur', 'Üflemek', 'Kıyamet', 'Görevli'],
  ),
  WordEntity(
    id: '232',
    word: 'Kiramen Katibin',
    forbiddenWords: ['Melek', 'Yazmak', 'Amel', 'Sağ', 'Sol'],
  ),
  WordEntity(
    id: '233',
    word: 'Vitir',
    forbiddenWords: ['Namaz', 'Tek', 'Rekat', 'Gece', 'Yatsı'],
  ),
  WordEntity(
    id: '234',
    word: 'Kuşluk',
    forbiddenWords: ['Namaz', 'Sabah', 'Sonra', 'Güneş', 'Vakit'],
  ),
  WordEntity(
    id: '235',
    word: 'Teheccüd',
    forbiddenWords: ['Namaz', 'Gece', 'Kalkmak', 'Uyku', 'İbadet'],
  ),
  WordEntity(
    id: '236',
    word: 'Cuma Namazı',
    forbiddenWords: ['Hafta', 'Cami', 'Erkek', 'Farz', 'Hutbe'],
  ),
  WordEntity(
    id: '237',
    word: 'Cenaze Namazı',
    forbiddenWords: ['Ölü', 'Kılmak', 'Ayakta', 'Dua', 'Farz'],
  ),
  WordEntity(
    id: '238',
    word: 'Secdei Sahv',
    forbiddenWords: ['Namaz', 'Hata', 'Unutmak', 'Telafi', 'Son'],
  ),
  WordEntity(
    id: '239',
    word: 'Secdei Tilavet',
    forbiddenWords: ['Kuran', 'Okumak', 'Ayet', 'Secde', 'Duymak'],
  ),
  WordEntity(
    id: '240',
    word: 'Secdei Şükür',
    forbiddenWords: ['Nimet', 'Teşekkür', 'Allah', 'Sevinç', 'Haber'],
  ),
  WordEntity(
    id: '241',
    word: 'İtikaf',
    forbiddenWords: ['Cami', 'Kalmak', 'Ramazan', 'Son', 'On'],
  ),
  WordEntity(
    id: '242',
    word: 'Fidye',
    forbiddenWords: ['Oruç', 'Tutamayan', 'Para', 'Ödeme', 'Fakir'],
  ),
  WordEntity(
    id: '243',
    word: 'Nisap',
    forbiddenWords: ['Zekat', 'Sınır', 'Miktar', 'Altın', 'Gümüş'],
  ),
  WordEntity(
    id: '244',
    word: 'Öşür',
    forbiddenWords: ['Zekat', 'Tarım', 'Ürün', 'Onda', 'Bir'],
  ),
  WordEntity(
    id: '245',
    word: 'Uşur',
    forbiddenWords: ['Vergi', 'Ticaret', 'Mal', 'Gümrük', 'Ödeme'],
  ),
  WordEntity(
    id: '246',
    word: 'Haraç',
    forbiddenWords: ['Vergi', 'Toprak', 'Gayrimüslim', 'Ödeme', 'Devlet'],
  ),
  WordEntity(
    id: '247',
    word: 'Teyemmüm',
    forbiddenWords: ['Toprak', 'Su', 'Bulamayan', 'Abdest', 'Temiz'],
  ),
  WordEntity(
    id: '248',
    word: 'Mesh',
    forbiddenWords: ['Abdest', 'Çorap', 'Sıvazlamak', 'Baş', 'Ayak'],
  ),
  WordEntity(
    id: '249',
    word: 'Cenabet',
    forbiddenWords: ['Gusül', 'Gerektiren', 'Hal', 'Temizlik', 'Hüküm'],
  ),
  WordEntity(
    id: '250',
    word: 'Hayız',
    forbiddenWords: ['Kadın', 'Adet', 'Dönem', 'Namaz', 'Oruç'],
  ),
  WordEntity(
    id: '251',
    word: 'Nifas',
    forbiddenWords: ['Kadın', 'Doğum', 'Sonra', 'Kanama', 'Dönem'],
  ),
  WordEntity(
    id: '252',
    word: 'İstihaze',
    forbiddenWords: ['Kadın', 'Kanama', 'Adet', 'Dışı', 'Hastalık'],
  ),
  WordEntity(
    id: '253',
    word: 'Keffaret-i Yemin',
    forbiddenWords: ['Yemin', 'Bozma', 'Ödeme', 'Fakir', 'Doyurmak'],
  ),
  WordEntity(
    id: '254',
    word: 'Keffaret-i Savm',
    forbiddenWords: ['Oruç', 'Bozma', 'Altmış', 'Gün', 'Tutmak'],
  ),
  WordEntity(
    id: '255',
    word: 'Akika Kurbanı',
    forbiddenWords: ['Bebek', 'Doğum', 'Yedinci', 'Gün', 'Kesmek'],
  ),
  WordEntity(
    id: '256',
    word: 'Sadaka',
    forbiddenWords: ['Yardım', 'Para', 'Fakir', 'Vermek', 'Gönüllü'],
  ),
  WordEntity(
    id: '257',
    word: 'İnfak',
    forbiddenWords: ['Harcamak', 'Allah', 'Yolunda', 'Mal', 'Vermek'],
  ),
  WordEntity(
    id: '258',
    word: 'Rıza',
    forbiddenWords: ['Allah', 'Memnuniyet', 'Hoşnutluk', 'Kazanmak', 'Amaç'],
  ),
  WordEntity(
    id: '259',
    word: 'Bereket',
    forbiddenWords: ['Bolluk', 'Allah', 'Artmak', 'Hayır', 'Nimet'],
  ),
  WordEntity(
    id: '260',
    word: 'Rahmet',
    forbiddenWords: ['Allah', 'Merhamet', 'Acımak', 'Bağışlamak', 'Yağmur'],
  ),
  WordEntity(
    id: '261',
    word: 'Mağfiret',
    forbiddenWords: ['Allah', 'Bağışlamak', 'Günah', 'Af', 'Örtmek'],
  ),
  WordEntity(
    id: '262',
    word: 'Kelam',
    forbiddenWords: ['Allah', 'Söz', 'İlim', 'Akaid', 'İnanç'],
  ),
  WordEntity(
    id: '263',
    word: 'Fıkıh',
    forbiddenWords: ['İslam', 'Hukuk', 'İlim', 'Hüküm', 'Amel'],
  ),
  WordEntity(
    id: '264',
    word: 'Tefsir',
    forbiddenWords: ['Kuran', 'Açıklama', 'Yorum', 'İlim', 'Anlam'],
  ),
  WordEntity(
    id: '265',
    word: 'Siyer',
    forbiddenWords: ['Peygamber', 'Hayat', 'Tarih', 'İlim', 'Anlatmak'],
  ),
  WordEntity(
    id: '266',
    word: 'Akaid',
    forbiddenWords: ['İnanç', 'Esaslar', 'İlim', 'İman', 'Temel'],
  ),
  WordEntity(
    id: '267',
    word: 'Usul-ü Fıkıh',
    forbiddenWords: ['Hukuk', 'Metot', 'İlim', 'Kaynak', 'Hüküm'],
  ),
  WordEntity(
    id: '268',
    word: 'Hanefi',
    forbiddenWords: ['Mezhep', 'Ebu Hanife', 'Fıkıh', 'Türkiye', 'İmam'],
  ),
  WordEntity(
    id: '269',
    word: 'Şafii',
    forbiddenWords: ['Mezhep', 'İmam Şafii', 'Fıkıh', 'Arap', 'Hadis'],
  ),
  WordEntity(
    id: '270',
    word: 'Maliki',
    forbiddenWords: ['Mezhep', 'İmam Malik', 'Fıkıh', 'Afrika', 'Medine'],
  ),
  WordEntity(
    id: '271',
    word: 'Hanbeli',
    forbiddenWords: ['Mezhep', 'Ahmed bin Hanbel', 'Fıkıh', 'Suudi', 'Hadis'],
  ),
  WordEntity(
    id: '272',
    word: 'Maturidi',
    forbiddenWords: ['Akaid', 'Mezhep', 'İmam', 'İnanç', 'Kelam'],
  ),
  WordEntity(
    id: '273',
    word: 'Eşari',
    forbiddenWords: ['Akaid', 'Mezhep', 'İmam', 'İnanç', 'Kelam'],
  ),
  WordEntity(
    id: '274',
    word: 'Hak',
    forbiddenWords: ['Allah', 'İsim', 'Doğru', 'Gerçek', 'Adalet'],
  ),
  WordEntity(
    id: '280',
    word: 'Batıl',
    forbiddenWords: ['Yanlış', 'Hak', 'Olmayan', 'Geçersiz', 'Boş'],
  ),
  WordEntity(
    id: '281',
    word: 'Küfür',
    forbiddenWords: ['İnkar', 'Allah', 'Örtmek', 'Kafir', 'Nankörlük'],
  ),
  WordEntity(
    id: '282',
    word: 'İrtidat',
    forbiddenWords: ['Dinden', 'Çıkmak', 'Dönen', 'Mürted', 'Terk'],
  ),
  WordEntity(
    id: '283',
    word: 'Ridde',
    forbiddenWords: ['Dinden', 'Dönmek', 'Savaş', 'Ebubekir', 'İsyan'],
  ),
  WordEntity(
    id: '284',
    word: 'Fitne',
    forbiddenWords: ['Kargaşa', 'Bozgunculuk', 'İmtihan', 'Fesat', 'Kötülük'],
  ),
  WordEntity(
    id: '285',
    word: 'Nifak',
    forbiddenWords: ['Münafıklık', 'İki', 'Yüzlülük', 'Gizli', 'Küfür'],
  ),
  WordEntity(
    id: '286',
    word: 'Ricat',
    forbiddenWords: ['Geri', 'Dönmek', 'Boşanma', 'Evlilik', 'İddet'],
  ),
  WordEntity(
    id: '287',
    word: 'Hulu',
    forbiddenWords: ['Boşanma', 'Kadın', 'İstemek', 'Mehr', 'İade'],
  ),
  WordEntity(
    id: '288',
    word: 'Zıhar',
    forbiddenWords: ['Eş', 'Anne', 'Benzetmek', 'Haram', 'Kefaret'],
  ),
  WordEntity(
    id: '289',
    word: 'İla',
    forbiddenWords: ['Yemin', 'Eş', 'Yaklaşmamak', 'Dört', 'Ay'],
  ),
  WordEntity(
    id: '290',
    word: 'Lian',
    forbiddenWords: ['Lanetleşmek', 'Eş', 'Suçlama', 'Zina', 'Şahit'],
  ),
  WordEntity(
    id: '291',
    word: 'Velime',
    forbiddenWords: ['Düğün', 'Yemek', 'Davet', 'Evlilik', 'Kutlama'],
  ),
  WordEntity(
    id: '292',
    word: 'Veli',
    forbiddenWords: ['Evlilik', 'İzin', 'Veren', 'Baba', 'Koruyucu'],
  ),
  WordEntity(
    id: '293',
    word: 'Şahitlik',
    forbiddenWords: ['Görmek', 'Tanık', 'Doğru', 'Söylemek', 'Adalet'],
  ),
  WordEntity(
    id: '294',
    word: 'Kısas',
    forbiddenWords: ['Ceza', 'Aynı', 'Öldürmek', 'Yaralamak', 'Eşit'],
  ),
  WordEntity(
    id: '295',
    word: 'Diyet',
    forbiddenWords: ['Kan', 'Parası', 'Ödeme', 'Öldürmek', 'Tazminat'],
  ),
  WordEntity(
    id: '296',
    word: 'Hadd',
    forbiddenWords: ['Ceza', 'Sınır', 'Kuran', 'Belirlenen', 'Kesin'],
  ),
  WordEntity(
    id: '297',
    word: 'Tazir',
    forbiddenWords: ['Ceza', 'Hakim', 'Belirlenen', 'Caydırıcı', 'Takdir'],
  ),
  WordEntity(
    id: '298',
    word: 'Recm',
    forbiddenWords: ['Zina', 'Evli', 'Ceza', 'Taşlamak', 'Ölüm'],
  ),
  WordEntity(
    id: '299',
    word: 'Tevhid',
    forbiddenWords: ['Birlik', 'Allah', 'Tek', 'İnanç', 'Esas'],
  ),
  WordEntity(
    id: '300',
    word: 'Uluhiyet',
    forbiddenWords: ['İlahlık', 'Allah', 'Sıfat', 'Kulluk', 'Hak'],
  ),
  WordEntity(
    id: '301',
    word: 'Rububiyet',
    forbiddenWords: ['Rab', 'Allah', 'Sıfat', 'Yaratmak', 'İdare'],
  ),
  WordEntity(
    id: '302',
    word: 'Sıfat-ı Zatiye',
    forbiddenWords: ['Allah', 'Özellik', 'Varlık', 'Kıdem', 'Beka'],
  ),
  WordEntity(
    id: '303',
    word: 'Sıfat-ı Subutiye',
    forbiddenWords: ['Allah', 'Özellik', 'Hayat', 'İlim', 'Kudret'],
  ),
  WordEntity(
    id: '304',
    word: 'Levh-i Mahfuz',
    forbiddenWords: ['Yazılı', 'Kader', 'Korunan', 'Tablet', 'Allah'],
  ),
  WordEntity(
    id: '305',
    word: 'Kalem',
    forbiddenWords: ['Yazmak', 'Kader', 'İlk', 'Yaratılan', 'Sure'],
  ),
  WordEntity(
    id: '306',
    word: 'Kürsü',
    forbiddenWords: ['Allah', 'Taht', 'Gökyüzü', 'Yer', 'Kaplamak'],
  ),
  WordEntity(
    id: '307',
    word: 'Sidretül Münteha',
    forbiddenWords: ['Ağaç', 'Gökyüzü', 'Son', 'Sınır', 'Miraç'],
  ),
  WordEntity(
    id: '308',
    word: 'Beytül Mamur',
    forbiddenWords: ['Gökyüzü', 'Kabe', 'Melek', 'Tavaf', 'Yedinci'],
  ),
  WordEntity(
    id: '309',
    word: 'Arş-ı Ala',
    forbiddenWords: ['Allah', 'Taht', 'En', 'Yüksek', 'Gökyüzü'],
  ),
  WordEntity(
    id: '310',
    word: 'Felak Suresi',
    forbiddenWords: ['Kuran', 'Koruma', 'Sabah', 'Şer', 'Sığınmak'],
  ),
  WordEntity(
    id: '311',
    word: 'Nas Suresi',
    forbiddenWords: ['Kuran', 'Koruma', 'İnsan', 'Şeytan', 'Sığınmak'],
  ),
  WordEntity(
    id: '312',
    word: 'İhlas Suresi',
    forbiddenWords: ['Kuran', 'Allah', 'Bir', 'Tek', 'Samediyet'],
  ),
  WordEntity(
    id: '313',
    word: 'Kafirun Suresi',
    forbiddenWords: ['Kuran', 'Kafir', 'İnanç', 'Ayrılık', 'Din'],
  ),
  WordEntity(
    id: '314',
    word: 'Nasr Suresi',
    forbiddenWords: ['Kuran', 'Yardım', 'Zafer', 'Fetih', 'Mekke'],
  ),
  WordEntity(
    id: '315',
    word: 'Tebbet Suresi',
    forbiddenWords: ['Kuran', 'Ebu Leheb', 'Lanet', 'Amca', 'Ateş'],
  ),
  WordEntity(
    id: '316',
    word: 'Fil Suresi',
    forbiddenWords: ['Kuran', 'Ebrehe', 'Kabe', 'Ordu', 'Kuş'],
  ),
  WordEntity(
    id: '317',
    word: 'Kureyş Suresi',
    forbiddenWords: ['Kuran', 'Kabile', 'Mekke', 'Ticaret', 'Güvenlik'],
  ),
  WordEntity(
    id: '318',
    word: 'Maun Suresi',
    forbiddenWords: ['Kuran', 'Yardım', 'Yetim', 'Namaz', 'Gösteriş'],
  ),
  WordEntity(
    id: '319',
    word: 'Kevser Suresi',
    forbiddenWords: ['Kuran', 'Bolluk', 'Irmak', 'Namaz', 'Kurban'],
  ),
  WordEntity(
    id: '320',
    word: 'Asr Suresi',
    forbiddenWords: ['Kuran', 'Zaman', 'Hüsran', 'İman', 'Sabır'],
  ),
  WordEntity(
    id: '321',
    word: 'Tekasür Suresi',
    forbiddenWords: ['Kuran', 'Çokluk', 'Yarış', 'Dünya', 'Ahiret'],
  ),
  WordEntity(
    id: '322',
    word: 'Karia Suresi',
    forbiddenWords: ['Kuran', 'Kıyamet', 'Kapı', 'Çalmak', 'Korku'],
  ),
  WordEntity(
    id: '323',
    word: 'Adiyat Suresi',
    forbiddenWords: ['Kuran', 'At', 'Koşmak', 'Savaş', 'Nankör'],
  ),
  WordEntity(
    id: '324',
    word: 'Zilzal Suresi',
    forbiddenWords: ['Kuran', 'Deprem', 'Kıyamet', 'Yer', 'Zerre'],
  ),
  WordEntity(
    id: '325',
    word: 'Beyyine Suresi',
    forbiddenWords: ['Kuran', 'Delil', 'Açık', 'Ehli Kitap', 'Müşrik'],
  ),
  WordEntity(
    id: '326',
    word: 'Tin Suresi',
    forbiddenWords: ['Kuran', 'İncir', 'Zeytin', 'İnsan', 'Yaratılış'],
  ),
  WordEntity(
    id: '327',
    word: 'İnşirah Suresi',
    forbiddenWords: ['Kuran', 'Göğüs', 'Açmak', 'Kolaylık', 'Zorluk'],
  ),
  WordEntity(
    id: '328',
    word: 'Duha Suresi',
    forbiddenWords: ['Kuran', 'Kuşluk', 'Peygamber', 'Yetim', 'Nimet'],
  ),
  WordEntity(
    id: '329',
    word: 'Leyl Suresi',
    forbiddenWords: ['Kuran', 'Gece', 'Vermek', 'Cimrilik', 'Yol'],
  ),
  WordEntity(
    id: '330',
    word: 'Şems Suresi',
    forbiddenWords: ['Kuran', 'Güneş', 'Ay', 'Nefs', 'Temizlemek'],
  ),
  WordEntity(
    id: '331',
    word: 'Beled Suresi',
    forbiddenWords: ['Kuran', 'Şehir', 'Mekke', 'İnsan', 'Zorluk'],
  ),
  WordEntity(
    id: '332',
    word: 'Fecr Suresi',
    forbiddenWords: ['Kuran', 'Şafak', 'Ad', 'Semud', 'Firavun'],
  ),
  WordEntity(
    id: '333',
    word: 'Gaşiye Suresi',
    forbiddenWords: ['Kuran', 'Kıyamet', 'Örtmek', 'Yüz', 'Cennet'],
  ),
  WordEntity(
    id: '334',
    word: 'Ala Suresi',
    forbiddenWords: ['Kuran', 'Yüce', 'Tesbih', 'Temizlenmek', 'Hatırlatmak'],
  ),
  WordEntity(
    id: '335',
    word: 'Tarık Suresi',
    forbiddenWords: ['Kuran', 'Yıldız', 'Gece', 'Gelen', 'Delici'],
  ),
  WordEntity(
    id: '336',
    word: 'Buruc Suresi',
    forbiddenWords: ['Kuran', 'Burç', 'Gökyüzü', 'Ashab-ı Uhdud', 'Ateş'],
  ),
  WordEntity(
    id: '337',
    word: 'İnşikak Suresi',
    forbiddenWords: ['Kuran', 'Gökyüzü', 'Yarılmak', 'Kıyamet', 'Kitap'],
  ),
  WordEntity(
    id: '338',
    word: 'Mutaffifin Suresi',
    forbiddenWords: ['Kuran', 'Ölçü', 'Eksik', 'Tartı', 'Hile'],
  ),
  WordEntity(
    id: '339',
    word: 'İnfitar Suresi',
    forbiddenWords: ['Kuran', 'Gökyüzü', 'Yarılmak', 'Kıyamet', 'Melek'],
  ),
  WordEntity(
    id: '340',
    word: 'Tekvir Suresi',
    forbiddenWords: ['Kuran', 'Güneş', 'Dürülmek', 'Kıyamet', 'Yıldız'],
  ),
  WordEntity(
    id: '341',
    word: 'Abese Suresi',
    forbiddenWords: ['Kuran', 'Yüz', 'Çevirmek', 'Kör', 'Peygamber'],
  ),
  WordEntity(
    id: '342',
    word: 'Naziat Suresi',
    forbiddenWords: ['Kuran', 'Melek', 'Can', 'Çekmek', 'Kıyamet'],
  ),
  WordEntity(
    id: '343',
    word: 'Nebe Suresi',
    forbiddenWords: ['Kuran', 'Haber', 'Büyük', 'Kıyamet', 'Sormak'],
  ),
  WordEntity(
    id: '344',
    word: 'Mürselat Suresi',
    forbiddenWords: ['Kuran', 'Gönderilenler', 'Rüzgar', 'Melek', 'Kıyamet'],
  ),
  WordEntity(
    id: '345',
    word: 'İnsan Suresi',
    forbiddenWords: ['Kuran', 'Dehr', 'Yaratılış', 'İmtihan', 'Cennet'],
  ),
  WordEntity(
    id: '346',
    word: 'Kıyamet Suresi',
    forbiddenWords: ['Kuran', 'Diriliş', 'Hesap', 'Nefs', 'Yemin'],
  ),
  WordEntity(
    id: '347',
    word: 'Müddessir Suresi',
    forbiddenWords: ['Kuran', 'Örtünen', 'Peygamber', 'Uyarı', 'Kalk'],
  ),
  WordEntity(
    id: '348',
    word: 'Müzzemmil Suresi',
    forbiddenWords: ['Kuran', 'Bürünen', 'Peygamber', 'Gece', 'Namaz'],
  ),
  WordEntity(
    id: '349',
    word: 'Cin Suresi',
    forbiddenWords: ['Kuran', 'Cin', 'Dinlemek', 'İman', 'Gizli'],
  ),
  WordEntity(
    id: '350',
    word: 'Nuh Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Davet', 'Tufan', 'Kavim'],
  ),
  WordEntity(
    id: '351',
    word: 'Mearic Suresi',
    forbiddenWords: ['Kuran', 'Yükseliş', 'Derece', 'Azap', 'Melek'],
  ),
  WordEntity(
    id: '352',
    word: 'Hakka Suresi',
    forbiddenWords: ['Kuran', 'Gerçek', 'Kıyamet', 'Ad', 'Semud'],
  ),
  WordEntity(
    id: '353',
    word: 'Kalem Suresi',
    forbiddenWords: ['Kuran', 'Yazmak', 'Nun', 'Ahlak', 'Peygamber'],
  ),
  WordEntity(
    id: '354',
    word: 'Mülk Suresi',
    forbiddenWords: ['Kuran', 'Hükümranlık', 'Allah', 'Ölüm', 'Hayat'],
  ),
  WordEntity(
    id: '355',
    word: 'Tahrim Suresi',
    forbiddenWords: ['Kuran', 'Haram', 'Kılmak', 'Peygamber', 'Eş'],
  ),
  WordEntity(
    id: '356',
    word: 'Talak Suresi',
    forbiddenWords: ['Kuran', 'Boşanma', 'İddet', 'Kadın', 'Hüküm'],
  ),
  WordEntity(
    id: '357',
    word: 'Tegabün Suresi',
    forbiddenWords: ['Kuran', 'Aldanma', 'Kıyamet', 'Gün', 'İman'],
  ),
  WordEntity(
    id: '358',
    word: 'Münafikun Suresi',
    forbiddenWords: ['Kuran', 'Münafık', 'İki', 'Yüzlü', 'Yalan'],
  ),
  WordEntity(
    id: '359',
    word: 'Cuma Suresi',
    forbiddenWords: ['Kuran', 'Namaz', 'Hutbe', 'Toplanmak', 'Gün'],
  ),
  WordEntity(
    id: '360',
    word: 'Saff Suresi',
    forbiddenWords: ['Kuran', 'Sıra', 'Savaş', 'Allah', 'Yolunda'],
  ),
  WordEntity(
    id: '361',
    word: 'Mümtehine Suresi',
    forbiddenWords: ['Kuran', 'İmtihan', 'Kadın', 'Müşrik', 'Dostluk'],
  ),
  WordEntity(
    id: '362',
    word: 'Haşr Suresi',
    forbiddenWords: ['Kuran', 'Toplanmak', 'Yahudi', 'Sürgün', 'Esma'],
  ),
  WordEntity(
    id: '363',
    word: 'Mücadele Suresi',
    forbiddenWords: ['Kuran', 'Tartışma', 'Kadın', 'Zıhar', 'Şikayet'],
  ),
  WordEntity(
    id: '364',
    word: 'Hadid Suresi',
    forbiddenWords: ['Kuran', 'Demir', 'Savaş', 'İnfak', 'Dünya'],
  ),
  WordEntity(
    id: '365',
    word: 'Vakıa Suresi',
    forbiddenWords: ['Kuran', 'Kıyamet', 'Olay', 'Üç', 'Grup'],
  ),
  WordEntity(
    id: '366',
    word: 'Rahman Suresi',
    forbiddenWords: ['Kuran', 'Allah', 'Nimet', 'Yalanlama', 'Cennet'],
  ),
  WordEntity(
    id: '367',
    word: 'Kamer Suresi',
    forbiddenWords: ['Kuran', 'Ay', 'Yarılmak', 'Mucize', 'Kıyamet'],
  ),
  WordEntity(
    id: '368',
    word: 'Necm Suresi',
    forbiddenWords: ['Kuran', 'Yıldız', 'Miraç', 'Vahiy', 'Sidre'],
  ),
  WordEntity(
    id: '369',
    word: 'Tur Suresi',
    forbiddenWords: ['Kuran', 'Dağ', 'Sina', 'Yemin', 'Azap'],
  ),
  WordEntity(
    id: '370',
    word: 'Zariyat Suresi',
    forbiddenWords: ['Kuran', 'Rüzgar', 'Savuran', 'Yaratılış', 'İbrahim'],
  ),
  WordEntity(
    id: '371',
    word: 'Kaf Suresi',
    forbiddenWords: ['Kuran', 'Harf', 'Diriliş', 'Yakın', 'Melek'],
  ),
  WordEntity(
    id: '372',
    word: 'Hucurat Suresi',
    forbiddenWords: ['Kuran', 'Odalar', 'Edep', 'Alay', 'Kardeşlik'],
  ),
  WordEntity(
    id: '373',
    word: 'Fetih Suresi',
    forbiddenWords: ['Kuran', 'Zafer', 'Mekke', 'Hudeybiye', 'Biat'],
  ),
  WordEntity(
    id: '374',
    word: 'Muhammed Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Savaş', 'Kafir', 'Cennet'],
  ),
  WordEntity(
    id: '375',
    word: 'Ahkaf Suresi',
    forbiddenWords: ['Kuran', 'Kum', 'Tepe', 'Ad', 'Kavmi'],
  ),
  WordEntity(
    id: '376',
    word: 'Casiye Suresi',
    forbiddenWords: ['Kuran', 'Diz', 'Çökmek', 'Kıyamet', 'Hesap'],
  ),
  WordEntity(
    id: '377',
    word: 'Duhan Suresi',
    forbiddenWords: ['Kuran', 'Duman', 'Kıyamet', 'Alamet', 'Firavun'],
  ),
  WordEntity(
    id: '378',
    word: 'Zuhruf Suresi',
    forbiddenWords: ['Kuran', 'Süs', 'Altın', 'Dünya', 'Ahiret'],
  ),
  WordEntity(
    id: '379',
    word: 'Şura Suresi',
    forbiddenWords: ['Kuran', 'Danışma', 'İstişare', 'Vahiy', 'Birlik'],
  ),
  WordEntity(
    id: '380',
    word: 'Fussilet Suresi',
    forbiddenWords: ['Kuran', 'Açıklamak', 'Ayet', 'Secde', 'Yaratılış'],
  ),
  WordEntity(
    id: '381',
    word: 'Mümin Suresi',
    forbiddenWords: ['Kuran', 'İnanan', 'Firavun', 'Musa', 'Azap'],
  ),
  WordEntity(
    id: '382',
    word: 'Zümer Suresi',
    forbiddenWords: ['Kuran', 'Gruplar', 'Cennet', 'Cehennem', 'İhlas'],
  ),
  WordEntity(
    id: '383',
    word: 'Sad Suresi',
    forbiddenWords: ['Kuran', 'Harf', 'Davud', 'Süleyman', 'İblis'],
  ),
  WordEntity(
    id: '384',
    word: 'Saffat Suresi',
    forbiddenWords: ['Kuran', 'Sıra', 'Melek', 'Şeytan', 'İbrahim'],
  ),
  WordEntity(
    id: '385',
    word: 'Fatır Suresi',
    forbiddenWords: ['Kuran', 'Yaratan', 'Melek', 'Kanat', 'Nimet'],
  ),
  WordEntity(
    id: '386',
    word: 'Sebe Suresi',
    forbiddenWords: ['Kuran', 'Krallık', 'Yemen', 'Süleyman', 'Sel'],
  ),
  WordEntity(
    id: '387',
    word: 'Ahzab Suresi',
    forbiddenWords: ['Kuran', 'Hendek', 'Savaş', 'Gruplar', 'Peygamber'],
  ),
  WordEntity(
    id: '388',
    word: 'Secde Suresi',
    forbiddenWords: ['Kuran', 'Kapanmak', 'Yaratılış', 'Kıyamet', 'Gece'],
  ),
  WordEntity(
    id: '389',
    word: 'Lokman Suresi',
    forbiddenWords: ['Kuran', 'Hikmet', 'Nasihat', 'Oğul', 'Şükür'],
  ),
  WordEntity(
    id: '390',
    word: 'Rum Suresi',
    forbiddenWords: ['Kuran', 'Bizans', 'Savaş', 'Zafer', 'Yenilgi'],
  ),
  WordEntity(
    id: '391',
    word: 'Ankebut Suresi',
    forbiddenWords: ['Kuran', 'Örümcek', 'Ev', 'İmtihan', 'Fitne'],
  ),
  WordEntity(
    id: '392',
    word: 'Kasas Suresi',
    forbiddenWords: ['Kuran', 'Hikaye', 'Musa', 'Firavun', 'Karun'],
  ),
  WordEntity(
    id: '393',
    word: 'Neml Suresi',
    forbiddenWords: ['Kuran', 'Karınca', 'Süleyman', 'Hüdhüd', 'Sebe'],
  ),
  WordEntity(
    id: '394',
    word: 'Şuara Suresi',
    forbiddenWords: ['Kuran', 'Şair', 'Musa', 'İbrahim', 'Nuh'],
  ),
  WordEntity(
    id: '395',
    word: 'Furkan Suresi',
    forbiddenWords: ['Kuran', 'Ayırt', 'Edici', 'Hak', 'Batıl'],
  ),
  WordEntity(
    id: '396',
    word: 'Nur Suresi',
    forbiddenWords: ['Kuran', 'Işık', 'Örtünme', 'İfk', 'Zina'],
  ),
  WordEntity(
    id: '397',
    word: 'Müminun Suresi',
    forbiddenWords: ['Kuran', 'İnananlar', 'Kurtuluş', 'Namaz', 'Huşu'],
  ),
  WordEntity(
    id: '398',
    word: 'Hacc Suresi',
    forbiddenWords: ['Kuran', 'Hac', 'İbrahim', 'Kabe', 'Kurban'],
  ),
  WordEntity(
    id: '399',
    word: 'Enbiya Suresi',
    forbiddenWords: ['Kuran', 'Peygamberler', 'Kıssa', 'Tevhid', 'Hesap'],
  ),
  WordEntity(
    id: '400',
    word: 'Taha Suresi',
    forbiddenWords: ['Kuran', 'Musa', 'Firavun', 'Asa', 'Vadii Tuva'],
  ),
  WordEntity(
    id: '401',
    word: 'Meryem Suresi',
    forbiddenWords: ['Kuran', 'Hz. Meryem', 'İsa', 'Zekeriya', 'Yahya'],
  ),
  WordEntity(
    id: '402',
    word: 'Kehf Suresi',
    forbiddenWords: ['Kuran', 'Mağara', 'Ashab', 'Cuma', 'Zülkarneyn'],
  ),
  WordEntity(
    id: '403',
    word: 'İsra Suresi',
    forbiddenWords: ['Kuran', 'Gece', 'Yürüyüş', 'Mescidi Aksa', 'Miraç'],
  ),
  WordEntity(
    id: '404',
    word: 'Nahl Suresi',
    forbiddenWords: ['Kuran', 'Arı', 'Bal', 'Nimet', 'Şükür'],
  ),
  WordEntity(
    id: '405',
    word: 'Hicr Suresi',
    forbiddenWords: ['Kuran', 'Taşlık', 'Bölge', 'Semud', 'Koruma'],
  ),
  WordEntity(
    id: '406',
    word: 'İbrahim Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Dua', 'Nimet', 'Şükür'],
  ),
  WordEntity(
    id: '407',
    word: 'Rad Suresi',
    forbiddenWords: ['Kuran', 'Gök', 'Gürültüsü', 'Şimşek', 'Tesbih'],
  ),
  WordEntity(
    id: '408',
    word: 'Yusuf Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Rüya', 'Kardeş', 'Mısır'],
  ),
  WordEntity(
    id: '409',
    word: 'Hud Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Ad', 'Kavmi', 'Nuh'],
  ),
  WordEntity(
    id: '410',
    word: 'Yunus Suresi',
    forbiddenWords: ['Kuran', 'Peygamber', 'Balık', 'Tövbe', 'Kavim'],
  ),
  WordEntity(
    id: '411',
    word: 'Tevbe Suresi',
    forbiddenWords: ['Kuran', 'Pişmanlık', 'Besmele', 'Savaş', 'Münafık'],
  ),
  WordEntity(
    id: '412',
    word: 'Enfal Suresi',
    forbiddenWords: ['Kuran', 'Ganimet', 'Bedir', 'Savaş', 'Zafer'],
  ),
  WordEntity(
    id: '413',
    word: 'Araf Suresi',
    forbiddenWords: ['Kuran', 'Sınır', 'Cennet', 'Cehennem', 'Arası'],
  ),
  WordEntity(
    id: '414',
    word: 'Enam Suresi',
    forbiddenWords: ['Kuran', 'Hayvan', 'Tevhid', 'Şirk', 'Yaratılış'],
  ),
  WordEntity(
    id: '415',
    word: 'Maide Suresi',
    forbiddenWords: ['Kuran', 'Sofra', 'İsa', 'Havari', 'Akit'],
  ),
  WordEntity(
    id: '416',
    word: 'Nisa Suresi',
    forbiddenWords: ['Kuran', 'Kadın', 'Miras', 'Evlilik', 'Hukuk'],
  ),
  WordEntity(
    id: '417',
    word: 'Ali İmran Suresi',
    forbiddenWords: ['Kuran', 'Aile', 'Meryem', 'Uhud', 'İmran'],
  ),
  WordEntity(
    id: '418',
    word: 'Bakara Suresi',
    forbiddenWords: ['Kuran', 'İnek', 'En', 'Uzun', 'Musa'],
  ),
  WordEntity(
    id: '419',
    word: 'Ashab-ı Kehf',
    forbiddenWords: ['Mağara', 'Uyku', 'Yıl', 'Genç', 'Köpek'],
  ),
  WordEntity(
    id: '420',
    word: 'Zülkarneyn',
    forbiddenWords: ['Kral', 'Doğu', 'Batı', 'Set', 'Yecüc'],
  ),
  WordEntity(
    id: '421',
    word: 'Hızır',
    forbiddenWords: ['Musa', 'Yolculuk', 'İlim', 'Ledün', 'Gemi'],
  ),
  WordEntity(
    id: '422',
    word: 'Karun',
    forbiddenWords: ['Zengin', 'Musa', 'Hazine', 'Kibir', 'Yerin'],
  ),
  WordEntity(
    id: '423',
    word: 'Firavun',
    forbiddenWords: ['Mısır', 'Kral', 'Musa', 'Zulüm', 'Deniz'],
  ),
  WordEntity(
    id: '424',
    word: 'Haman',
    forbiddenWords: ['Firavun', 'Vezir', 'Mısır', 'Kule', 'Musa'],
  ),
  WordEntity(
    id: '425',
    word: 'Nemrut',
    forbiddenWords: ['Kral', 'İbrahim', 'Ateş', 'Kibir', 'Allah'],
  ),
  WordEntity(
    id: '426',
    word: 'Ad Kavmi',
    forbiddenWords: ['Hud', 'Rüzgar', 'Helak', 'Dev', 'Güçlü'],
  ),
  WordEntity(
    id: '427',
    word: 'Semud Kavmi',
    forbiddenWords: ['Salih', 'Deve', 'Kaya', 'Ev', 'Helak'],
  ),
  WordEntity(
    id: '428',
    word: 'Lut Kavmi',
    forbiddenWords: ['Sodom', 'Gomore', 'Günah', 'Helak', 'Taş'],
  ),
  WordEntity(
    id: '429',
    word: 'Ashab-ı Fil',
    forbiddenWords: ['Ebrehe', 'Kabe', 'Fil', 'Ordu', 'Kuş'],
  ),
  WordEntity(
    id: '430',
    word: 'Ashab-ı Uhdud',
    forbiddenWords: ['Hendek', 'Ateş', 'Mümin', 'Yakmak', 'Şehit'],
  ),
  WordEntity(
    id: '431',
    word: 'Havari',
    forbiddenWords: ['İsa', 'Öğrenci', 'On iki', 'Yardımcı', 'Sofra'],
  ),
  WordEntity(
    id: '432',
    word: 'Talut',
    forbiddenWords: ['Kral', 'İsrail', 'Calut', 'Savaş', 'Davud'],
  ),
  WordEntity(
    id: '433',
    word: 'Calut',
    forbiddenWords: ['Dev', 'Savaş', 'Davud', 'Taş', 'Öldürmek'],
  ),
  WordEntity(
    id: '434',
    word: 'Belkıs',
    forbiddenWords: ['Sebe', 'Kraliçe', 'Süleyman', 'Taht', 'Güneş'],
  ),
  WordEntity(
    id: '435',
    word: 'Asiye',
    forbiddenWords: ['Firavun', 'Eş', 'Musa', 'Büyütmek', 'Cennet'],
  ),
  WordEntity(
    id: '436',
    word: 'Hacer',
    forbiddenWords: ['İbrahim', 'Cariye', 'İsmail', 'Anne', 'Zemzem'],
  ),
  WordEntity(
    id: '437',
    word: 'Mescid-i Aksa',
    forbiddenWords: ['Kudüs', 'Kıble', 'İlk', 'Miraç', 'Filistin'],
  ),
  WordEntity(
    id: '438',
    word: 'Mescid-i Haram',
    forbiddenWords: ['Mekke', 'Kabe', 'Kutsal', 'Hac', 'Tavaf'],
  ),
  WordEntity(
    id: '439',
    word: 'Mescid-i Nebevi',
    forbiddenWords: ['Medine', 'Peygamber', 'Cami', 'Ravza', 'Minber'],
  ),
  WordEntity(
    id: '440',
    word: 'Kuba Mescidi',
    forbiddenWords: ['Medine', 'İlk', 'Cami', 'İslam', 'Hicret'],
  ),
  WordEntity(
    id: '441',
    word: 'Kıbleteyn Mescidi',
    forbiddenWords: ['İki', 'Kıble', 'Medine', 'Değişim', 'Namaz'],
  ),
  WordEntity(
    id: '442',
    word: 'Hudeybiye',
    forbiddenWords: ['Antlaşma', 'Mekke', 'Barış', 'Fetih', 'Biat'],
  ),
  WordEntity(
    id: '443',
    word: 'Biat-ı Rıdvan',
    forbiddenWords: ['Ağaç', 'Altında', 'Biat', 'Hudeybiye', 'Sahabe'],
  ),
  WordEntity(
    id: '444',
    word: 'Akabe Biatı',
    forbiddenWords: ['Medine', 'Biat', 'Gece', 'Hicret', 'Söz'],
  ),
  WordEntity(
    id: '445',
    word: 'Mekke Fethi',
    forbiddenWords: ['Zafer', 'Kabe', 'Put', 'Kırılmak', 'Af'],
  ),
  WordEntity(
    id: '446',
    word: 'Hayber Fethi',
    forbiddenWords: ['Yahudi', 'Kale', 'Zafer', 'Ali', 'Kapı'],
  ),
  WordEntity(
    id: '447',
    word: 'Taif Kuşatması',
    forbiddenWords: ['Şehir', 'Kuşatma', 'Taşlamak', 'Sakif', 'Dua'],
  ),
  WordEntity(
    id: '448',
    word: 'Tebük Seferi',
    forbiddenWords: ['Son', 'Sefer', 'Bizans', 'Sıcak', 'Uzak'],
  ),
  WordEntity(
    id: '449',
    word: 'Mute Savaşı',
    forbiddenWords: ['Bizans', 'Şehit', 'Üç', 'Komutan', 'Halid'],
  ),
  WordEntity(
    id: '450',
    word: 'Halid bin Velid',
    forbiddenWords: ['Komutan', 'Kılıç', 'Allah', 'Seyfullah', 'Zafer'],
  ),
  WordEntity(
    id: '451',
    word: 'Ammar bin Yasir',
    forbiddenWords: ['Sahabe', 'Şehit', 'İlk', 'Aile', 'İşkence'],
  ),
  WordEntity(
    id: '452',
    word: 'Bilal-i Habeşi',
    forbiddenWords: ['Müezzin', 'İlk', 'Ezan', 'Köle', 'Ehad'],
  ),
  WordEntity(
    id: '453',
    word: 'Selman-ı Farisi',
    forbiddenWords: ['Sahabe', 'İran', 'Hendek', 'Fikir', 'Ehli Beyt'],
  ),
  WordEntity(
    id: '454',
    word: 'Ebu Zer Gıfari',
    forbiddenWords: ['Sahabe', 'Zühd', 'Fakir', 'Doğru', 'Sözlü'],
  ),
  WordEntity(
    id: '455',
    word: 'Ebu Hureyre',
    forbiddenWords: ['Sahabe', 'Hadis', 'Rivayet', 'En', 'Çok'],
  ),
  WordEntity(
    id: '456',
    word: 'Abdullah bin Mesud',
    forbiddenWords: ['Sahabe', 'Kuran', 'Hafız', 'Alim', 'Kıraat'],
  ),
  WordEntity(
    id: '457',
    word: 'Muaz bin Cebel',
    forbiddenWords: ['Sahabe', 'Alim', 'Yemen', 'Vali', 'Fetva'],
  ),
  WordEntity(
    id: '458',
    word: 'Sad bin Ebi Vakkas',
    forbiddenWords: ['Sahabe', 'Ok', 'Atan', 'İlk', 'Cennetle'],
  ),
  WordEntity(
    id: '459',
    word: 'Talha bin Ubeydullah',
    forbiddenWords: ['Sahabe', 'Cennetle', 'Müjdelenen', 'Uhud', 'Kalkan'],
  ),
  WordEntity(
    id: '460',
    word: 'Zübeyr bin Avvam',
    forbiddenWords: ['Sahabe', 'Cennetle', 'Müjdelenen', 'Havari', 'Kılıç'],
  ),
  WordEntity(
    id: '461',
    word: 'Abdurrahman bin Avf',
    forbiddenWords: ['Sahabe', 'Cennetle', 'Müjdelenen', 'Zengin', 'Cömert'],
  ),
  WordEntity(
    id: '462',
    word: 'Ebu Ubeyde bin Cerrah',
    forbiddenWords: ['Sahabe', 'Cennetle', 'Müjdelenen', 'Emin', 'Komutan'],
  ),
  WordEntity(
    id: '463',
    word: 'Said bin Zeyd',
    forbiddenWords: ['Sahabe', 'Cennetle', 'Müjdelenen', 'Ömer', 'Enişte'],
  ),
  WordEntity(
    id: '464',
    word: 'Mus\'ab bin Umeyr',
    forbiddenWords: ['Sahabe', 'Sancak', 'Uhud', 'Şehit', 'Öğretmen'],
  ),
  WordEntity(
    id: '465',
    word: 'Hamza',
    forbiddenWords: ['Amca', 'Peygamber', 'Şehit', 'Aslan', 'Uhud'],
  ),
  WordEntity(
    id: '466',
    word: 'Cafer bin Ebi Talib',
    forbiddenWords: ['Sahabe', 'Habeşistan', 'Hicret', 'Mute', 'Şehit'],
  ),
  WordEntity(
    id: '467',
    word: 'Ümmü Seleme',
    forbiddenWords: ['Peygamber', 'Eş', 'Sahabe', 'Kadın', 'Hikmet'],
  ),
  WordEntity(
    id: '468',
    word: 'Ümmü Hani',
    forbiddenWords: ['Mekke', 'Fetih', 'Eman', 'Peygamber', 'Miraç'],
  ),
  WordEntity(
    id: '469',
    word: 'Rukiye',
    forbiddenWords: ['Peygamber', 'Kız', 'Osman', 'Eş', 'Habeşistan'],
  ),
  WordEntity(
    id: '470',
    word: 'Ümmü Gülsüm',
    forbiddenWords: ['Peygamber', 'Kız', 'Osman', 'Eş', 'İkinci'],
  ),
  WordEntity(
    id: '471',
    word: 'Zeynep bint Muhammed',
    forbiddenWords: ['Peygamber', 'Kız', 'Büyük', 'Ebu\'l As', 'Eş'],
  ),
  WordEntity(
    id: '472',
    word: 'Hasan bin Ali',
    forbiddenWords: ['Torun', 'Peygamber', 'Halife', 'Beşinci', 'Barış'],
  ),
  WordEntity(
    id: '473',
    word: 'Hüseyin bin Ali',
    forbiddenWords: ['Torun', 'Peygamber', 'Kerbela', 'Şehit', 'İmam'],
  ),
  WordEntity(
    id: '474',
    word: 'Ebu Talib',
    forbiddenWords: ['Amca', 'Peygamber', 'Korumak', 'Mekke', 'Boykot'],
  ),
  WordEntity(
    id: '475',
    word: 'Ebu Leheb',
    forbiddenWords: ['Amca', 'Peygamber', 'Düşman', 'Tebbet', 'Ateş'],
  ),
  WordEntity(
    id: '476',
    word: 'Ebu Cehil',
    forbiddenWords: ['Düşman', 'Mekke', 'Bedir', 'Öldürülmek', 'Firavun'],
  ),
  WordEntity(
    id: '477',
    word: 'Ebu Süfyan',
    forbiddenWords: ['Mekke', 'Lider', 'Müslüman', 'Fetih', 'Ümeyye'],
  ),
  WordEntity(
    id: '478',
    word: 'Vahşi',
    forbiddenWords: ['Hamza', 'Şehit', 'Mızrak', 'Tövbe', 'Müslüman'],
  ),
  WordEntity(
    id: '479',
    word: 'Hind bint Utbe',
    forbiddenWords: ['Ebu Süfyan', 'Eş', 'Hamza', 'Müslüman', 'Fetih'],
  ),
  WordEntity(
    id: '480',
    word: 'Suheyb-i Rumi',
    forbiddenWords: ['Sahabe', 'Rum', 'Hicret', 'Mal', 'Bırakmak'],
  ),
  WordEntity(
    id: '481',
    word: 'Zeyd bin Harise',
    forbiddenWords: ['Evlatlık', 'Peygamber', 'Azat', 'Mute', 'Şehit'],
  ),
  WordEntity(
    id: '482',
    word: 'Usame bin Zeyd',
    forbiddenWords: ['Komutan', 'Genç', 'Ordu', 'Son', 'Sefer'],
  ),
  WordEntity(
    id: '483',
    word: 'Ümmü Eymen',
    forbiddenWords: ['Dadı', 'Peygamber', 'Habeşistan', 'Sahabe', 'Kadın'],
  ),
  WordEntity(
    id: '484',
    word: 'Sevde bint Zem\'a',
    forbiddenWords: ['Peygamber', 'Eş', 'İkinci', 'Hatice', 'Sonra'],
  ),
  WordEntity(
    id: '485',
    word: 'Hafsa bint Ömer',
    forbiddenWords: ['Peygamber', 'Eş', 'Ömer', 'Kız', 'Kuran'],
  ),
  WordEntity(
    id: '486',
    word: 'Zeynep bint Huzeyme',
    forbiddenWords: ['Peygamber', 'Eş', 'Yoksul', 'Anne', 'Vefat'],
  ),
  WordEntity(
    id: '487',
    word: 'Zeynep bint Cahş',
    forbiddenWords: ['Peygamber', 'Eş', 'Zeyd', 'Ayet', 'İnen'],
  ),
  WordEntity(
    id: '488',
    word: 'Cüveyriye bint Haris',
    forbiddenWords: ['Peygamber', 'Eş', 'Esir', 'Serbest', 'Kabile'],
  ),
  WordEntity(
    id: '489',
    word: 'Safiyye bint Huyey',
    forbiddenWords: ['Peygamber', 'Eş', 'Yahudi', 'Hayber', 'Müslüman'],
  ),
  WordEntity(
    id: '490',
    word: 'Meymune bint Haris',
    forbiddenWords: ['Peygamber', 'Eş', 'Son', 'Mekke', 'Umre'],
  ),
  WordEntity(
    id: '491',
    word: 'Mariye',
    forbiddenWords: ['Peygamber', 'Cariye', 'Mısır', 'İbrahim', 'Anne'],
  ),
  WordEntity(
    id: '492',
    word: 'İbrahim bin Muhammed',
    forbiddenWords: ['Peygamber', 'Oğul', 'Bebek', 'Vefat', 'Güneş'],
  ),
  WordEntity(
    id: '493',
    word: 'Kasım bin Muhammed',
    forbiddenWords: ['Peygamber', 'Oğul', 'İlk', 'Vefat', 'Bebek'],
  ),
  WordEntity(
    id: '494',
    word: 'Abdullah bin Muhammed',
    forbiddenWords: ['Peygamber', 'Oğul', 'Tayyib', 'Tahir', 'Vefat'],
  ),
  WordEntity(
    id: '495',
    word: 'Veda Haccı',
    forbiddenWords: ['Son', 'Hac', 'Peygamber', 'Hutbe', 'Arafat'],
  ),
  WordEntity(
    id: '496',
    word: 'Gadir Hum',
    forbiddenWords: ['Yer', 'Ali', 'Hutbe', 'Veda', 'Dönüş'],
  ),
  WordEntity(
    id: '497',
    word: 'Sakife',
    forbiddenWords: ['Toplantı', 'Halife', 'Seçim', 'Ebubekir', 'Medine'],
  ),
  WordEntity(
    id: '498',
    word: 'Sıffin Savaşı',
    forbiddenWords: ['Ali', 'Muaviye', 'Savaş', 'Hakem', 'Fitne'],
  ),
  WordEntity(
    id: '499',
    word: 'Cemel Savaşı',
    forbiddenWords: ['Ali', 'Aişe', 'Deve', 'Savaş', 'Fitne'],
  ),
  WordEntity(
    id: '500',
    word: 'Hariciler',
    forbiddenWords: ['Grup', 'Ayrılmak', 'Ali', 'Tekfir', 'Aşırı'],
  ),
];
