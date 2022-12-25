import 'api/categories_api.dart';

class CategoriesViewModel {

  final String _apiRoot;

  CategoriesViewModel(this._apiRoot);

  Future<List<Category>> fetch() async {
    return getCategories(_apiRoot);
  }

  Future<String> save(int? id, String name) async {
    if (id != null) {
      return putCategory(Category(id, name));
    } else {
      return postCategory(name);
    }
  }

  void delete(int id) {
    delete(id);
  }
}
