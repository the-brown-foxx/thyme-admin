import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashImage extends StatelessWidget {
  final String lightThemeAsset;
  final String darkThemeAsset;

  const SplashImage({
    super.key,
    required this.lightThemeAsset,
    required this.darkThemeAsset,
  });

  const SplashImage.landing({final Key? key})
      : this(
          key: key,
          lightThemeAsset: 'assets/landing_image_light.svg',
          darkThemeAsset: 'assets/landing_image_dark.svg',
        );

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final assetName = switch (theme.brightness) {
      Brightness.light => lightThemeAsset,
      Brightness.dark => darkThemeAsset,
    };

    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Align(
        alignment: Alignment.bottomRight,
        child: SvgPicture.asset(
          assetName,
          alignment: Alignment.bottomRight,
        ),
      ),
    );
  }
}
