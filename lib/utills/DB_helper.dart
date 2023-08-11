import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper {
  Database? database;

  Future<Database> checkdb() async {
    if (database != null) {
      return database!;
    } else {
      return await initdb();
    }
  }

  Future<Database> initdb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "kamo.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE incomeexpence ( id INTEGER PRIMARY KEY AUTOINCREMENT , category TEXT , amount INTEGER , date TEXT , paytypes TEXT , stats TEXT)";

        db.execute(query);

        String quary1 =
            "CREATE TABLE cate (id INTEGER PRIMARY KEY AUTOINCREMENT , category TEXT)";

        db.execute(quary1);
      },
    );
  }

  // income expance
  insertdb({
    required category,
    required amount,
    required stats,
    required date,
    required paytypes,
  }) async {
    database = await checkdb();
    database!.insert(
      "incomeexpence",
      {
        "category": category,
        "amount": amount,
        "date": date,
        "paytypes": paytypes,
        "stats": stats,
      },
    );
  }

  Future<List<Map>> readdata() async {
    database = await checkdb();
    String quary = "SELECT * FROM incomeexpence";
    List<Map> list = await database!.rawQuery(quary);
    return list;
  }

  Future<void> delateData({
    required id,
  }) async {
    database = await checkdb();

    database!.delete(
      "incomeexpence",
      whereArgs: [id],
      where: "id=?",
    );
  }

  Future<List> FilterData({required staus,date}) async {
    database = await checkdb();
    print(staus);
    String quary = "SELECT * FROM incomeexpence WHERE stats=$staus";
    List l1 = await database!.rawQuery(quary);
    print(l1);
    return l1;
  }

  Update({
    required stats,
    required paytypes,
    required date,
    required category,
    required amount,
    required id,
  }) async {
    database = await checkdb();
    database!.update(
      "incomeexpence",
      {
        "category": category,
        "amount": amount,
        "date": date,
        "paytypes": paytypes,
        "stats": stats,
      },
      whereArgs: [id],
      where: "id=?",
    );

    readdata();
  }

  Future<List<Map>>TotalIncome({required stats}) async {
    database = await checkdb();
    print("----------------------------------------------------------------------------------------------------------------------------------");
    String quary = "SELECT SUM(amount) FROM incomeexpence WHERE stats=$stats";
    List<Map> total = await database!.rawQuery(quary);
    return total;
  }
  Future<List<Map>>totalExpanse({required stats}) async {
    database = await checkdb();
    print("----------------------------------------------------------------------------------------------------------------------------------");
    String quary = "SELECT SUM(amount) FROM incomeexpence WHERE stats=$stats";
    List<Map> total = await database!.rawQuery(quary);
    return total;
  }


  // category

  void insertCate({
    required cate,
  }) async {
    database = await checkdb();
    print("==================================");
    print(cate);
    database!.insert(
      "cate", {
      "category": cate,
    },
    );
  }

  Future<List<Map>> readCate() async {
    database = await checkdb();

    String quary = "SELECT * FROM cate";

    List<Map> l1 = await database!.rawQuery(quary);

    return l1;
  }


}
