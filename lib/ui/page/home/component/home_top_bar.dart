import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/linear_progress_indicator.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/component/theme.dart';
import 'package:thyme_to_park_admin/ui/component/top_bar_icon_button.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/vacant_space_card.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class HomeTopBar extends StatelessWidget {
  final TextEditingController searchController;
  final int vacantSpace;
  final VoidCallback onUpdateParkingSpaceCount;
  final VoidCallback onOpenLogs;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final bool loading;
  final double maxContentWidth;

  const HomeTopBar({
    super.key,
    required this.searchController,
    required this.vacantSpace,
    required this.onUpdateParkingSpaceCount,
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
                        roundedCorners: Edge.left,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 48,
                      child: VacantSpaceCard(
                        vacantSpace: vacantSpace,
                        onTap: onUpdateParkingSpaceCount,
                      ),
                    ),
                    const SizedBox(width: 8),
                    TopBarIconButton(
                      icon: Icons.list,
                      onTap: onOpenLogs,
                      roundedCorners: const {},
                    ),
                    const SizedBox(width: 8),
                    TopBarIconButton(
                      icon: Icons.password,
                      onTap: onChangePassword,
                      roundedCorners: const {},
                    ),
                    const SizedBox(width: 8),
                    TopBarIconButton(
                      icon: Icons.logout,
                      onTap: onLogout,
                      roundedCorners: Edge.right,
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
