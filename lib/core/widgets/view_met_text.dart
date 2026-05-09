import 'package:flutter/material.dart';

class ViewMetText extends StatelessWidget {
  const ViewMetText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'ViewMET',
          style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
