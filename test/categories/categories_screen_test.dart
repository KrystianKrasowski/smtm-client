import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smtm_client/domain/categories/categories_viewmodel.dart';
import 'package:smtm_client/ui/categories/categories_screen.dart';

import 'categories_repository_stub.dart';

void main() {

  testWidgets("Should display loading indicator", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: CategoriesScreen.of(CategoriesRepositoryLoadingStub()),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await widgetTester.pumpAndSettle();
  });

  testWidgets("Should display category list", (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: CategoriesScreen.of(CategoriesRepositoryStub([
        Category(Uri.parse("https://api.smtm.com/categories/1"), "Rent"),
        Category(Uri.parse("https://api.smtm.com/categories/2"), "Groceries"),
        Category(Uri.parse("https://api.smtm.com/categories/3"), "Services"),
      ])),
    ));
    await widgetTester.pumpAndSettle();

    expect(find.widgetWithText(ListTile, 'Rent'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Groceries'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'Services'), findsOneWidget);
  });
}
