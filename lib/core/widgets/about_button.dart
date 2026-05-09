import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/about_page.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      color: Colors.white,
      icon: const Icon(CupertinoIcons.info),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutPage()),
        );
      },
    );
  }
}
