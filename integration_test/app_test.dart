import 'package:aula14_tests/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// flutter drive --driver integration_test/driver.dart --target integration_test/app_test.dart --profile --no-dds
void main() {
  group("Testando a performance de App", () {
    // garante que o driver está iniciado
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets("Teste de Scroll", (widgetTester) async {
      await widgetTester.pumpWidget(App());

      final listFinder = find.byType(ListView);

      await binding.watchPerformance(() async {
        await widgetTester.fling(listFinder, Offset(0, -500), 3000);
        await widgetTester.pumpAndSettle();

        await widgetTester.fling(listFinder, Offset(0, 500), 3000);
        await widgetTester.pumpAndSettle();
      }, reportKey: 'scroll');
    });

    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(App());

      final iconKeys = [
        'icon_0',
        'icon_1',
        'icon_2',
      ];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(Duration(seconds: 1));

        expect(find.text('Adicionado aos favoritos.'), findsOneWidget);
      }

      await tester.tap(find.text('Favoritos'));
      await tester.pumpAndSettle();

      final removeIconKeys = [
        'remove_icon_0',
        'remove_icon_1',
        'remove_icon_2',
      ];

      for (final iconKey in removeIconKeys) {
        await tester.tap(find.byKey(ValueKey(iconKey)));
        await tester.pumpAndSettle(Duration(seconds: 1));

        expect(find.text('Removido dos favoritos.'), findsOneWidget);
      }
    });
  });
}
