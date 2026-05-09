import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../favorite/presentation/widgets/loading_widget.dart';
import '../../../departments/presentation/widgets/message_display.dart';
import '../bloc/department_bloc.dart';
import '../../../../core/injectors/injection_container_department.dart';
import '../widgets/departments_list_display.dart';

class DepartmentsList extends StatelessWidget {

  const DepartmentsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<DepartmentBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DepartmentBloc>()..add(OnDepartmentsRequestedEvent()),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: BlocBuilder<DepartmentBloc, DepartmentState>(
            builder: (context, state) {
              if (state is Loading) {
                return const LoadingWidget();
              } else if (state is LoadedDepartments) {
                return DepartmentsListDisplay(departments: state.departments);
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