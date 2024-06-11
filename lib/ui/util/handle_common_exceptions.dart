import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/exception.dart';
import 'package:thyme_to_park_admin/ui/component/snack_bar.dart';

extension CommonExceptions on BuildContext {
  void handleCommonExceptions(final Exception exception) {
    if (exception is ApiException) {
      showSnackBar(exception.message);
    } else if (exception is ClientException) {
      showSnackBar('Connection error');
    } else {
      throw exception;
    }
  }
}