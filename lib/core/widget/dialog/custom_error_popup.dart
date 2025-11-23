import 'package:flutter/material.dart';
import 'package:nilz_app/core/resource/color_manager.dart';

Future<void> showErrorPopup(
  BuildContext context, {
  required String title,
  required String message,
  String okText = 'OK',
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(okText),
        ),
      ],
    ),
  );
}

Future<void> showSuccessPopup(
  BuildContext context, {
  required String title,
  required String message,
  String okText = 'OK',
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(okText, style: TextStyle(color: AppColorManager.denim)),
        ),
      ],
    ),
  );
}
