import 'package:flutter/material.dart';
import 'package:smtm_client/categories_viewmodel.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/screen.dart';

import 'api/categories_api.dart';

class CategoriesScreen extends StatefulWidget {

  final viewModel = CategoriesViewModel('http://localhost:8080');

  CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {

  late CategoryForm _categoryForm;
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();
    _categoryForm = CategoryForm(onSuccess: _refreshCategoryList, key: const Key('blank'));
    _categories = widget.viewModel.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: 'Categories',
      selectedRoute: SmtmRouter.categories,
      content: Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                _categoryForm,
                _buildCategoryList()
              ],
            )
        ),
      ),
    );
  }


  Widget _buildCategoryList() {
    return FutureBuilder(
      future: _categories,
      builder: (BuildContext ctx, AsyncSnapshot<List<Category>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
          return Center(
            child: Column(
              children: const [
                Text('Something went wrong. Try again later.'),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Expanded(
            child: Card(
              child: _createCategoriesList(snapshot.requireData),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView _createCategoriesList(List<Category> categories) {
    return ListView(
        children: categories.map((category) => ListTile(
          title: Text(category.name),
          leading: const Icon(Icons.folder),
          onTap: () => { _selectCategory(category) },
        )).toList()
    );
  }

  void _selectCategory(Category category) {
    setState(() {
      _categoryForm = CategoryForm(
        key: Key(category.name),
        onSuccess: _refreshCategoryList,
        category: category,
      );
    });
  }

  void _refreshCategoryList() {
    setState(() {
      _categories = widget.viewModel.fetch();
    });
  }
}

class CategoryForm extends StatefulWidget {

  final viewModel = CategoriesViewModel('http://localhost:8080');
  final Function() onSuccess;
  final Category? category;

  CategoryForm({super.key, required this.onSuccess, this.category});

  @override
  State<StatefulWidget> createState() {
    return _CategoryFormState();
  }
}

class _CategoryFormState extends State<CategoryForm> {

  final TextEditingController _nameController = TextEditingController();
  late Future<String> _violation;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.category?.name ?? 'none';
    _violation = Future.value('');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _violation,
        builder: (BuildContext ctx, AsyncSnapshot<String?> snapshot) {
          String? error;

          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {

            error = snapshot.requireData != '' ? snapshot.requireData : null;

            return _buildForm(true, error);
          }

          return _buildForm(false, null);
        }
    );
  }

  Widget _buildForm(bool enabled, String? error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: _nameController,
            enabled: enabled,
//                  onChanged: _clearSelectedCategoryIdIfEmpty,
            decoration: InputDecoration(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 100),
              labelText: 'Name',
              border: const OutlineInputBorder(),
              errorText: error,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: enabled ? _saveCategory : null,
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }

  void _saveCategory() {
    String name = _nameController.text;

    if (name != '') {
      setState(() {
        _violation = widget.viewModel.save(null, name);
      });
      widget.onSuccess();
    }
  }
}
