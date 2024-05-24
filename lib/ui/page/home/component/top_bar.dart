import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/icon_button.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';

class TopBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onOpenLogs;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final bool loading;
  final double maxContentWidth;

  const TopBar({
    super.key,
    required this.searchController,
    required this.onOpenLogs,
    required this.onChangePassword,
    required this.onLogout,
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
                    Expanded(
                      child: HerbHubTextField(
                        hintText: 'Search',
                        controller: searchController,
                      ),
                    ),
                    const SizedBox(width: 8),
                    HerbHubIconButton(
                      onPressed: () {},
                      icon: Icons.list,
                    ),
                    const SizedBox(width: 8),
                    HerbHubIconButton(
                      onPressed: onChangePassword,
                      icon: Icons.password,
                    ),
                    const SizedBox(width: 8),
                    HerbHubIconButton(
                      onPressed: onLogout,
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        !loading ? const Divider(
          height: 0,
          thickness: 2,
        ) : const HerbHubLinearProgressIndicator(),
      ],
    );
  }
}
