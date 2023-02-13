import 'package:dartz/dartz.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';

typedef SaveCategoryResult = Either<List<ConstraintViolation>, Category>;

abstract class CategoriesRepository {
  Future<List<Category>> getAll();

  Future<Either<ConstraintViolations, Category>> create(String name);

  Future<Either<ConstraintViolations, Category>> update(Category category);
}
