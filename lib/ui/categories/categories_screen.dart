import 'package:flutter/material.dart';
import 'package:smtm_client/domain/categories/categories_repository.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/ui/categories/category_edit_screen.dart';
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
  late Future<List<Category>> _categories;

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
      content: _buildContent(),
      primaryAction: _buildNewCategoryButton(),
    );
  }

  Widget _buildContent() {
    return FutureBuilder(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.hasFirstLoaded()) {
            return _buildCategoryList(snapshot.requireData);
          }

          return const CircularProgressIndicator();
        });
  }

  Widget _buildNewCategoryButton() {
    return FloatingActionButton(
      onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) =>
              CategoryEditScreen(viewModel: widget.viewModel)),
      child: const Icon(Icons.add),
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return ListView(
        children: categories.map((e) => _buildCategoryTile(e)).toList());
  }

  Widget _buildCategoryTile(Category category) {
    return ListTile(
      title: Text(category.name),
      leading: const Icon(Icons.folder),
    );
  }
}

extension _CategoriesAsyncState on AsyncSnapshot<List<Category>> {
  bool hasFirstLoaded() {
    return hasData && connectionState == ConnectionState.done;
  }
}
