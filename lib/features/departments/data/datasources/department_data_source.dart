import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:view_met_remade/features/departments/data/models/department_model.dart';
import 'package:view_met_remade/features/piece/domain/repositories/piece_repository.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/exceptions/failures.dart';
import '../../../piece/domain/entities/piece.dart';
import '../../domain/entities/department.dart';
import 'package:http/http.dart' as http;

abstract class DepartmentDataSource {
  Future<Either<Failure, List<Department>>> getDepartments();
  Future<Either<Failure, List<Piece>>> getDepartmentPieces(Department department);
}

class DepartmentDataSourceImpl extends DepartmentDataSource {
  final http.Client client;
  final PieceRepository pieceRepository;

  DepartmentDataSourceImpl({required this.client, required this.pieceRepository});

  @override
  Future<Either<Failure, List<Department>>> getDepartments() async {
    final response = await client.get(
      Uri.parse("$kBaseApiUrl/departments"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map body = json.decode(response.body);
      List<Department> departments = [];

      for (var department in body["departments"]) {
        departments.add(DepartmentModel.fromJson(department));
      }

      return Right(departments);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Piece>>> getDepartmentPieces(Department department) async {
    final response = await client.get(
      Uri.parse("$kBaseApiUrl/search?departmentId=${department.departmentId}&q=%22%22"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map body = json.decode(response.body);
      List<Piece> pieces = [];
      List objectIDs = body["objectIDs"] ?? [];

      for (var pieceObjectId in objectIDs.take(20)) {
        var piece = await pieceRepository.getPiece(pieceObjectId);
        piece.fold(
          (failure) {},
          (pieceReceived) {
            pieces.add(pieceReceived);
          }
        );
      }

      return Right(pieces);
    } else {
      return Left(ServerFailure());
    }
  }
}

