import 'package:flutter/material.dart';
import 'package:view_met_remade/features/departments/domain/entities/department.dart';
import 'package:view_met_remade/features/departments/presentation/widgets/department_card.dart';

class DepartmentsListDisplay extends StatelessWidget {
  final List<Department> departments;

  const DepartmentsListDisplay({
    Key? key,
    required this.departments
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 7),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: departments.length,
      itemBuilder: (BuildContext context, int index) {
        return SafeArea(
          top: false,
          left: false,
          right: false,
          bottom: index + 1 == departments.length,
          child: DepartmentCard(department: departments[index]),
        );
      },
    );
  }
}