import 'package:dartz/dartz.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';

typedef SaveCategoryResult = Either<ConstraintViolations, Category>;

abstract class CategoriesRepository {
  Future<List<Category>> getAll();

  Future<SaveCategoryResult> create(String name);

  Future<SaveCategoryResult> update(Category category);
}
