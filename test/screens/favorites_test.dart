import 'package:aula14_tests/models/favorites.dart';
import 'package:aula14_tests/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

late Favorites favoritesList;

Widget createMain() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group("Testando Widgets da Favorites", () {
    testWidgets("Testando se a ListView está presente", (widgetTester) async {
      await widgetTester.pumpWidget(createMain());
      addItems();
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
