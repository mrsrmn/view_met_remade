import 'package:flutter/material.dart';
import 'package:view_met_remade/core/widgets/banner_ad_widget.dart';
import 'package:view_met_remade/features/collections/presentation/widgets/add_to_collection_widget.dart';
import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/add_to_favorites_widget.dart';

import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/image_widget.dart';
import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/link_widget.dart';
import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/share_card.dart';
import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/share_widget.dart';
import 'package:view_met_remade/features/piece/presentation/widgets/piece_display_widgets/text_widget.dart';

import '../../domain/entities/piece.dart';

class PieceDisplay extends StatefulWidget {
  final Piece piece;

  const PieceDisplay(this.piece, {Key? key}) : super(key: key);

  @override
  State<PieceDisplay> createState() => _PieceDisplayState();
}

class _PieceDisplayState extends State<PieceDisplay> {
  final GlobalKey _shareCardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: <Widget>[
            PieceImageWidget(image: widget.piece.primaryImageSmall),
            const SizedBox(height: 10),
            const BannerAdWidget(releaseAdUnitId: 'ca-app-pub-5871478675170774/6236935663'),
            const SizedBox(height: 10),
            PieceTextWidget(title: "Title: ", content: widget.piece.title),
            PieceTextWidget(title: "Object Name: ", content: widget.piece.objectName),
            PieceTextWidget(title: "Artist: ", content: widget.piece.artistDisplayName),
            PieceTextWidget(title: "Object ID: ", content: widget.piece.objectID.toString()),
            PieceTextWidget(title: "Is Highlighted: ", content: widget.piece.isHighlight.toString()),
            PieceTextWidget(title: "Date: ", content: widget.piece.objectDate),
            PieceTextWidget(title: "Accession Year: ", content: widget.piece.accessionYear),
            PieceTextWidget(title: "Accession Number: ", content: widget.piece.accessionNumber),
            PieceTextWidget(title: "Department: ", content: widget.piece.department),
            PieceTextWidget(title: "Culture: ", content: widget.piece.culture),
            PieceTextWidget(title: "Dimensions: ", content: widget.piece.dimensions),
            PieceTextWidget(title: "Credit Line: ", content: widget.piece.creditLine),
            PieceTextWidget(title: "Country: ", content: widget.piece.country),
            PieceLinkWidget(link: widget.piece.objectURL),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 7),
              child: Row(
                children: [
                  ShareWidget(piece: widget.piece, repaintBoundaryKey: _shareCardKey),
                  const SizedBox(width: 8),
                  PieceFavoritesWidget(piece: widget.piece),
                  const SizedBox(width: 8),
                  AddToCollectionWidget(piece: widget.piece),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: -1000,
          top: -1000,
          child: RepaintBoundary(
            key: _shareCardKey,
            child: ShareCard(piece: widget.piece),
          ),
        ),
      ],
    );
  }
}
