import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class TopBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Set<Corner> roundedCorners;

  const TopBarIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.roundedCorners = Corner.all,
  });

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: HerbHubCard(
        roundedCorners: roundedCorners,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon),
        ),
      ),
    );
  }
}
