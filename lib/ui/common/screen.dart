import 'package:flutter/material.dart';
import 'package:smtm_client/ui/common/navigation_desktop.dart';

class Screen extends StatelessWidget {
  final String title;
  final Widget content;
  final String selectedRoute;
  final Widget? primaryAction;

  const Screen(
      {super.key,
      required this.title,
      required this.content,
      required this.selectedRoute,
      this.primaryAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(title),
        ),
        body: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: Colors.grey)),
              color: Colors.white),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: NavigationDesktop(
                  selectedRoute: selectedRoute,
                  leading: primaryAction,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: content,
                ),
              )
            ],
          ),
        ));
  }
}
