import 'package:thyme_to_park_admin/service/api/model/json.dart';

abstract interface class Socket {
  Stream<Json> get messages;

  Future<Json> send(final Json message);
}