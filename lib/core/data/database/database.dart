import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../res/color_print.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/ui_utils.dart';
import '../../../utils/utils.dart';
import 'data_base_keys.dart';
import 'models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  final String _databaseName = 'quotation_maker.db';
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
        CREATE TABLE ${DatabaseKey.userTable}
          (
            uid $textType $notNull,
            name $textType,
            email $textType,
            profileImage $textType,
            backUpType $textType,
            createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
      """,
        );
      },
    );
  }

  Future<void> backupDatabaseToFirebase({bool autoBackup = false}) async {
    if (await getConnectivityResult(showToast: false)) {
      final databasesPath = await getDatabasesPath();
      final sourcePath = join(databasesPath, _databaseName);

      // Close the database before uploading
      // await _database?.close();

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("backup")
          .child(LocalStorage.firebaseUid.value);
      final File sourceFile = File(sourcePath);

      try {
        if (autoBackup == false) {
          UiUtils.toast("Backup Started...");
          printYellow("Backup Started...");
        }

        await storageRef.putFile(sourceFile).then(
          (_) async {
            FullMetadata fullMetadata = await storageRef.getMetadata();
            await LocalStorage.storeBackUpTime(
                backUpTime: fullMetadata.updated.toString());
          },
        );

        if (autoBackup == false) {
          UiUtils.toast("Backup Completed!");
          printOkStatus("Backup Completed!");
        }

        printOkStatus(
            "Database backed up to Firebase Storage"); //! Only on test
      } catch (e) {
        printWarning('Error uploading database: $e');
      }

      // Reopen the database
      await initDatabase();
    }
  }

  Future<void> restoreDatabaseFromFirebase() async {
    if (await getConnectivityResult(showToast: false)) {
      final databasesPath = await getDatabasesPath();
      final targetPath = join(databasesPath, _databaseName);

      // Close the database before restoring
      await _database?.close();

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("backup")
          .child(LocalStorage.firebaseUid.value);
      final File targetFile = File(targetPath);

      try {
        await storageRef.writeToFile(targetFile);
        printOkStatus(
            "Database restored from Firebase Storage"); //! Only on test
      } catch (e) {
        printWarning('Error restoring database: $e');
      }

      // Reopen the database
      await initDatabase();
    }
  }

  Future<bool> isUserExistOrNot() async {
    bool isFirstTime = false;
    await FirebaseStorage.instance
        .ref()
        .child("backup")
        .child(LocalStorage.firebaseUid.value)
        .getDownloadURL()
        .then(
      (value) {
        isFirstTime = false;
      },
    ).catchError((onError) {
      isFirstTime = true;
    });
    return isFirstTime;
  }

  //* -=-=-=-=-=-=-=-=-=>  User Module (Start) <-=-=-=-=-=-=-=-=-= //
  //? Get user information
  Future<UserModel?> getUserInfoModel(/* {required String userID} */) async {
    List<UserModel> userDbModel = (await _database?.query(
      DatabaseKey.userTable,
      where: 'uid = ?',
      whereArgs: [LocalStorage.firebaseUid.value],
    ))!
        .map((e) => UserModel.fromJson(e))
        .toList();

    if (userDbModel.isNotEmpty) {
      return userDbModel.first;
    } else {
      return null;
    }
  }

  //? Set user information
  Future<int> setUserData(
      {required String userId,
      String? userName,
      String? userEmail,
      String? profileImage}) async {
    final id = await _database?.insert(
      DatabaseKey.userTable,
      {
        "uid": userId,
        "name": userName,
        "email": userEmail,
        "backUpType": "weekly",
        "profileImage": profileImage,
      },
    );

    printData(key: "uid", value: userId);
    printData(key: "name", value: userName);
    printData(key: "email", value: userEmail);
    printData(key: "backUpType", value: "weekly");
    printData(key: "profileImage", value: profileImage);
    return id ?? 0;
  }

  Future<int> setUserBackUpType({required String backUpType}) async {
    final id = await _database?.update(
      DatabaseKey.userTable,
      where: "uid = ?",
      whereArgs: [LocalStorage.firebaseUid.value],
      {
        "backUpType": backUpType,
      },
    );

    printData(key: "backUpType", value: backUpType);
    return id ?? 0;
  }

  //? Delete user information
  Future<void> deleteUserData() async {
    /* Use in logout actions */
    try {
      await _database?.delete(
        DatabaseKey.userTable,
        where: "uid = ?",
        whereArgs: [LocalStorage.firebaseUid.value],
      ).then(
        (value) {
          printData(
              key: "Delete user in local DB",
              value: LocalStorage.firebaseUid.value);
        },
      );
    } catch (err) {
      printError(type: "Function: deleteUserData", errText: err);
    }
  }
  //* -=-=-=-=-=-=-=-=-=>  User Module (End) <-=-=-=-=-=-=-=-=-= //
}
