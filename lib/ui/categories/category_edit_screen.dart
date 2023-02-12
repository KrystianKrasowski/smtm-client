import 'package:flutter/material.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';
import 'package:smtm_client/domain/categories/category.dart';
import 'package:smtm_client/domain/shared/constraint_violation.dart';
import 'package:smtm_client/router.dart';

class CategoryEditScreen extends StatefulWidget {
  final CategoriesViewModel viewModel;

  const CategoryEditScreen({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => CategoryEditState();
}

class CategoryEditState extends State<CategoryEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String? _nameViolation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
      child: SizedBox(
        width: 400,
        child: Form(
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
                    errorText: _nameViolation),
              ),
              ButtonBar(
                children: [
                  OutlinedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    final name = _controller.text;
    final result = await widget.viewModel.create(name);
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
