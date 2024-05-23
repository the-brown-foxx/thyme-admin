import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditCarImage extends StatelessWidget {
  const EditCarImage({super.key});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final assetName = switch (theme.brightness) {
      Brightness.light => 'assets/landing_image_light.svg',
      Brightness.dark => 'assets/landing_image_dark.svg',
    };

    return SvgPicture.asset(
      assetName,
      alignment: Alignment.bottomRight,
    );
  }
}
