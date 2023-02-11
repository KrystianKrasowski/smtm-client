import 'package:smtm_client/domain/categories/categories_viewmodel.dart';

abstract class CategoriesRepository {

  Future<List<Category>> getAll();
}