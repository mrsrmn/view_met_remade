import 'package:flutter/material.dart';

import '../../../piece/domain/entities/piece.dart';
import '../../../piece/presentation/widgets/piece_card.dart';

class DepartmentPiecesDisplay extends StatelessWidget {
  final List<Piece> pieces;

  const DepartmentPiecesDisplay({
    Key? key,
    required this.pieces
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pieces.length,
      itemBuilder: (context, index) {
        return PieceCard(piece: pieces[index]);
      },
    );
  }
}