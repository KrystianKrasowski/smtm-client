import 'package:flutter/material.dart';
import 'package:smtm_client/categories/categories_viewmodel.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/screen.dart';

import '../api/categories_api.dart';

class CategoriesCreatorScreen extends StatefulWidget {
  final viewModel = CategoriesViewModel('http://localhost:8080');

  CategoriesCreatorScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoriesCreatorScreenState();
}

class _CategoriesCreatorScreenState extends State<CategoriesCreatorScreen> {
  Category? _selectedCategory;
  late Future<CategoriesCreator> _categoriesCreator;

  @override
  void initState() {
    super.initState();
    _categoriesCreator = widget.viewModel.fetchCategoriesCreator();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoriesCreator,
      builder: (BuildContext ctx, AsyncSnapshot<CategoriesCreator> snapshot) {
        if (snapshot.isLoadingAfterSubmit()) {
          return _buildSavingCategoryScreen(snapshot.requireData);
        } else if (snapshot.hasSuccessfullySavedCategory() ||
            snapshot.hasSavingCategoryViolation()) {
          return _buildSavingFinishedScreen(snapshot.requireData);
        } else {
          return _buildFirstLoadScreen();
        }
      },
    );
  }

  Widget _buildSavingCategoryScreen(CategoriesCreator categoriesCreator) {
    return _buildScreen(_buildForm(false, categoriesCreator.lastViolation),
        _buildList(categoriesCreator.categories));
  }

  Widget _buildSavingFinishedScreen(CategoriesCreator categoriesCreator) {
    return _buildScreen(_buildForm(true, categoriesCreator.lastViolation),
        _buildList(categoriesCreator.categories));
  }

  Widget _buildFirstLoadScreen() {
    return _buildScreen(_buildForm(false, ""), _buildLoadingList());
  }

  Widget _buildForm(bool enabled, String violation) {
    return CategoryForm(
      enabled: enabled,
      violation: violation,
      onSubmit: _submitForm,
      initialValue: _selectedCategory?.name ?? "",
    );
  }

  Widget _buildList(List<Category> categories) {
    return CategoryList(
      categories: categories,
      selectedCategory: _selectedCategory,
      onSelect: _switchSelectedCategory,
    );
  }

  Widget _buildLoadingList() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildScreen(Widget formWidget, Widget listWidget) {
    return Screen(
      title: 'Categories',
      selectedRoute: SmtmRouter.categories,
      content: Align(
        alignment: Alignment.topCenter,
        child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                formWidget,
                listWidget,
              ],
            )),
      ),
    );
  }

  void _switchSelectedCategory(Category category) {
    setState(() {
      _selectedCategory = category == _selectedCategory ? null : category;
    });
  }

  void _submitForm(String categoryName) {
    setState(() {

    });
  }
}

extension CategoriesCreatorAsyncState on AsyncSnapshot<CategoriesCreator> {
  bool isLoadingAfterSubmit() {
    return hasData &&
        [ConnectionState.waiting, ConnectionState.active, ConnectionState]
            .contains(connectionState);
  }

  bool hasSuccessfullySavedCategory() {
    return hasData &&
        requireData.lastViolation == "" &&
        connectionState == ConnectionState.done;
  }

  bool hasSavingCategoryViolation() {
    return hasData &&
        requireData.lastViolation != "" &&
        connectionState == ConnectionState.done;
  }
}

class CategoryForm extends StatelessWidget {
  final bool enabled;
  final String violation;
  final Function(String) onSubmit;
  final String? initialValue;

  const CategoryForm(
      {super.key,
      required this.enabled,
      required this.violation,
      required this.onSubmit,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    var textEditingController = TextEditingController(text: initialValue);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: textEditingController,
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
              onPressed:
                  enabled ? () => {onSubmit(textEditingController.text)} : null,
              child: const Text('Save'),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category) onSelect;

  const CategoryList(
      {super.key,
      required this.categories,
      required this.onSelect,
      this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: ListView(
            children:
                categories.map((category) => _createTile(category)).toList()),
      ),
    );
  }

  ListTile _createTile(Category category) {
    return ListTile(
      title: Text(category.name),
      leading: const Icon(Icons.folder),
      onTap: () => {onSelect(category)},
      selected: category == selectedCategory,
    );
  }
}
