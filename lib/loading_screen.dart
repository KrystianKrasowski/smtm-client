import 'package:flutter/material.dart';
import 'package:smtm_client/screen.dart';

class LoadingScreen extends StatelessWidget {

  final String title;
  final String selectedRoute;

  const LoadingScreen({super.key, required this.title, required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    return Screen(
        title: title,
        selectedRoute: selectedRoute,
        content: const Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}
