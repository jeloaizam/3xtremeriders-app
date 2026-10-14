import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../../auth/domain/rider.dart';
import '../../../application/spot_detail.dart';
import '../../../domain/hazzard.dart';
import '../../../domain/spot.dart';
import '../../../domain/spot_element.dart';
import 'more_info/comments_tab.dart';
import 'more_info/description_tab.dart';
import 'more_info/elements_tab.dart';
import 'more_info/hazards_tab.dart';

/// 4-tab shell (Descripción/Elementos/Peligros/Comentarios) — the mockup's
/// `MoreInfoBox`. A fixed-height, internally-scrolling box per tab (rather
/// than sizing to content) since this sits inside the Spot screen's own
/// outer `ListView`, which can't give a nested `TabBarView` an unbounded
/// height.
class MoreInfoBox extends StatelessWidget {
  const MoreInfoBox({
    super.key,
    required this.spot,
    required this.creator,
    required this.elements,
    required this.hazzards,
    required this.spotId,
    required this.comments,
  });

  final Spot spot;
  final Rider creator;
  final List<SpotElement> elements;
  final List<Hazzard> hazzards;
  final int spotId;
  final List<SpotCommentWithAuthor> comments;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: false,
            labelColor: colors.text100,
            unselectedLabelColor: colors.textMuted,
            indicatorColor: colors.colorAction,
            dividerColor: colors.hairline,
            labelStyle: context.typography.tag,
            unselectedLabelStyle: context.typography.tag,
            tabs: [
              Tab(text: l10n.spotTabDescription),
              Tab(text: l10n.spotTabElements),
              Tab(text: l10n.spotTabHazards),
              Tab(text: l10n.spotTabComments),
            ],
          ),
          SizedBox(
            height: 420,
            child: TabBarView(
              children: [
                DescriptionTab(spot: spot, creator: creator),
                ElementsTab(elements: elements),
                HazardsTab(hazzards: hazzards),
                CommentsTab(spotId: spotId, comments: comments),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
