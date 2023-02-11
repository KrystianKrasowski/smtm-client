import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';

class MockedCategoriesClient extends CategoriesRepository {

  @override
  Future<List<Category>> getAll() async {
    return [
      Category(Uri.parse("https://api.smtm.com/categories/1"), "Rent"),
      Category(Uri.parse("https://api.smtm.com/categories/2"), "Groceries"),
      Category(Uri.parse("https://api.smtm.com/categories/3"), "Services"),
    ];
  }
}