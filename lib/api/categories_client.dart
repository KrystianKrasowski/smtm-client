import 'package:dartz/dartz.dart';
import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';

final List<Category> _repository = [
  Category(Uri.parse("https://api.smtm.com/categories/1"), "Rent"),
  Category(Uri.parse("https://api.smtm.com/categories/2"), "Groceries"),
  Category(Uri.parse("https://api.smtm.com/categories/3"), "Services"),
];

class MockedCategoriesClient extends CategoriesRepository {
  @override
  Future<List<Category>> getAll() async {
    return _repository;
  }

  @override
  Future<SaveCategoryResult> create(String name) async {
    if (name.toLowerCase() == "invalid") {
      return left([
        ConstraintViolation.of(
            "name", "Invalid characters: %chars%", {"%chars%": "<, >, @, ~"})
      ]);
    }

    final id = _repository.length + 1;
    final category =
        Category(Uri.parse("https://api.smtm.com/categories/$id"), name);
    _repository.add(category);
    return right(category);
  }
}
