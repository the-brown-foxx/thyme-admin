import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/button.dart';
import 'package:thyme_to_park_admin/ui/component/controlled_text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class SetParkingSpaceCountBody extends StatelessWidget {
  final TextFieldController totalSpaceController;
  final TextFieldController vacantSpaceController;
  final VoidCallback? onSetParkingSpaceCount;

  const SetParkingSpaceCountBody({
    super.key,
    required this.totalSpaceController,
    required this.vacantSpaceController,
    this.onSetParkingSpaceCount,
  });

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

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
        ControlledTextField(
          icon: Icons.circle,
          hintText: 'Total space',
          controller: totalSpaceController,
          roundedCorners: Edge.top,
          onSubmitted: (final _) => onSetParkingSpaceCount?.call(),
        ),
        const SizedBox(height: 8),
        ControlledTextField(
          icon: Icons.incomplete_circle,
          hintText: 'Vacant space',
          controller: vacantSpaceController,
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
