import 'dart:convert';

import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';

import '../../../../../core/exceptions/failures.dart';
import '../../../../../core/injectors/injection_container_favorite.dart';
import '../../../../favorite/domain/repositories/favorites_repository.dart';
import '../../../data/models/piece_model.dart';
import '../../../domain/entities/piece.dart';

class PieceFavoritesWidget extends StatefulWidget {
  final Piece piece;

  const PieceFavoritesWidget({Key? key, required this.piece}) : super(key: key);

  @override
  State<PieceFavoritesWidget> createState() => _PieceFavoritesWidgetState();
}

class _PieceFavoritesWidgetState extends State<PieceFavoritesWidget> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    FavoritesRepository repo = sl<FavoritesRepository>();
    var result = await repo.getFavorites();
    result.fold(
      (failure) {},
      (favorites) {
        for (var fav in favorites) {
          Map<String, dynamic> data = json.decode(fav);
          if (data['objectID'] == widget.piece.objectID) {
            if (mounted) setState(() => _isFavorited = true);
            return;
          }
        }
      },
    );
  }

  PieceModel get _pieceModel => PieceModel(
    title: widget.piece.title,
    objectName: widget.piece.objectName,
    artistDisplayName: widget.piece.artistDisplayName,
    objectID: widget.piece.objectID,
    isHighlight: widget.piece.isHighlight,
    objectDate: widget.piece.objectDate,
    accessionYear: widget.piece.accessionYear,
    accessionNumber: widget.piece.accessionNumber,
    department: widget.piece.department,
    culture: widget.piece.culture,
    dimensions: widget.piece.dimensions,
    creditLine: widget.piece.creditLine,
    objectURL: widget.piece.objectURL,
    primaryImageSmall: widget.piece.primaryImageSmall,
    country: widget.piece.country,
  );

  Future<void> _onPressed() async {
    FavoritesRepository repo = sl<FavoritesRepository>();

    if (_isFavorited) {
      var result = await repo.removeFromFavorites(_pieceModel);
      result.fold(
        (failure) => _showSnackBar("Failed to remove from favorites."),
        (success) {
          setState(() => _isFavorited = false);
          _showSnackBar("Removed ${widget.piece.title} from favorites.");
        },
      );
    } else {
      var result = await repo.addToFavorites(_pieceModel);
      result.fold(
        (failure) => _showSnackBar("Failed to add to favorites list."),
        (success) {
          setState(() => _isFavorited = true);
          _showSnackBar("Successfully added ${widget.piece.title} to favorites!");
        },
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            _isFavorited ? Colors.grey : Colors.red,
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 12)),
        ),
        onPressed: _onPressed,
        icon: Icon(
          _isFavorited ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
          size: 16,
        ),
        label: Text(
          _isFavorited ? "Saved" : "Favorite",
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
