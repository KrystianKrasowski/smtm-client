import 'package:flutter/material.dart';
import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/ui/common/screen.dart';

class CategoriesScreen extends StatefulWidget {

  final CategoriesViewModel viewModel;

  factory CategoriesScreen.of(CategoriesRepository repository) {
    return CategoriesScreen(viewModel: CategoriesViewModel(repository));
  }

  const CategoriesScreen({super.key, required this.viewModel});

  @override
  State createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<Categories> _categories;

  @override
  void initState() {
    super.initState();
    _categories = widget.viewModel.get();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Categories',
      selectedRoute: SmtmRouter.categories,
      content: FutureBuilder(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.hasFirstLoaded()) {
              return _buildCategoryList(snapshot.requireData);
            }

            return const CircularProgressIndicator();
          })
    );
  }

  Widget _buildCategoryList(Categories categories) {
    return ListView(
        children: categories.list.map((e) => _buildCategoryTile(e)).toList()
    );
  }

  Widget _buildCategoryTile(Category category) {
    return ListTile(
      title: Text(category.name),
      leading: const Icon(Icons.folder),
    );
  }
}

extension _CategoriesAsyncState on AsyncSnapshot<Categories> {

  bool hasFirstLoaded() {
    return hasData && connectionState == ConnectionState.done;
  }
}