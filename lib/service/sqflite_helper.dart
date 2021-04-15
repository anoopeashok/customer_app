import 'package:customer_app/models/customer.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._privateConstructor();
  String tableName = "customer_table";
  factory LocalDatabase() => _instance;

  LocalDatabase._privateConstructor();

  Database database;

  Future open() async {
    String databasesPath = await getDatabasesPath();
    String path = databasesPath + 'customer.db';

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE $tableName (id TEXT, cardCode TEXT,cardName TEXT,address TEXT,priceMode TEXT,priceList TEXT,phone1 TEXT,cntctPrsn TEXT,balance TEXT,creditLine TEXT, mailAddres TEXT)");
    });
  }

  void insertData(Customer customer) async {
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO $tableName(id, cardCode,cardName,address,priceMode,priceList,phone1,cntctPrsn,balance,creditLine,mailAddres) VALUES("${customer.id.toString()}","${customer.cardCode.toString()}","${customer.cardName.toString()}","${customer.address.toString()}","${customer.priceMode.toString()}","${customer.priceList.toString()}","${customer.phone1.toString()}","${customer.cntctPrsn.toString()}","${customer.balance.toString()}","${customer.creditLine.toString()}","${customer.mailAddres.toString()}")');
    });
  }

  Future<List<Customer>> fetchAllData() async{
    List list = await database.rawQuery('SELECT * FROM $tableName');
    List<Customer> customers = [];
    list.forEach((element) { 
      customers.add(Customer.fromJson(element));
    });
    return customers;
  }

  Future<Customer> fetchByID(String id) async{
    try{
    List<Map> data = await database.rawQuery('SELECT * FROM $tableName WHERE cardCode=?',['$id']);
    print(data);
        return Customer.fromJson(data[0]); 

    }on Exception  catch(e){
      print(e);
    }

  }

  void updateData(name,id) async{
    await database.rawUpdate(
    'UPDATE $tableName SET cardName = "$name" WHERE cardCode = "$id"');
  }
}
