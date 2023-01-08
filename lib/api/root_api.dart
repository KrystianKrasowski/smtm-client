import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Uri> getCategoriesEndpoint(String apiUri) async {
  return await _getEndpoint("categories", apiUri);
}

Future<Uri> _getEndpoint(String name, String apiUri) async {
  var endpoints = await _getEndpoints(apiUri);
  return endpoints.firstWhere((endpoint) => endpoint.name == name).uri;
}

Future<List<_Endpoint>> _getEndpoints(String apiUrl) async {
  var response = await http.get(Uri.parse(apiUrl),
      headers: {"Accept": "application/smtm.root.v1+json"});

  if (response.statusCode != 200) {
    throw UnexpectedHttpStatus(response.statusCode);
  }

  Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  Map<String, dynamic> links = decodedResponse["_links"];

  return links.entries
      .where((element) => element.key != "self")
      .map((e) => _Endpoint(e.key, Uri.parse(e.value["href"])))
      .toList();
}

class UnexpectedHttpStatus implements Exception {
  final int status;

  UnexpectedHttpStatus(this.status);
}

class _Endpoint {
  final String name;
  final Uri uri;

  _Endpoint(this.name, this.uri);
}
