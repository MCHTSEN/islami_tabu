import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';
import '../viewmodels/settings_viewmodel.dart';

// Import new widgets
import 'package:islami_tabu/widgets/settings/settings_content.dart';
import 'package:islami_tabu/widgets/decorations/background_gradient.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settingsTitle,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade900,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BackgroundGradient(
        child: settingsState.when(
          data: (settings) => SettingsContent(settings: settings),
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
                      text: l10n.settingsLoadError,
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 16),
                    ),
                    TextSpan(
                      text: '$error',
                      style: TextStyle(
                          color: Colors.red.shade400,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
