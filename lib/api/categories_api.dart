import 'dart:async';

class Category {

  final int id;
  final String name;

  Category(this.id, this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

final List<Category> _categories = [
  Category(1, 'Rent'),
  Category(2, 'Savings'),
  Category(3, 'House services')
];

Future<List<Category>> getCategories(String apiUrl) {
  return Future.delayed(const Duration(seconds: 2), () {
    return _categories;
  });
}

Future<String> putCategory(Category category) {
  Category existing = _categories.firstWhere((element) => element.id == category.id);
  int i = _categories.indexOf(existing);
  _categories[i] = category;
  return Future.delayed(const Duration(seconds: 1), () => '');
}

Future<String> postCategory(String name) {
  int id = _categories.length + 1;
  _categories.add(Category(id, name));
  return Future.delayed(const Duration(seconds: 1), () => '');
}

void deleteCategory(int id) {
  Category existing = _categories.firstWhere((element) => element.id == id);
  int i = _categories.indexOf(existing);
  _categories.removeAt(i);
}
