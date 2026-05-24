// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Tabubu';

  @override
  String get homeStartGame => 'Mulai Permainan';

  @override
  String get homeSettings => 'Pengaturan';

  @override
  String get homeWords => 'Kata-kata';

  @override
  String get homeStatistics => 'Statistik';

  @override
  String get settingsTitle => 'Pengaturan Permainan';

  @override
  String get settingsLoadError => 'Gagal memuat pengaturan: ';

  @override
  String get settingsGameDuration => 'Durasi Ronde';

  @override
  String settingsMaxPasses(int count) {
    return 'Maksimal Lewat: $count';
  }

  @override
  String settingsPassesLabel(int count) {
    return '$count lewatan';
  }

  @override
  String get settingsPassSettings => 'Pengaturan Lewat';

  @override
  String settingsPassPenalty(int seconds) {
    return 'Penalti lewat: $seconds detik';
  }

  @override
  String get settingsWordSettings => 'Pengaturan Kata';

  @override
  String get settingsShuffleWords => 'Acak Kata';

  @override
  String get settingsShuffleHint =>
      'Urutan kata diacak di awal setiap permainan.';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageTurkish => 'Turki';

  @override
  String get settingsLanguageEnglish => 'Inggris';

  @override
  String get settingsLanguageArabic => 'Arab';

  @override
  String get settingsLanguageGerman => 'Jerman';

  @override
  String get settingsLanguageFrench => 'Prancis';

  @override
  String get settingsLanguageIndonesian => 'Indonesia';

  @override
  String get statisticsTitle => 'Statistik';

  @override
  String get statisticsLoadError => 'Gagal memuat statistik: ';

  @override
  String get statisticsEmptyTitle => 'Belum Ada Statistik';

  @override
  String get statisticsEmptySubtitle =>
      'Statistik akan muncul di sini setelah permainan selesai';

  @override
  String get statisticsDeleteTitle => 'Hapus Statistik';

  @override
  String get statisticsDeleteSuccess => 'Statistik berhasil dihapus';

  @override
  String statisticsDeleteConfirm(String date) {
    return 'Apakah Anda yakin ingin menghapus statistik permainan tanggal $date?';
  }

  @override
  String get statisticsDetailedTitle => 'Statistik Terperinci';

  @override
  String get statisticsCorrectWords => 'Kata yang Ditebak dengan Benar';

  @override
  String get statisticsCorrect => 'Benar';

  @override
  String get statisticsPassedWords => 'Kata yang Dilewati';

  @override
  String get statisticsPassed => 'Dilewati';

  @override
  String get statisticsHighScore => 'Skor Tertinggi';

  @override
  String get statisticsTime => 'Waktu';

  @override
  String get statisticsTeamScores => 'Skor Tim';

  @override
  String get statisticsWinnerTeam => 'Tim Pemenang';

  @override
  String get statisticsTeamPerformance => 'Performa Tim';

  @override
  String get statisticsWordDetails => 'Detail Kata';

  @override
  String get statisticsCorrectCount => 'Benar';

  @override
  String get statisticsPassCount => 'Lewat';

  @override
  String get statisticsTabuCount => 'Tabu';

  @override
  String get statisticsGameDate => 'Tanggal Permainan';

  @override
  String get statisticsScore => 'Skor';

  @override
  String get statisticsNone => 'Tidak ada';

  @override
  String statisticsDurationSeconds(int count) {
    return '$count detik';
  }

  @override
  String get commonClose => 'Tutup';

  @override
  String get teamSetupTitle => 'BUAT TIM ANDA';

  @override
  String get teamSetupHowMany => 'Berapa tim yang akan bermain?';

  @override
  String teamSetupDefaultName(int index) {
    return 'Tim $index';
  }

  @override
  String get gameErrorOccurred => 'Terjadi kesalahan:\n\n';

  @override
  String get gameNewGame => 'PERMAINAN BARU';

  @override
  String get gameOver => 'PERMAINAN SELESAI';

  @override
  String get gameOverHero => 'PERMAINAN YANG SERU!';

  @override
  String get gameOverExit => 'KELUAR';

  @override
  String get gameOverAgain => 'MAIN LAGI';

  @override
  String get gameReadyHeader => 'SKOR SAAT INI';

  @override
  String get gameReadyNextTeam => 'TIM BERIKUTNYA';

  @override
  String get gameReadyStart => 'MULAI';

  @override
  String gameTeamReady(String teamName) {
    return '$teamName Siap';
  }

  @override
  String gameTeamPlaying(String teamName) {
    return '$teamName Sedang Bermain';
  }

  @override
  String get gameStatusFinished => 'Permainan Selesai';

  @override
  String get gameTeamSelection => 'Pilih Tim';

  @override
  String get gamePaused => 'Dijeda';

  @override
  String get gameCorrect => 'Benar';

  @override
  String get gamePass => 'Lewat';

  @override
  String get gameTabu => 'Tabu';

  @override
  String get gameResume => 'LANJUTKAN';

  @override
  String gamePassCount(int used, int max) {
    return 'Lewat ($used/$max)';
  }

  @override
  String get gameForbiddenHeader => 'KATA TERLARANG';

  @override
  String get gameNoWordsFound => 'Tidak ada kata yang ditemukan.';

  @override
  String get gameWordsLoadFail => 'Gagal memuat kata-kata.';

  @override
  String gameWordsLoadError(String error) {
    return 'Kesalahan saat memuat kata: $error';
  }

  @override
  String get gameNoWordsAddPrompt =>
      'Tidak ada kata yang ditemukan. Silakan tambahkan kata dari halaman manajemen kata.';

  @override
  String get exitConfirmExitTitle =>
      'Apakah Anda yakin ingin mengakhiri permainan dan pergi ke papan skor?';

  @override
  String get exitConfirmUnevenTitle =>
      'Tidak semua tim telah bermain dengan jumlah ronde yang sama. Apakah Anda tetap ingin keluar?';

  @override
  String get wordsTitle => 'Manajemen Kata';

  @override
  String get wordsEditTitle => 'Edit Kata';

  @override
  String get wordsResetList => 'Atur Ulang Daftar';

  @override
  String get wordsBulkImport => 'Impor Massal';

  @override
  String get wordsBulkImportTitle => 'Impor Kata Massal';

  @override
  String get wordsLabel => 'Kata';

  @override
  String get wordsCancelEdit => 'Batalkan Edit';

  @override
  String get wordsSave => 'Simpan';

  @override
  String get wordsUpdate => 'Perbarui';

  @override
  String get wordsEdit => 'Edit';

  @override
  String get wordsAddButton => 'Tambah';

  @override
  String get wordsForbiddenLabel => 'Kata Terlarang';

  @override
  String get wordsForbiddenList => 'Kata-kata Terlarang:';

  @override
  String get wordsForbiddenEmpty =>
      'Belum ada kata terlarang yang ditambahkan.';

  @override
  String wordsForbiddenCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kata terlarang',
      one: '$count kata terlarang',
    );
    return '$_temp0';
  }

  @override
  String get wordsAddPrompt =>
      'Masukkan kata dan tambahkan setidaknya satu kata terlarang';

  @override
  String get wordsAddSuccess => 'Kata baru berhasil ditambahkan';

  @override
  String get wordsUpdateSuccess => 'Kata berhasil diperbarui';

  @override
  String get wordsDeleteSuccess => 'Kata berhasil dihapus';

  @override
  String get wordsDeleteConfirm =>
      'Apakah Anda yakin ingin menghapus kata ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get wordsForbiddenDuplicate => 'Kata terlarang ini sudah ditambahkan';

  @override
  String get wordsEmpty => 'Belum ada kata yang tersimpan.';

  @override
  String wordsSavedCount(int count) {
    return 'Kata Tersimpan ($count)';
  }

  @override
  String get bulkPasteHint => 'Tempel data JSON Anda di sini...';

  @override
  String get bulkPaste => 'Tempel';

  @override
  String get bulkCancel => 'Batal';

  @override
  String get bulkImport => 'Impor';

  @override
  String get bulkEmpty => 'Silakan masukkan data JSON.';

  @override
  String get bulkInvalidFormat =>
      'Format JSON tidak valid. Setiap item harus mengandung \"word\" dan \"forbiddenWords\" (daftar).';

  @override
  String bulkJsonError(String message) {
    return 'Kesalahan format JSON: $message';
  }

  @override
  String bulkImportError(String error) {
    return 'Terjadi kesalahan saat mengimpor: $error';
  }

  @override
  String bulkImportResult(int success, int errors) {
    return '$success kata berhasil diimpor, $errors gagal.';
  }

  @override
  String get dialogConfirmDelete => 'Ya, Hapus';

  @override
  String get dialogCancel => 'Batal';

  @override
  String get dialogWarning => 'Peringatan!';

  @override
  String get dialogYes => 'YA';

  @override
  String get dialogNo => 'TIDAK';

  @override
  String get easterEggSurprise => 'Kejutan!';

  @override
  String get reviewPromptTitle => 'Suka dengan Tabubu?';

  @override
  String get reviewPromptMessage =>
      'Jika ya, maukah mendukung kami dengan memberi ulasan di toko?';

  @override
  String get reviewPromptRate => 'Beri Ulasan';

  @override
  String get reviewPromptLater => 'Nanti';
}
