 import 'package:aula14_tests/models/favorites.dart';
import 'package:aula14_tests/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late Favorites favoritesList;

Widget createMain() = ChangeNotifierProvider<Favorites>(create: (context) {
  favoritesList = Favorites();
  return favoritesList;
},
 child: MaterialApp(
  home: FavoritesPage(),
 ) ,
);