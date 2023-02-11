import 'package:smtm_client/domain/categories/categories_repository.dart';

class CategoriesViewModel {

  final CategoriesRepository repository;

  CategoriesViewModel(this.repository);

  Future<Categories> get() async {
    final categoryList = await repository.getAll();
    return Categories(categoryList);
  }
}

class Categories {

  final List<Category> list;

  Categories(this.list);
}

class Category {

  final Uri id;
  final String name;

  Category(this.id, this.name);
}