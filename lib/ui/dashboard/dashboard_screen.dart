import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/ui/common/screen.dart';

class DashboardScreen extends StatelessWidget {

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      title: 'Dashboard',
      content: Text('Hello dashboard'),
      selectedRoute: SmtmRouter.dashboard,
    );
  }
}
