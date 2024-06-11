import 'package:http/http.dart';
import 'package:thyme_to_park_admin/service/api/model/json_response.dart';

abstract interface class Api {
  String get baseUrl;

  Uri urlOf(final String endpoint);

  JsonResponse parseJsonResponse(final Response response);
}