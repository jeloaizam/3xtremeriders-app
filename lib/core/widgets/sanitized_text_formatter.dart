import 'package:flutter/services.dart';

/// Strips control/NUL characters and `<`/`>` from every text field in the
/// app, baked into [AppTextField] so no screen has to opt in — mirrors
/// `sanitize_text` in `backend/app/core/sanitize.py` (control chars kill
/// garbage/log-breaking input, `<`/`>` kill any possible HTML/script tag).
class SanitizedTextInputFormatter extends TextInputFormatter {
  static final RegExp _pattern = RegExp(
    r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F<>]',
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleaned = newValue.text.replaceAll(_pattern, '');
    if (cleaned == newValue.text) return newValue;

    final offset = newValue.selection.end - (newValue.text.length - cleaned.length);
    return TextEditingValue(
      text: cleaned,
      selection: TextSelection.collapsed(
        offset: offset.clamp(0, cleaned.length),
      ),
    );
  }
}
