import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class SetParkingSpaceCountBody extends StatelessWidget {
  final TextEditingController totalSpaceController;
  final TextEditingController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;
  final bool totalSpaceBlank;
  final bool vacantSpaceBlank;
  final bool totalSpaceIsLessThanVacantSpace;

  const SetParkingSpaceCountBody({
    super.key,
    required this.totalSpaceController,
    required this.vacantSpaceController,
    this.onSetParkingSpaceCount,
    required this.totalSpaceBlank,
    required this.vacantSpaceBlank,
    required this.totalSpaceIsLessThanVacantSpace,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final totalSpaceError = totalSpaceBlank
        ? 'Total space required'
        : totalSpaceIsLessThanVacantSpace
            ? 'Total space should be greater than vacant space'
            : null;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Set available parking space',
          maxLines: 2,
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        HerbHubTextField(
          icon: Icons.circle,
          hintText: 'Total space',
          controller: totalSpaceController,
          errorText: totalSpaceError,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onSetParkingSpaceCount?.call(),
        ),
        const SizedBox(height: 8),
        HerbHubTextField(
          icon: Icons.incomplete_circle,
          hintText: 'Vacant space',
          controller: vacantSpaceController,
          errorText: vacantSpaceBlank ? 'Vacant space required' : null,
          roundedCorners: Edge.bottom,
          onSubmitted: (final _) => onSetParkingSpaceCount?.call(),
        ),
        const SizedBox(height: 16),
        HerbHubButton(
          text: 'Set available space',
          onPressed: onSetParkingSpaceCount,
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
