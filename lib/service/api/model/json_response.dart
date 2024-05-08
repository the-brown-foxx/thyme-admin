import 'dart:convert';

import 'package:http/http.dart';

class JsonResponse {
  final int statusCode;
  final Map<String, dynamic> body;

  JsonResponse._({required this.statusCode, required this.body});

  factory JsonResponse(final Response response) {
    return JsonResponse._(
      statusCode: response.statusCode,
      body: jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
