import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class HerbHubTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final Set<Corner> roundedCorners;
  final bool obscureText;
  final String? errorText;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  const HerbHubTextField({
    super.key,
    this.controller,
    this.hintText,
    this.icon,
    this.roundedCorners = Corner.all,
    this.obscureText = false,
    this.errorText,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  State<HerbHubTextField> createState() => _HerbHubTextFieldState();
}

class _HerbHubTextFieldState extends State<HerbHubTextField> {
  late FocusNode _focusNode;
  var _hasFocus = false;

  void listener() => setState(() => _hasFocus = _focusNode.hasFocus);

  @override
  void initState() {
    _focusNode = FocusNode()
      ..addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(listener);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final hintStyle = theme.textTheme.bodyLarge
        ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8));
    final hasError = widget.errorText != null;
    final icon = widget.icon != null ? Icon(widget.icon, size: 16) : null;
    final standardBorder = OutlineInputBorder(
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      borderRadius: BorderRadius.only(
        topLeft: widget.roundedCorners.getRadius(Corner.topLeft),
        topRight: widget.roundedCorners.getRadius(Corner.topRight),
        bottomLeft: widget.roundedCorners.getRadius(Corner.bottomLeft),
        bottomRight: widget.roundedCorners.getRadius(Corner.bottomRight),
      ),
    );
    final errorBorder = standardBorder.copyWith(
      borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
    );
    final border = hasError ? errorBorder : standardBorder;
    final fillColorTween = _hasFocus ? ColorTween(
      begin: theme.colorScheme.surface,
      end: theme.colorScheme.background,
    ) : ColorTween(
      begin: theme.colorScheme.background,
      end: theme.colorScheme.surface,
    );

    return TweenAnimationBuilder(
      tween: fillColorTween,
      duration: const Duration(milliseconds: 100),
      builder: (final _, final color, final __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              obscureText: widget.obscureText,
              onSubmitted: widget.onSubmitted,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                prefixIcon: icon,
                hintText: widget.hintText,
                hintStyle: hintStyle,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: color,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 150),
              child: hasError ? Padding(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  widget.errorText!,
                  maxLines: 1,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ) : const SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
