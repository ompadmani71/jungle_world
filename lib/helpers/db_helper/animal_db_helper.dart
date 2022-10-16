import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/animal_model.dart';

class AnimalDBHelper {
  AnimalDBHelper._();

  static final AnimalDBHelper animalDBHelper = AnimalDBHelper._();

  Database? dbs;

  String animalTableName = "animal";

  String animalColumn1_ID = "id";
  String animalColumn2_name = "animal_name";
  String animalColumn3_commonName = "common_name";
  String animalColumn4_location = "location";
  String animalColumn5_nesting = "nesting_location";
  String animalColumn6_color = "color";
  String animalColumn7_spped = "top_speed";
  String animalColumn8_weight = "weight";
  String animalColumn9_length = "length";
  String animalColumn10_length = "image";

  Future<Database?> init() async {

    String path = await getDatabasesPath();

    String dataBasePath = join(path, "animal.db");

    dbs = await openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (Database database, version) async {
        String query = "CREATE TABLE IF NOT EXISTS $animalTableName($animalColumn1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $animalColumn2_name TEXT, $animalColumn3_commonName TEXT, $animalColumn4_location TEXT, $animalColumn5_nesting TEXT, $animalColumn6_color TEXT, $animalColumn7_spped TEXT, $animalColumn8_weight TEXT, $animalColumn9_length TEXT, $animalColumn10_length TEXT);";
        await database.execute(query);
      },
    );
    String query = "CREATE TABLE IF NOT EXISTS $animalTableName($animalColumn1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $animalColumn2_name TEXT, $animalColumn3_commonName TEXT, $animalColumn4_location TEXT, $animalColumn5_nesting TEXT, $animalColumn6_color TEXT, $animalColumn7_spped TEXT, $animalColumn8_weight TEXT, $animalColumn9_length TEXT, $animalColumn10_length TEXT);";

    dbs!.execute(query);
    return dbs;
  }

  Future insertRecord({required List<Animal> data}) async {
    // deleteTable();
    dbs = await init();
   for(var i=0; i< data.length; i++){

     String sql = "INSERT INTO $animalTableName VALUES(NULL, '${data[i].name}', '${data[i].common_name}', '${data[i].location}', '${data[i].nesting_location}', '${data[i].color}', '${data[i].top_speed}', '${data[i].weight}', '${data[i].length}', '${data[i].images_bytes}');";
     await dbs!.rawInsert(sql);
   }

  }

  Future deleteTable() async {
    dbs = await init();
    String sql = "DROP TABLE $animalTableName";
   await dbs!.execute(sql);
  }

  Future<List<Animal>> fetchConditionalData ({required String where})  async {
    dbs = await init();
    String sql = "SELECT *FROM $animalTableName WHERE $animalColumn2_name like '$where'";
    // String sql = "SELECT *FROM $animalTableName";

    List<Map<String, dynamic>> data = await dbs!.rawQuery(sql);
    List<Animal> animalData = animalFromJsonDatabase(jsonEncode(data));
    return animalData;
  }

}