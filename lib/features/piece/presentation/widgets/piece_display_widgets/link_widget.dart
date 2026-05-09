import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class PieceLinkWidget extends StatelessWidget {
  final String link;

  const PieceLinkWidget({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 130,
            child: Text(
              "Object URL: ",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
          RichText(
            text: TextSpan(
              text: "Link",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await launch(link, forceSafariVC: false);
                },
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}