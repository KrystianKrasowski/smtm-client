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

  Category? _selectedCategory;
  late Future<List<Category>> _categories;
  late Future<String> _violation;

  @override
  void initState() {
    super.initState();
    _categories = widget.viewModel.fetch();
    _violation = Future.value("");
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
                CategoryForm(
                  category: _selectedCategory,
                  onSubmit: _submitForm,
                  violation: _violation,
                ),
                CategoryList(
                  categories: _categories,
                  onSelect: _selectCategory,
                  selectedCategory: _selectedCategory,
                )
              ],
            )
        ),
      ),
    );
  }

  void _selectCategory(Category? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _submitForm(int? id, String name) {
    setState(() {
      _violation = widget.viewModel.save(id, name);
    });
  }

  void _reloadCategories() {
    setState(() {
      _categories = widget.viewModel.fetch();
      _selectedCategory = null;
    });
  }
}

class CategoryList extends StatefulWidget {

  final Future<List<Category>> categories;
  final Function(Category?) onSelect;
  final Category? selectedCategory;

  const CategoryList({super.key, required this.categories, required this.onSelect, this.selectedCategory});

  @override
  State<StatefulWidget> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.categories,
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
          selected: category == _selectedCategory,
        )).toList()
    );
  }

  void _selectCategory(Category category) {
    setState(() {
      _selectedCategory = category != _selectedCategory
          ? category
          : null;
      widget.onSelect(_selectedCategory);
    });
  }
}

class CategoryForm extends StatefulWidget {

  final Category? category;
  final Function(int?, String) onSubmit;
  final Future<String> violation;

  const CategoryForm({super.key, this.category, required this.onSubmit, required this.violation});

  @override
  State<StatefulWidget> createState() {
    return _CategoryFormState();
  }
}

class _CategoryFormState extends State<CategoryForm> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.violation,
      builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return _buildForm(snapshot.requireData, true);
        }

        return _buildForm("", false);
      },
    );
  }

  Widget _buildForm(String violation, bool enabled) {
    var controller = TextEditingController(text: widget.category?.name);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: controller,
            enabled: enabled,
            decoration: InputDecoration(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 100),
              labelText: 'Name',
              errorText: violation == "" ? null : violation,
              border: const OutlineInputBorder(),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: enabled ? () => widget.onSubmit(widget.category?.id, controller.text) : null,
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}
