import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class TwoPaneCard extends StatelessWidget {
  final bool loading;
  final Widget leftChild;
  final Widget rightChild;
  final bool showDivider;
  final CrossAxisAlignment rowAlignment;

  const TwoPaneCard({
    super.key,
    this.loading = false,
    required this.leftChild,
    required this.rightChild,
    this.showDivider = false,
    this.rowAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: rowAlignment,
              children: [
                Expanded(child: leftChild),
                if (showDivider)
                  VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: context.theme.colorScheme.onSurface,
                  ),
                Expanded(child: rightChild),
              ],
            ),
          ),
          // MatchLeftPaneHeightLayout(
          //   leftChild: leftChild,
          //   rightChild: rightChild,
          // ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}
