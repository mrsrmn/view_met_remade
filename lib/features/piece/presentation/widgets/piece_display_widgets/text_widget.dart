import 'package:flutter/material.dart';


class PieceTextWidget extends StatelessWidget {
  final String title;
  final String content;

  const PieceTextWidget({
    Key? key,
    required this.title,
    required this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(.90)),
            ),
          )
        ],
      ),
    );
  }
}