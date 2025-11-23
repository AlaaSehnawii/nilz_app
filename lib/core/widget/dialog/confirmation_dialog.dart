import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'OK',
  String cancelText = 'Cancel',
  Color? confirmColor,
  Color? cancelColor,
  bool barrierDismissible = false,
}) async {
  final Color primary = confirmColor ?? AppColorManager.denim;
  final Color outline = cancelColor ?? AppColorManager.denim;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: outline, width: 1.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    foregroundColor: outline,
                  ),
                  child: Text(cancelText),
                ),
              ),
              const SizedBox(width: 12),
              // Confirm - filled
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: Text(confirmText),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  return result ?? false;
}

Future<bool> showAsyncConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required Future<void> Function() onConfirm,
  String confirmText = 'OK',
  String cancelText = 'Cancel',
  Color? confirmColor,
  Color? cancelColor,
  bool barrierDismissible = false,
}) async {
  final Color primary = confirmColor ?? AppColorManager.denim;
  final Color outline = cancelColor ?? AppColorManager.denim;

  bool isLoading = false;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: barrierDismissible && !isLoading,
    builder: (dialogCtx) {
      return StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          title: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                  ],
                )
              else
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isLoading
                          ? null
                          : () => Navigator.pop(dialogCtx, false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: outline, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: outline,
                      ),
                      child: Text(cancelText),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() => isLoading = true);
                              try {
                                await onConfirm();
                                if (Navigator.canPop(dialogCtx)) {
                                  Navigator.pop(dialogCtx, true);
                                }
                              } catch (_) {
                                setState(() => isLoading = false);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        foregroundColor: Colors.white,
                        elevation: 0,
                      ),
                      child: Text(confirmText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  return result ?? false;
}
