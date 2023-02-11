import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';
import 'package:smtm_client/ui/common/screen.dart';

class WalletsScreen extends StatelessWidget {

  const WalletsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Screen(
      title: 'Wallets',
      content: Text('Wallets'),
      selectedRoute: SmtmRouter.wallets,
    );
  }
}
