import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:view_met_remade/core/widgets/banner_ad_widget.dart';
import 'package:view_met_remade/features/favorite/presentation/bloc/favorites_bloc.dart';

import 'package:view_met_remade/features/favorite/presentation/widgets/loading_widget.dart';
import 'package:view_met_remade/features/favorite/presentation/widgets/message_display.dart';

import '../../../../core/injectors/injection_container_favorite.dart';
import '../widgets/favorites_display.dart';


class FavoritesPage extends StatelessWidget {

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<FavoritesBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritesBloc>()..add(OnFavoritesRequestedEvent()),
      child: Column(
        children: [
          const BannerAdWidget(releaseAdUnitId: 'ca-app-pub-5871478675170774/9768986565'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return FavoritesDisplay(favorites: state.favoritedPieces);
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
        ],
      ),
    );
  }
}