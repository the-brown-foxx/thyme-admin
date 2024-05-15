import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/theme/text_theme.dart';

class LicensePlate extends StatelessWidget {
  final String registrationId;

  const LicensePlate({super.key, required this.registrationId});

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      largeCornerRadius: false,
      roundedCorners: {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Text(registrationId, style: monospace),
      ),
    );
  }
}
