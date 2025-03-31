import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/di/service_locator.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../domain/usecases/get_game_settings_usecase.dart';
import '../../domain/usecases/save_game_settings_usecase.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Oyun Ayarları',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.shade900,
              Colors.blueGrey.shade900,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: settingsState.when(
          data: (settings) => _buildSettingsContent(settings),
          loading: () => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectableText.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bir hata oluştu: ',
                      style: TextStyle(color: Colors.red.shade300),
                    ),
                    TextSpan(
                      text: '$error',
                      style: TextStyle(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContent(GameSettingsEntity settings) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildSection(
          title: 'Oyun Süresi',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${settings.gameDuration} saniye',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Slider(
                value: settings.gameDuration.toDouble(),
                min: 30,
                max: 180,
                divisions: 15,
                label: '${settings.gameDuration} saniye',
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateGameDuration(
                        value.toInt(),
                      );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: 'Pas Geçme Ayarları',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maksimum Pas: ${settings.maxPasses}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Slider(
                value: settings.maxPasses.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: '${settings.maxPasses} pas',
                onChanged: (value) {
                  ref.read(settingsViewModelProvider.notifier).updateMaxPasses(
                        value.toInt(),
                      );
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Pas Cezası: ${settings.passPenalty} saniye',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Slider(
                value: settings.passPenalty.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                label: '${settings.passPenalty} saniye',
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updatePassPenalty(
                        value.toInt(),
                      );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: 'Kelime Ayarları',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text(
                  'Kelimeleri Karıştır',
                  style: TextStyle(color: Colors.white),
                ),
                value: settings.shuffleWords,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateShuffleWords(
                        value,
                      );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade800.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.amber.shade700.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.amber.shade300,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
