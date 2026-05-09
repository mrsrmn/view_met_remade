import 'package:flutter/material.dart';

class ViewMetImage extends StatelessWidget {
  const ViewMetImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
          "assets/MET.jpg",
          fit: BoxFit.cover,
          color: const Color.fromRGBO(117, 117, 117, 0.5),
          colorBlendMode: BlendMode.modulate
      ),
    );
  }
}
