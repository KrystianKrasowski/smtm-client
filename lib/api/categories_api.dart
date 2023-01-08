import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smtm_client/api/root_api.dart';

class Category {
  final int id;
  final String name;

  Category(this.id, this.name);

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

final List<Category> _categories = [
  Category(1, 'Rent'),
  Category(2, 'Savings'),
  Category(3, 'House services')
];

Future<List<Category>> getCategories(String apiUrl) async {
  var endpoint = await getCategoriesEndpoint(apiUrl);
  var response = await http.get(endpoint,
      headers: {"Accept": "application/smtm.categories.v1+json"});

  if (response.statusCode != 200) {
    throw UnexpectedHttpStatus(response.statusCode);
  }

  Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  List<dynamic> categories = decodedResponse["_embedded"]["categories"];

  return categories
      .map((e) => Category(e["id"], e["name"]))
      .toList();
}

Future<String> putCategory(Category category) {
  Category existing =
      _categories.firstWhere((element) => element.id == category.id);
  int i = _categories.indexOf(existing);
  _categories[i] = category;
  return Future.delayed(const Duration(seconds: 1), () => '');
}

Future<String> postCategory(String name) {
  int id = _categories.length + 1;
  // _categories.add(Category(id, name));
  return Future.delayed(
      const Duration(seconds: 1), () => 'Something went wrong');
}

void deleteCategory(int id) {
  Category existing = _categories.firstWhere((element) => element.id == id);
  int i = _categories.indexOf(existing);
  _categories.removeAt(i);
}
