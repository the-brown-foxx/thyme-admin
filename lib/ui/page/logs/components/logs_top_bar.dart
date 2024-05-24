import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/icon_button.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class LogsTopBar extends StatelessWidget {
  final VoidCallback onNavigateUp;
  final bool loading;
  final double maxContentWidth;

  const LogsTopBar({
    super.key,
    required this.onNavigateUp,
    required this.loading,
    this.maxContentWidth = double.infinity,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          color: context.theme.colorScheme.surface,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth,
                  minHeight: 64,
                ),
                child: Row(
                  children: [
                    HerbHubIconButton(
                      onPressed: onNavigateUp,
                      icon: Icons.arrow_back,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Logs',
                        style: context.theme.textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        !loading
            ? const Divider(
                height: 0,
                thickness: 2,
              )
            : const HerbHubLinearProgressIndicator(),
      ],
    );
  }
}
