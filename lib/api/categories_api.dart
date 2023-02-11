import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smtm_client/api/root_api.dart';

class Category {
  final int id;
  final String name;
  final Uri endpoint;

  static Category fromJson(dynamic json) {
    return Category(
        json["id"], json["name"], Uri.parse(json["_links"]["self"]["href"]));
  }

  Category(this.id, this.name, this.endpoint);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

Future<List<Category>> getCategories(String apiUrl) async {
  var endpoint = await getCategoriesEndpoint(apiUrl);
  var response = await http.get(endpoint,
      headers: {"Accept": "application/smtm.categories.v1+json"});

  if (response.statusCode != 200) {
    throw UnexpectedHttpStatus(response.statusCode);
  }

  Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  List<dynamic> categories = decodedResponse["_embedded"]["categories"];

  return categories.map((e) => Category.fromJson(e)).toList();
}

Future<String> putCategory(Category category) async {
  var response = await http.put(category.endpoint, headers: {
    "Content-Type": "application/smtm.category.v1+json",
    "Accept": "application/smtm.constraint-violation.v1+json"
  });

  var expectedStatusCodes = [204, 422];

  if (!expectedStatusCodes.contains(response.statusCode)) {
    throw UnexpectedHttpStatus(response.statusCode);
  }

  return _extractViolation(response) ?? "";
}

Future<String> postCategory(String apiUri, String name) async {
  var endpoint = await getCategoriesEndpoint(apiUri);
  var response = await http.post(endpoint, headers: {
    "Content-Type": "application/smtm.category.v1+json",
    "Accept": "application/smtm.constraint-violation.v1+json"
  });

  var expectedStatusCodes = [201, 422];

  if (!expectedStatusCodes.contains(response.statusCode)) {
    throw UnexpectedHttpStatus(response.statusCode);
  }

  return _extractViolation(response) ?? "";
}

String? _extractViolation(http.Response response) {
  if (response.statusCode == 422) {
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    return decodedResponse["violations"]["name"]["message"] as String;
  }

  return null;
}
