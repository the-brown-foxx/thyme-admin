import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';

class TwoPaneCard extends StatelessWidget {
  final bool loading;
  final Widget leftChild;
  final Widget rightChild;

  const TwoPaneCard({
    super.key,
    this.loading = false,
    required this.leftChild,
    required this.rightChild,
  });

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: leftChild),
              Expanded(child: rightChild),
            ],
          ),
          if (loading) const HerbHubLinearProgressIndicator(),
        ],
      ),
    );
  }
}