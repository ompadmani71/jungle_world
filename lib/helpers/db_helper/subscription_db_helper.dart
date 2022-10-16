import 'dart:convert';

import 'package:db_miner/model/subscription_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class subscriptionDBHelper {
  subscriptionDBHelper._();

  static final subscriptionDBHelper dbHelper = subscriptionDBHelper._();

  Database? dbs;

  String subscriptionTableName = "subscription";
  String subscriptionColumn1_ID = "id";
  String subscriptionColumn2_title = "title";
  String subscriptionColumn3_price = "price";
  String subscriptionColumn4_image = "image";

  Future<Database?> init() async {

    String path = await getDatabasesPath();

    String dataBasePath = join(path, "subscription.db");

    dbs = await openDatabase(
      dataBasePath,
      version: 1,
      onCreate: (Database database, version) async {
        String query = "CREATE TABLE IF NOT EXISTS $subscriptionTableName($subscriptionColumn1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $subscriptionColumn2_title TEXT, $subscriptionColumn3_price TEXT, $subscriptionColumn4_image TEXT);";
        await database.execute(query);
      },
    );
    String query = "CREATE TABLE IF NOT EXISTS $subscriptionTableName($subscriptionColumn1_ID INTEGER PRIMARY KEY AUTOINCREMENT, $subscriptionColumn2_title TEXT, $subscriptionColumn3_price TEXT, $subscriptionColumn4_image TEXT);";

    dbs!.execute(query);
    return dbs;
  }

  Future<List<SubscriptionModel>> setUpSubscriptionData() async {
    dbs!.rawQuery("DROP TABLE subscription;");
    dbs = await init();

    List<String> quers = [
      "INSERT INTO $subscriptionTableName VALUES(NULL, 'Week', '1.19','assets/images/week.jpg');",
      "INSERT INTO $subscriptionTableName VALUES(NULL, '1 Month', '4.39','assets/images/1_month.jpg');",
      "INSERT INTO $subscriptionTableName VALUES(NULL, '3 Month', '9.99','assets/images/3_month.jpg');",
      "INSERT INTO $subscriptionTableName VALUES(NULL, '6 Month', '13','assets/images/6_month.jpg');",
    ];

    for(var value in quers){
    await dbs!.rawInsert(value);
    }

    String query = "SELECT *FROM $subscriptionTableName";
    List<Map<String, dynamic>> data = await dbs!.rawQuery(query);

    print("subscriptionData ==> ${data}");
    List<SubscriptionModel> subscriptionDataList = subscriptionModelFromJson(jsonEncode(data));



    return subscriptionDataList;
  }
}
