import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../buttons/app_3d_buton.dart';

Future<bool> showExitConfirmationDialog(
  BuildContext context, {
  required bool hasEqualRounds,
}) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => _ExitConfirmationDialog(hasEqualRounds: hasEqualRounds),
      ) ??
      false;
}

class _ExitConfirmationDialog extends ConsumerWidget {
  final bool hasEqualRounds;

  const _ExitConfirmationDialog({required this.hasEqualRounds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 340),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueGrey.shade800,
              Colors.blueGrey.shade900,
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: hasEqualRounds
                ? Colors.blue.shade400.withOpacity(0.3)
                : Colors.amber.shade400.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (hasEqualRounds ? Colors.blue : Colors.amber)
                  .withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: hasEqualRounds
                        ? [Colors.blue.shade400, Colors.blue.shade700]
                        : [Colors.amber.shade400, Colors.amber.shade700],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (hasEqualRounds ? Colors.blue : Colors.amber)
                          .withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  hasEqualRounds ? Icons.emoji_events_rounded : Icons.warning_amber_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                hasEqualRounds ? 'Oyunu Bitir' : 'Dikkat!',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Content
              Text(
                hasEqualRounds
                    ? 'Oyunu bitirip skor tablosuna gitmek istediğinize emin misiniz?'
                    : 'Her takım eşit sayıda tur oynamadı. Yine de çıkmak istediğinize emin misiniz?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 16,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Buttons
              Row(
                children: [
                  // Hayır butonu (Mavi)
                  Expanded(
                    child: App3DButton(
                      text: 'HAYIR',
                      height: 52,
                      borderRadius: 14,
                      primaryColor: const Color(0xFF14248A),
                      secondaryColor: const Color(0xFF0D1B63),
                      shadowColor: const Color(0xFF081140),
                      icon: Icons.close_rounded,
                      iconColor: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      onTap: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Evet butonu (Kırmızı)
                  Expanded(
                    child: App3DButton(
                      text: 'EVET',
                      height: 52,
                      borderRadius: 14,
                      primaryColor: const Color(0xFFE53935),
                      secondaryColor: const Color(0xFFB71C1C),
                      shadowColor: const Color(0xFF7F0000),
                      icon: Icons.check_rounded,
                      iconColor: Colors.white,
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      onTap: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
