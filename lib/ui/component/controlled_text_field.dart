import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/ui/component/text_field.dart';
import 'package:thyme_to_park_admin/ui/util/corner.dart';

class TextFieldController {
  final textEditingController = TextEditingController();
  final errorNotifier = ValueNotifier<String?>(null);
  var oldText = '';

  TextFieldController() {
    textEditingController.addListener(() {
      if (oldText != textEditingController.text) {
        errorNotifier.value = null;
      }
      oldText = textEditingController.text;
    });
  }

  String get text => textEditingController.text;

  set text(final String newText) => textEditingController.text = newText;

  String? get error => errorNotifier.value;

  set error(final String? newError) => errorNotifier.value = newError;

  void dispose() {
    textEditingController.dispose();
    errorNotifier.dispose();
  }
}

class ControlledTextField extends StatelessWidget {
  final TextFieldController controller;
  final String? hintText;
  final IconData? icon;
  final Set<Corner> roundedCorners;
  final bool obscureText;
  final Function(String)? onSubmitted;
  final TextInputType? keyboardType;

  const ControlledTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.icon,
    this.roundedCorners = Corner.all,
    this.obscureText = false,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(final BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.errorNotifier,
      builder: (final _, final error, final __) => HerbHubTextField(
        controller: controller.textEditingController,
        hintText: hintText,
        icon: icon,
        roundedCorners: roundedCorners,
        obscureText: obscureText,
        errorText: error,
        onSubmitted: onSubmitted,
        keyboardType: keyboardType,
      ),
    );
  }
}
