import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:view_met_remade/features/piece/presentation/pages/piece_page.dart';

import '../../../piece/data/models/piece_model.dart';
import '../../../piece/presentation/widgets/piece_display_widgets/image_widget.dart';

class FavoritesPieceCard extends StatelessWidget {
  final PieceModel piece;

  const FavoritesPieceCard({Key? key, required this.piece}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        dense: true,
        leading: SizedBox(
          width: 40,
          height: 40,
          child: PieceImageWidget(image: piece.primaryImageSmall),
        ),
        title: Text(piece.title, style: TextStyle(color: Colors.white.withOpacity(.90))),
        subtitle: Text("by ${piece.artistDisplayName}"),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PiecePage(id: piece.objectID)),
          );
        },
      ),
    );
  }
}