import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

const _defaultColors = [
  Color(0xFF2fd096),
  Color(0xFF452FD0),
];

class CardHoverDecoration extends StatefulWidget {
  final Set<Corner> roundedCorners;
  final List<Color> gradientColors;
  final bool persistent;
  final Widget child;

  const CardHoverDecoration({
    super.key,
    this.roundedCorners = Corner.all,
    this.gradientColors = _defaultColors,
    this.persistent = false,
    required this.child,
  });

  CardHoverDecoration.forHerbHubCard({
    super.key,
    this.gradientColors = _defaultColors,
    this.persistent = false,
    required HerbHubCard this.child,
  }) : roundedCorners = child.roundedCorners;

  @override
  State<CardHoverDecoration> createState() => _CardHoverDecorationState();
}

class _CardHoverDecorationState extends State<CardHoverDecoration> {
  var hovered = false;

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      onEnter: (final _) => setState(() => hovered = true),
      onExit: (final _) => setState(() => hovered = false),
      child: HerbHubCard(
        roundedCorners: widget.roundedCorners,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                ),
              ),
              child: Column(
                children: [
                  widget.child,
                  AnimatedSize(
                    duration: const Duration(milliseconds: 150),
                    child: SizedBox(
                      height: hovered || widget.persistent ? 8 : 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
