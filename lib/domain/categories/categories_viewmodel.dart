import 'package:dartz/dartz.dart';
import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';

class CategoriesViewModel {

  final CategoriesRepository repository;

  CategoriesViewModel(this.repository);

  Future<List<Category>> get() async {
    return repository.getAll();
  }

  Future<Either<ConstraintViolations, Category>> save(String name, Uri? id) async {
    if (id == null) {
      return repository.create(name);
    } else {
      return repository.update(Category(id, name));
    }
  }
}