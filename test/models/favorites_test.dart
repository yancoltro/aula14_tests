import "package:test/test.dart";
import "package:aula14_tests/models/favorites.dart";

void main() {
  group("Testando o Provider", () {
    var favorites = Favorites();

    test("Um novo item deve ser adicionado", () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });

    test("Um item deve ser removido ", () {
      var number = 35;
      expect(favorites.items.contains(number), true);
      favorites.remove(number);
      expect(favorites.items.contains(number), false);
    });
  });
}
