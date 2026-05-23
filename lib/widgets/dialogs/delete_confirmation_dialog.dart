import 'package:flutter/material.dart';
import 'package:islami_tabu/l10n/generated/app_localizations.dart';

Future<bool> showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
}) async {
  final l10n = AppLocalizations.of(context);
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.red.shade300,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                l10n.dialogCancel,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.dialogConfirmDelete),
            ),
          ],
        ),
      ) ??
      false;
}
