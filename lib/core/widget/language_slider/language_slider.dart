import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nilz_app/core/resource/color_manager.dart';
import '../../storage/shared/shared_pref.dart';

class LanguageSlider extends StatelessWidget {
  final bool compact;
  const LanguageSlider({super.key, this.compact = true});

  int _valueFromLocale(Locale l) => l.languageCode.toLowerCase() == 'ar' ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    final current = _valueFromLocale(context.locale);

    return CupertinoSlidingSegmentedControl<int>(
      groupValue: current,
      padding: EdgeInsets.all(compact ? 2 : 4),
      // ignore: deprecated_member_use
      backgroundColor: AppColorManager.backgroundGrey.withOpacity(0.25),
      thumbColor: AppColorManager.white,
      children: {
        0: _LangChip(label: 'EN', compact: compact),
        1: _LangChip(label: 'AR', compact: compact),
      },
      onValueChanged: (v) async {
        if (v == null) return;
        final target = v == 1 ? const Locale('ar') : const Locale('en');
          await context.setLocale(target);
        AppSharedPreferences.getLanguage();
      },
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool compact;
  const _LangChip({required this.label, required this.compact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: compact ? 4 : 6),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AppColorManager.textAppColor,
        ),
      ),
    );
  }
}
