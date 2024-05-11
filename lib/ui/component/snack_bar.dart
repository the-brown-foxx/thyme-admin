import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar(final String text) {
    final snackBar = SnackBar(content: Text(text, maxLines: 1));
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}