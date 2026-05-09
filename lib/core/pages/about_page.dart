import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/view_met_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/MET.jpg",
              ),
              opacity: .20,
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.white.withAlpha(230)),
                      children: [
                        const TextSpan(
                          text: "Made by humans in ",
                        ),
                        TextSpan(
                          text: "Duna Yazılım & Danışmanlık",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await launchUrl(
                                Uri.parse("https://dunayazilim.com.tr")
                              );
                            },
                          style: const TextStyle(
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "ViewMET has no connections with The Metropolitan Museum of Art itself whatsoever.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230)
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}