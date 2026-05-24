import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

/// "Tabubu'yu beğendin mi?" — değerlendirme öneren branded popup.
///
/// `showReviewPromptDialog` çağrısı bool döner:
/// - true  → kullanıcı "Değerlendir" dedi (caller native review UI'ı tetikler)
/// - false → kullanıcı "Daha sonra" dedi (veya barrier dismiss)
class ReviewPromptDialog extends StatelessWidget {
  const ReviewPromptDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.reviewPromptTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        l10n.reviewPromptMessage,
        style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.4),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            l10n.reviewPromptLater,
            style: const TextStyle(color: Colors.white60),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            l10n.reviewPromptRate,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

Future<bool> showReviewPromptDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (_) => const ReviewPromptDialog(),
  );
  return result ?? false;
}
