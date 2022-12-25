import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';

void main() {
  runApp(const SmtmClient());
}

class SmtmClient extends StatelessWidget {

  const SmtmClient({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();
    return MaterialApp(
      title: 'SMTM Client',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.blueGrey,
          secondary: Colors.red
        ),
        useMaterial3: true
      ),
      onGenerateRoute: SmtmRouter.generateRoute,
      initialRoute: SmtmRouter.home,
    );
  }
}
