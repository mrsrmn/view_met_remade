import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injectors/injection_container_piece.dart';
import '../../../piece/presentation/widgets/loading_widget.dart';
import '../bloc/piece_bloc.dart';
import '../widgets/piece_display.dart';
import '../widgets/message_display.dart';


class PiecePage extends StatelessWidget {

  final int id;

  const PiecePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Piece"),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<PieceBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PieceBloc>()..add(OnPieceRequestedEvent(id)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<PieceBloc, PieceState>(
            builder: (context, state) {
              if (state is Loading) {
                return const LoadingWidget();
              } else if (state is Loaded) {
                return PieceDisplay(state.piece);
              } else if (state is Error) {
                return MessageDisplay(
                  message: state.message,
                );
              } else {
                return const LoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}