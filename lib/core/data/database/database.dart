import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../res/color_print.dart';
import 'data_base_keys.dart';
import 'models/resume_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  final String _databaseName = 'resume_maker.db';
  Database? _database;

  Future<void> initDatabase() async {
    printOkStatus("initDatabase");
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        //* -=-=-=-=-=-=-=-=-=>  Data types <-=-=-=-=-=-=-=-=-= //
        // String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        String notNull = 'NOT NULL';
        String textType = 'TEXT';
        // String boolType = 'BOOLEAN';
        // String integerType = 'INTEGER';
        // String realType = 'REAL';

        //* -=-=-=-=-=-=-=-=-=>  Tables <-=-=-=-=-=-=-=-=-= //
        await db.execute(
          """
        CREATE TABLE ${DatabaseKey.resumeTable}
          (
            uid $textType $notNull,
            name $textType,
            email $textType,
            designation $textType,
            mobileNumber $textType,
            dateOfBirth $textType,
            address $textType,
            collegeName $textType,
            degree $textType,
            startYear $textType,
            endYear $textType,
            skill $textType,
            fresherOrExperience $textType,
            experienceOfYear $textType,
            createdAt $textType,
            updateAt $textType
          )
      """,
        );
      },
    );
  }

  //* -=-=-=-=-=-=-=-=-=>  Resume Info Module (Start) <-=-=-=-=-=-=-=-=-= //
  //? Get all Resume list
  Future<List<ResumeModel>?> getAllResumeModel({RxBool? isLoader}) async {
    try {
      isLoader?.value = true;

      final List<ResumeModel> resumeListModel = (await _database?.query(
        DatabaseKey.resumeTable,
        orderBy: 'uid DESC',
      ))!
          .map((e) => ResumeModel.fromJson(e))
          .toList();

      if (resumeListModel.isNotEmpty) {
        return resumeListModel;
      } else {
        return null;
      }
    } catch (e) {
      printError(type: "getAllProductModel function", errText: "$e");
    } finally {
      isLoader?.value = false;
    }
    return null;
  }

  //? Get single resume
  Future<ResumeModel?> getSingleResumeModel(
      {required String quotationId, RxBool? isLoader}) async {
    try {
      isLoader?.value = true;

      final List<ResumeModel> resumeModel = (await _database?.query(
        DatabaseKey.resumeTable,
        where: 'uid = ?',
        whereArgs: [quotationId],
      ))!
          .map((e) => ResumeModel.fromJson(e))
          .toList();

      if (resumeModel.isNotEmpty) {
        return resumeModel.first;
      } else {
        return null;
      }
    } catch (e) {
      printError(type: "getAllQuotationsModel function", errText: "$e");
    } finally {
      isLoader?.value = false;
    }
    return null;
  }

  //? Set Resume information
  Future<ResumeModel?> setResumeData({required ResumeModel resumeModel}) async {
    final id = await _database?.insert(
      DatabaseKey.resumeTable,
      resumeModel.toJson(),
    );
    printData(key: "Add Resume", value: id);
    return resumeModel;
  }

  //? Update Resume information
  Future<ResumeModel?> updateResumeData(
      {required ResumeModel resumeModel}) async {
    final id = await _database?.update(
      DatabaseKey.resumeTable,
      where: 'uid = ?',
      whereArgs: [resumeModel.uid],
      resumeModel.toJson(),
    );
    printData(key: "Update Resume", value: id);
    return resumeModel;
  }

  //? Clear resume info
  Future<String?> deleteResume({required String resumeId}) async {
    final String tableName = DatabaseKey.resumeTable;

    try {
      await _database?.delete(
        tableName,
        where: 'uid = ?',
        whereArgs: [
          resumeId,
        ],
      );

      printData(key: "Delete resume in local DB", value: "resumeId: $resumeId");
      return resumeId;
    } catch (err) {
      printError(type: "Function: deleteQuotation", errText: err);
      return null;
    }
  }
//* -=-=-=-=-=-=-=-=-=>  Resume Info Module (End) <-=-=-=-=-=-=-=-=-= //
}
