import 'package:flutter/material.dart';
import 'package:view_met_remade/core/widgets/banner_ad_widget.dart';
import 'package:view_met_remade/features/departments/presentation/pages/departments_list.dart';

class DepartmentsListWidget extends StatelessWidget {
  const DepartmentsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Column(
        children: <Widget>[
          const BannerAdWidget(),
          const SizedBox(height: 10),
          Text("Departments", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(.90))),
          Expanded(
            child: Scrollbar(
              child: const DepartmentsList(),
            ),
          ),
        ],
      ),
    );
  }
}
