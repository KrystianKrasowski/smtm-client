import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/ui/common/screen.dart';

class Budget extends StatelessWidget {

  const Budget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      title: 'Budget',
      content: Text('Budget transactions'),
      selectedRoute: SmtmRouter.budget,
    );
  }
}
