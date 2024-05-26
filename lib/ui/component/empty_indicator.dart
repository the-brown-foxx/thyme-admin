import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/card.dart';
import 'package:thyme_to_park_admin/ui/component/splash_image.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class EmptyIndicator extends StatelessWidget {
  final String message;
  final bool flipImage;

  const EmptyIndicator({
    super.key,
    required this.message,
    this.flipImage = false,
  });

  @override
  Widget build(final BuildContext context) {
    const splashImage = SplashImage(
      lightThemeAsset: 'assets/empty_pot_light.svg',
      darkThemeAsset: 'assets/empty_pot_dark.svg',
    );

    return Stack(
      children: [
        flipImage
            ? Transform.flip(flipX: true, child: splashImage)
            : splashImage,
        Center(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: HerbHubCard(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.inbox, size: 32),
                    const SizedBox(height: 8),
                    Text(message, style: context.theme.textTheme.titleLarge),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
