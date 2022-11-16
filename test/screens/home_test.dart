import 'package:aula14_tests/models/favorites.dart';
import 'package:aula14_tests/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Widget createMain() => ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

void main() {
  group("Testando Widgets da Home", () {
    testWidgets("Testando se a ListView está presente", (widgetTester) async {
      await widgetTester.pumpWidget(createMain());
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets("Testando Scroll", (widgetTester) async {
      await widgetTester.pumpWidget(createMain());
      expect(find.text("Item 0"), findsOneWidget);
      await widgetTester.fling(find.byType(ListView), Offset(0, -200), 3000);
      await widgetTester.pumpAndSettle();
      expect(find.text("Item 0"), findsNothing);
    });

    testWidgets('Testando botão de favoritos', (tester) async {
      await tester.pumpWidget(createMain());
      expect(find.byIcon(Icons.favorite), findsNothing);
      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Adicinado aos favoritos.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsWidgets);
      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Removido dos favoritos.'), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });
  });
}
