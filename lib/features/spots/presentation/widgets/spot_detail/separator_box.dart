import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

/// Thin hairline divider between the hero chrome and the rest of the
/// Spot screen's content.
class SeparatorBox extends StatelessWidget {
  const SeparatorBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: context.colors.hairline);
  }
}
