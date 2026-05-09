import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../domain/entities/department.dart';
import '../pages/department_pieces_page.dart';

class DepartmentCard extends StatelessWidget {
  final Department department;

  const DepartmentCard({Key? key, required this.department}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        dense: true,
        title: Text(department.displayName, style: TextStyle(color: Colors.white.withOpacity(.90))),
        trailing: const Icon(CupertinoIcons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DepartmentPiecesPage(department: department)),
          );
        },
      ),
    );
  }
}