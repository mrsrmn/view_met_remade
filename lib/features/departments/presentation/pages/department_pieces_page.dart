import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/banner_ad_widget.dart';
import '../../../favorite/presentation/widgets/loading_widget.dart';
import '../../../departments/presentation/widgets/message_display.dart';
import '../../domain/entities/department.dart';
import '../bloc/department_bloc.dart';
import '../../../../core/injectors/injection_container_department.dart';
import '../widgets/department_pieces_display.dart';
import '../widgets/follow_department_button.dart';

class DepartmentPiecesPage extends StatelessWidget {
  final Department department;

  const DepartmentPiecesPage({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<DepartmentBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DepartmentBloc>()..add(OnDepartmentPiecesRequestedEvent(department: department)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(department.displayName),
          actions: [
            FollowDepartmentButton(department: department),
          ],
        ),
        body: Column(
          children: [
            const BannerAdWidget(releaseAdUnitId: 'ca-app-pub-5871478675170774/3371366075'),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: BlocBuilder<DepartmentBloc, DepartmentState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const LoadingWidget();
                } else if (state is LoadedPieces) {
                  return DepartmentPiecesDisplay(pieces: state.pieces);
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
            ),
          ],
        ),
      ),
    );
  }
}