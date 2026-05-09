import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:view_met_remade/features/favorite/presentation/pages/favorites_page.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      color: Colors.white,
      icon: const Icon(CupertinoIcons.heart_fill),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoritesPage()),
        );
      },
    );
  }
}
