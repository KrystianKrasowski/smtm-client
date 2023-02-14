import 'package:flutter/material.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';
import 'package:smtm_client/router.dart';

class CategoryEditScreen extends StatefulWidget {
  final CategoriesViewModel viewModel;
  final Category? category;

  const CategoryEditScreen({super.key, required this.viewModel, this.category});

  @override
  State<StatefulWidget> createState() => CategoryEditState();
}

class CategoryEditState extends State<CategoryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String? _nameViolation;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.category?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(getFormTitle()),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Name',
                errorText: _nameViolation,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Submit'),
        )
      ],
    );
  }

  String getFormTitle() =>
      widget.category != null ? 'Change category' : 'New category';

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() async {
    final name = _controller.text;
    final result = await widget.viewModel.save(name, widget.category?.id);
    result.fold(_onConstraintViolation, _onSaveSuccess);
  }

  void _onConstraintViolation(ConstraintViolations violations) {
    setState(() {
      _nameViolation = violations.get('name');
    });
  }

  void _onSaveSuccess(Category category) {
    Navigator.pushReplacementNamed(context, SmtmRouter.categories);
  }
}
