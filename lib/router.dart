import 'package:flutter/material.dart';
import 'package:smtm_client/api/categories_client.dart';
import 'package:smtm_client/ui/budget/budget.dart';
import 'package:smtm_client/ui/categories/categories_screen.dart';
import 'package:smtm_client/ui/dashboard/dashboard_screen.dart';
import 'package:smtm_client/no_animation_material_page_route.dart';
import 'package:smtm_client/ui/common/not_found_screen.dart';
import 'package:smtm_client/ui/transactions/transactions_screen.dart';
import 'package:smtm_client/ui/wallets/wallets_screen.dart';

class SmtmRouter {

  static const home = '/';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const budget = '/budget';
  static const wallets = '/wallets';
  static const categories = '/categories';

  static final List<String> _navigationOrder = [
    dashboard,
    transactions,
    budget,
    wallets,
    categories
  ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      case dashboard:
        return NoAnimationMaterialPageRoute(builder: (_) => const DashboardScreen(), settings: settings);
      case transactions:
        return NoAnimationMaterialPageRoute(builder: (_) => const TransactionsScreen(), settings: settings);
      case budget:
        return NoAnimationMaterialPageRoute(builder: (_) => const Budget(), settings: settings);
      case wallets:
        return NoAnimationMaterialPageRoute(builder: (_) => const WalletsScreen(), settings: settings);
      case categories:
        return NoAnimationMaterialPageRoute(builder: (_) => CategoriesScreen.of(MockedCategoriesClient()), settings: settings);
      default:
        return NoAnimationMaterialPageRoute(builder: (_) => const NotFoundScreen(), settings: settings);
    }
  }

  static getRouteIndex(String route) {
    return _navigationOrder.indexOf(route);
  }

  static getRouteName(int index) {
    return _navigationOrder.elementAt(index);
  }
}
