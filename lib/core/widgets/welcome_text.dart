import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 130, 0, 20),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: builder()
      ),
    );
  }

  Widget builder() {
    var now = DateTime.now();

    if (now.hour.isBetween(5, 11)) {
      return Text("Good Morning", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold));
    }
    else if (now.hour.isBetween(12, 17)) {
      return Text("Good Afternoon", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold));
    }
    else if (now.hour.isBetween(18, 21) && now.hour.isBetween(5, 19) || now.hour == 0) {
      return Text("Good Evening", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold));
    }
    else {
      return Text("Hello", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold));
    }
  }
}

extension Range on num {
  bool isBetween(num from, num to) {
    return from <= this && this <= to;
  }
}