import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "database.db";
  static const _databaseVersion = 1;



  late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      _db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    }catch(e){}
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name

  // inserted row.
  Future<int> insert(String table, Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }
  // All of the rows are returned as a list of maps, where each map is

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS client (
            id INTEGER PRIMARY KEY,
            company_name TEXT NOT NULL,
            street TEXT ,
            city TEXT ,
            country TEXT ,
            telephone TEXT, 
            currency TEXT, 
            
            universal_id INTEGER,
            device_id TEXT,
            
            
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            
            
            email TEXT ,
            status TEXT 
          )
          ''');

    await db.execute('''
          CREATE TABLE company (
            id INTEGER PRIMARY KEY,
            company_name TEXT NOT NULL,
            street TEXT ,
            city TEXT ,
            logo TEXT ,
            country TEXT, 
            telephone TEXT, 
            
            universal_id INTEGER,
            device_id TEXT,
            
            
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            
            email TEXT ,
            status TEXT 
          )
          ''');


    await db.execute('''
          CREATE TABLE employee (
            id INTEGER PRIMARY KEY,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            national_id TEXT ,
            nationality TEXT,
            postcode TEXT ,
            street TEXT ,
            city TEXT ,
            country TEXT ,
            telephone TEXT ,
            particulars TEXT,
            incDate TEXT,
            email TEXT,
            
            universal_id INTEGER,
            device_id TEXT,
            
            
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            
            
            
            company_id INTEGER NOT NULL 
          )
          ''');

    await db.execute('''
          CREATE TABLE invoice (
            id INTEGER PRIMARY KEY,
            client_id INTEGER NOT NULL,
            total_amount FLOAT ,
            vat_percent FLOAT ,
            vat_amount FLOAT ,
            sub_total_amount FLOAT ,
            discount FLOAT ,
            published BIT ,
            notes TEXT ,
            currency TEXT ,
            invoice_date TEXT ,
            due_date TEXT,
            company_id INTEGER NOT NULL,
            invoice_status TEXT,
            invoice_number TEXT,
            
                    
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            

            
            is_optimised BOOLEAN,
            is_synced BOOLEAN,
            origin_id INTEGER,
            universal_id INTEGER,
            is_changed   BOOLEAN     
          )
          ''');

    await db.execute('''
          CREATE TABLE invoice_item (
            id INTEGER PRIMARY KEY,
            unit_price FLOAT ,
            total FLOAT NOT NULL,
            product TEXT ,
            description TEXT NOT NULL,
            
            universal_id INTEGER,
            device_id TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            
            invoice_id INTEGER NOT NULL,      
            units INTEGER NOT NULL       
          )
          ''');

    await db.execute('''
          CREATE TABLE payment (
            id INTEGER PRIMARY KEY,
            total FLOAT NOT NULL,
            ref TEXT ,
            status TEXT ,
            
            universal_id INTEGER,
            device_id TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version TEXT,
            last_modified_by TEXT,
            last_modified_date TEXT,
            deleted_at TEXT DEFAULT 0,
            
            
            payment_date TEXT ,
            invoice_id INTEGER NOT NULL         
          )
          ''');

    await db.execute('''
          CREATE TABLE currency (
            id TEXT PRIMARY KEY,
            symbol TEXT NOT NULL,
            
            country TEXT 
          )
          ''');

    await db.execute('''
          CREATE TABLE wallet (
            id INTEGER PRIMARY KEY,
            balance FLOAT NOT NULL,
            
            universal_id INTEGER,
            device_id TEXT,
            
            client_id INTEGER NOT NULL,
            currency TEXT 
          )
          ''');


    await db.execute('''
          insert into currency (
            id,
            symbol,
            country
            )
            values("USD","\$","United States of America" )
          ''');
    await db.execute('''
          insert into currency (
            id,
            symbol,
            country
            )
            values("POUND","£","United States of America" )
          ''');

    await db.execute('''
          insert into currency (
            id,
            symbol,
            country
            )
            values("ZWL","ZWL","United States of America" )
          ''');

  }

  // and the value is the column value. The return value is the id of the
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    return await _db.query(table);
  }

  Future<List<Map<String, dynamic>>> softQueryAllRows(String table) async {
    return await _db.rawQuery("select * from '$table' where deleted_at = '0'" );
  }


  Future<List<Map<String, dynamic>>> queryFilteredInvoices(String table, String dateSort, {String? invoiceStatus, String? clientId}) async {
    return invoiceStatus != null && clientId != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "invoice_status = '${invoiceStatus}' and client_id = '${clientId}'"  )
        :  invoiceStatus != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "invoice_status = '${invoiceStatus}'"  )
        :  clientId != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "client_id = '${clientId}'"  )
        : await _db.query(table,orderBy: 'invoice_date ${dateSort}');
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount(String table) async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }


  Future<Map<String, dynamic>?> findById(String table, int id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE id = $id');
    return results.isEmpty ? null : results?[0];
  }

  Future<Map<String, dynamic>?> findByIdUni(String table, String id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE universal_id = $id');
    return results.isEmpty ? null : results?[0];
  }

  Future<Map<String, dynamic>?> findClientWallet(String table, int id, String currency) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE client_id = $id and currency = "$currency"');
    try{
      return results.isEmpty ? null : results?[0];
    } catch(e){
      return null;
    }
  }

  Future<Map<String, dynamic>?> findByIdStr(String table, var id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE id = "$id"');
    return results.isEmpty ? null : results?[0];
  }

  Future<List<Map<String, dynamic>>> findInvoiceItems(String table, int id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE invoice_id = $id');
    return results;
  }


  Future<List<Map<String, dynamic>>> searchClients(String query) async {
    List<Map<String, Object?>> results = await _db.rawQuery("SELECT * FROM client WHERE company_name LIKE '%$query%' OR email LIKE '%$query%'");
    return results;
  }


  Future<List<Map<String, dynamic>>> findInvoicePayments(String table, int id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE invoice_id = $id');
    return results;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(String table, Map<String, dynamic> row) async {
    int id = row['id'];
    return await _db.update(
      table,
      row,
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  Future<int> softDelete(String table, int id) async {

    Map<String, dynamic> row = {
      "deleted_at":  DateTime.now().toString(),
    };

    return await _db.update(
      table,
      row,
      where: 'id= ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table,int id) async {
    return await _db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}