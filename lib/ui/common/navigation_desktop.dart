import 'package:flutter/material.dart';
import 'package:smtm_client/router.dart';

class NavigationDesktop extends StatefulWidget {
  final String selectedRoute;
  final Widget? leading;

  const NavigationDesktop(
      {super.key, required this.selectedRoute, this.leading});

  @override
  State<StatefulWidget> createState() => _NavigationDesktopState();
}

class _NavigationDesktopState extends State<NavigationDesktop> {
  late String _selectedRoute;

  @override
  void initState() {
    super.initState();
    _selectedRoute = widget.selectedRoute;
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return NavigationRail(
      leading: widget.leading,
      destinations: const <NavigationRailDestination>[
        NavigationRailDestination(
            icon: Icon(Icons.dashboard_outlined),
            padding: EdgeInsets.only(top: 20),
            selectedIcon: Icon(Icons.dashboard),
            label: Text('Dashboard')),
        NavigationRailDestination(
            icon: Icon(Icons.payments_outlined),
            selectedIcon: Icon(Icons.payments),
            label: Text('Transactions')),
        NavigationRailDestination(
            icon: Icon(Icons.summarize_outlined),
            selectedIcon: Icon(Icons.summarize),
            label: Text('Budget')),
        NavigationRailDestination(
            icon: Icon(Icons.wallet_outlined),
            selectedIcon: Icon(Icons.wallet),
            label: Text('Wallets')),
        NavigationRailDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: Text('Categories')),
      ],
      selectedIndex: SmtmRouter.getRouteIndex(_selectedRoute),
      onDestinationSelected: changeDestination,
      labelType: NavigationRailLabelType.all,
      selectedLabelTextStyle: TextStyle(color: primaryColor, fontSize: 12),
      minWidth: 100,
    );
  }

  changeDestination(int index) {
    setState(() {
      _selectedRoute = SmtmRouter.getRouteName(index);
    });
    Navigator.pushNamed(context, SmtmRouter.getRouteName(index));
  }
}
