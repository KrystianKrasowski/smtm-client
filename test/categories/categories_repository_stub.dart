import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';

class CategoriesRepositoryStub extends CategoriesRepository {

  final List<Category> list;

  CategoriesRepositoryStub(this.list);

  @override
  Future<List<Category>> getAll() async {
    return list;
  }
}

class CategoriesRepositoryLoadingStub extends CategoriesRepository {

  @override
  Future<List<Category>> getAll() {
    return Future.delayed(const Duration(seconds: 5), () => []);
  }
}