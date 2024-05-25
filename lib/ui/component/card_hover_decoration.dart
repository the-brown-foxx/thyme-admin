import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class CardHoverDecoration extends StatefulWidget {
  final Widget child;
  final Set<Corner> roundedCorners;

  const CardHoverDecoration({
    super.key,
    this.roundedCorners = Corner.all,
    required this.child,
  });

  CardHoverDecoration.forHerbHubCard({
    super.key,
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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                  ],
                ),
              ),
              child: Column(
                children: [
                  widget.child,
                  AnimatedSize(
                    duration: const Duration(milliseconds: 150),
                    child: SizedBox(height: hovered ? 8 : 0),
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
