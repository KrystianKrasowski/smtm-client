import 'package:flutter/material.dart';
import 'package:smtm_client/ui/common/navigation_desktop.dart';

class Screen extends StatelessWidget {
  final String title;
  final Widget content;
  final String selectedRoute;

  const Screen(
      {super.key,
      required this.title,
      required this.content,
      required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Row(
        children: [
          NavigationDesktop(selectedRoute: selectedRoute),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: content,
            )
          )
        ],
      ),
    );
  }
}
