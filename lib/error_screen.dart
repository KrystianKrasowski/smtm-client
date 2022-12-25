import 'package:flutter/material.dart';
import 'package:smtm_client/screen.dart';

class ErrorScreen extends StatelessWidget {

  final String title;
  final String selectedRoute;
  final String? details;

  const ErrorScreen({super.key, required this.title, required this.selectedRoute, this.details});

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: title,
        selectedRoute: selectedRoute,
        content: Center(
          child: Column(
            children: const [
              Text('Something went wrong. Try again later.'),
            ],
          ),
        )
    );
  }
}
