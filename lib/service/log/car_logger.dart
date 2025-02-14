import 'package:thyme_to_park_admin/service/log/model/car_log.dart';

abstract interface class CarLogger {
  Stream<bool> get loading;

  Stream<List<CarLog>> get carLogs;

  Stream<List<CarLog>> getCarLogsByRegistrationId(final String registrationId);

  String getImageUrl(final filename);
}