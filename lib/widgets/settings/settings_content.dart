import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';
import 'package:islami_tabu/providers/locale_provider.dart';
import '../../domain/entities/game_settings_entity.dart';
import '../../presentation/viewmodels/settings_viewmodel.dart';
import 'settings_section.dart';

class SettingsContent extends ConsumerWidget {
  final GameSettingsEntity settings;

  const SettingsContent({super.key, required this.settings});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SettingsSection(
          title: l10n.settingsLanguage,
          child: Column(
            children: [
              _languageTile(context, ref, currentLocale, 'tr',
                  l10n.settingsLanguageTurkish),
              _languageTile(context, ref, currentLocale, 'en',
                  l10n.settingsLanguageEnglish),
              _languageTile(context, ref, currentLocale, 'ar',
                  l10n.settingsLanguageArabic),
              _languageTile(context, ref, currentLocale, 'de',
                  l10n.settingsLanguageGerman),
              _languageTile(context, ref, currentLocale, 'fr',
                  l10n.settingsLanguageFrench),
              _languageTile(context, ref, currentLocale, 'id',
                  l10n.settingsLanguageIndonesian),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: l10n.settingsGameDuration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.statisticsDurationSeconds(settings.gameDuration),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: settings.gameDuration.toDouble(),
                min: 30,
                max: 180,
                divisions: 15,
                label: l10n.statisticsDurationSeconds(settings.gameDuration),
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateGameDuration(value.toInt());
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: l10n.settingsPassSettings,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settingsMaxPasses(settings.maxPasses),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: settings.maxPasses.toDouble(),
                min: 1,
                max: 5,
                divisions: 4,
                label: l10n.settingsPassesLabel(settings.maxPasses),
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updateMaxPasses(value.toInt());
                },
              ),
              const SizedBox(height: 16),
              Text(
                l10n.settingsPassPenalty(settings.passPenalty),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Slider(
                value: settings.passPenalty.toDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                label: l10n.statisticsDurationSeconds(settings.passPenalty),
                activeColor: Colors.amber.shade400,
                inactiveColor: Colors.blueGrey.shade600,
                thumbColor: Colors.amber.shade600,
                onChanged: (value) {
                  ref
                      .read(settingsViewModelProvider.notifier)
                      .updatePassPenalty(value.toInt());
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SettingsSection(
          title: l10n.settingsWordSettings,
          child: SwitchListTile(
            title: Text(
              l10n.settingsShuffleWords,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              l10n.settingsShuffleHint,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            ),
            value: settings.shuffleWords,
            onChanged: (value) {
              ref
                  .read(settingsViewModelProvider.notifier)
                  .updateShuffleWords(value);
            },
            activeColor: Colors.amber.shade600,
            inactiveThumbColor: Colors.blueGrey.shade400,
            tileColor: Colors.transparent,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          ),
        ),
      ],
    );
  }

  Widget _languageTile(BuildContext context, WidgetRef ref, Locale current,
      String code, String label) {
    final selected = current.languageCode == code;
    return RadioListTile<String>(
      value: code,
      groupValue: current.languageCode,
      onChanged: (v) {
        if (v == null) return;
        ref.read(localeProvider.notifier).setLocale(Locale(v));
      },
      title: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.amber.shade300 : Colors.white,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      activeColor: Colors.amber.shade400,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
