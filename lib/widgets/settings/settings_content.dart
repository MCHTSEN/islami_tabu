import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';
import 'settings_section.dart';

class SettingsContent extends ConsumerWidget {
  final GameSettingsEntity settings;

  const SettingsContent({super.key, required this.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SettingsSection(
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
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
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
        SettingsSection(
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
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
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
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
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
        SettingsSection(
          title: 'Kelime Ayarları',
          child: SwitchListTile(
            title: const Text(
              'Kelimeleri Karıştır',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Her oyun başlangıcında kelime sırası rastgele olur.',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
            value: settings.shuffleWords,
            onChanged: (value) {
              ref.read(settingsViewModelProvider.notifier).updateShuffleWords(
                    value,
                  );
            },
            activeColor: Colors.amber.shade600,
            inactiveThumbColor: Colors.blueGrey.shade400,
            tileColor: Colors.transparent, // Blend with section background
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          ),
        ),
      ],
    );
  }
}
