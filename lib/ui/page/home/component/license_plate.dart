import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/theme/text_theme.dart';

class LicensePlate extends StatelessWidget {
  final String registrationId;

  const LicensePlate({super.key, required this.registrationId});

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 128),
      child: HerbHubCard(
        largeCornerRadius: false,
        roundedCorners: const {},
        containerColor: context.theme.colorScheme.background,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(registrationId, style: monospace),
          ),
        ),
      ),
    );
  }
}
