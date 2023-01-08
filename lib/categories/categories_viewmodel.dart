import '../api/categories_api.dart';

class CategoriesViewModel {
  final String _apiRoot;

  CategoriesViewModel(this._apiRoot);

  Future<CategoriesCreator> fetchCategoriesCreator() async {
    List<Category> categories = await getCategories(_apiRoot);
    return CategoriesCreator.justFetched(categories);
  }

  Future<CategoriesCreator> store(
      int? id, String name, List<Category> categories) async {
    var violation = await save(id, name);
    if (violation == "") {
      var categories = await getCategories(_apiRoot);
      return CategoriesCreator.stored(categories);
    } else {
      return CategoriesCreator.savingError(violation, name, categories);
    }
  }

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

class CategoriesCreator {
  final String lastViolation;
  final String lastCategoryName;
  final List<Category> categories;

  CategoriesCreator(this.lastViolation, this.lastCategoryName, this.categories);

  static CategoriesCreator justFetched(List<Category> categories) {
    return CategoriesCreator("", "", categories);
  }

  static CategoriesCreator savingError(
      String violation, String categoryName, List<Category> categories) {
    return CategoriesCreator(violation, categoryName, categories);
  }

  static CategoriesCreator stored(List<Category> categories) {
    return CategoriesCreator("", "", categories);
  }
}
