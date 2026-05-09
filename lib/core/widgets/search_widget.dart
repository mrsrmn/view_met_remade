import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {

  final TextEditingController controller;

  const SearchWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 200, 0, 20),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 300,
            child: TextField(
              controller: controller,
              onSubmitted: (String value) {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => SearchPage(text: _controller.text)
                //     )
                // );
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(99),
                    ),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Search View MET",
                  fillColor: Colors.white
              ),
            ),
          )
      ),
    );
  }
}