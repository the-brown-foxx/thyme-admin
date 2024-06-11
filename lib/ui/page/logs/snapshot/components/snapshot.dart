import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';

class Snapshot extends StatelessWidget {
  final String snapshotUrl;

  const Snapshot({super.key, required this.snapshotUrl});

  @override
  Widget build(final BuildContext context) {
    return HerbHubCard(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 128, minHeight: 128),
        child: Image.network(snapshotUrl),
      ),
    );
  }
}
