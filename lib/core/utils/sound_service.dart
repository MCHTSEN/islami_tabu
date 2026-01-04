import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final soundServiceProvider = Provider((ref) => SoundService());

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playCorrect() async {
    await _player.play(AssetSource('sfx/correct_answer.wav'));
  }

  Future<void> playWrong() async {
    await _player.play(AssetSource('sfx/wrong_answer.wav'));
  }

  Future<void> playNextTeam() async {
    await _player.play(AssetSource('sfx/next_team.wav'));
  }

  void dispose() {
    _player.dispose();
  }
}
