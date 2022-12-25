import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/screen.dart';

class TransactionsScreen extends StatelessWidget {

  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      title: 'Transactions',
      content: Text('Hello transactions'),
      selectedRoute: SmtmRouter.transactions,
    );
  }
}
