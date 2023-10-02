import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "/DocxApp/app-data/docdatabase.db";
  static const _databaseVersion = 4;



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
          onUpgrade: _onUpgrade

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
          CREATE TABLE client (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            street TEXT ,
            city TEXT ,
            country TEXT ,
            telephone TEXT, 
            currency TEXT, 
            email TEXT ,
            status TEXT,
            
            entitynum TEXT,
            oldaddress TEXT,
            oldemail TEXT,
            newaddress TEXT,
            newpostal TEXT,
            newemail TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
            
          )
          ''');

    await db.execute('''
          CREATE TABLE objective (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
            
          )
          ''');
    await db.execute('''
          CREATE TABLE stage (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            number TEXT NOT NULL,
            type TEXT NOT NULL,
            description TEXT,
             is_deleted INTEGER    
          )
          ''');
    await db.execute('''
          CREATE TABLE client_stage(
            id INTEGER PRIMARY KEY,
            client_id INTEGER,
            stage_id INTEGER NOT NULL,
            type TEXT NOT NULL,
            status TEXT NOT NULL,
            notes TEXT,
            is_deleted INTEGER  
          )
          ''');


    await db.execute('''
          CREATE TABLE client_objective (
            client_id INTEGER NOT NULL,
            objective_id INTEGER NOT NULL,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
            
          )
          ''');

    await db.execute('''
          CREATE TABLE director (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            national_id TEXT NOT NULL,
            nationality TEXT,
            street TEXT NOT NULL,
            city TEXT NOT NULL,
            country TEXT NOT NULL,
            particulars TEXT,
            incDate TEXT,
            email TEXT,
            company_id INTEGER NOT NULL,
            shareholder INTEGER,
            shares INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE secretary (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            national_id TEXT NOT NULL,
            nationality TEXT,
            street TEXT NOT NULL,
            city TEXT NOT NULL,
            country TEXT NOT NULL,
            particulars TEXT,
            incDate TEXT,
            email TEXT,
            company_id INTEGER NOT NULL           
          )
          ''');

    await db.execute('''
          CREATE TABLE business (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            street TEXT ,
            city TEXT ,
            logo TEXT ,
            color INTEGER ,
            country TEXT, 
            telephone TEXT,   
            payment_info TEXT,   
            email TEXT ,
            status TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   

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
            business_id INTEGER NOT NULL,
            
            created_date TEXT,
            created_by TEXT,            
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
            
            
            

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
            invoice_date TEXT,
            invoice_type TEXT NOT NULL,
            due_date TEXT,
            business_id INTEGER NOT NULL,
            invoice_status TEXT,
            invoice_number TEXT,
            
                    
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            

            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');

    await db.execute('''
          CREATE TABLE product (
            id INTEGER PRIMARY KEY,
            
            name TEXT ,
            sku TEXT ,
            featured INTEGER ,
            price FLOAT NOT NULL,
            stock INTEGER ,
            category_id INTEGER,
            business_id INTEGER NOT NULL,
                           
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
                        
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');
    await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY,
            name TEXT ,
            description TEXT ,
                           
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
                        
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');

    await db.execute('''
          CREATE TABLE invoice_item (
            id INTEGER PRIMARY KEY,
            unit_price FLOAT ,
            total FLOAT NOT NULL,
            product TEXT ,
            description TEXT NOT NULL,
            invoice_id INTEGER NOT NULL,      
            units INTEGER NOT NULL, 
            
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
      
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');

    await db.execute('''
          CREATE TABLE payment (
            id INTEGER PRIMARY KEY,
            total FLOAT NOT NULL,
            ref TEXT ,
            status TEXT ,
            payment_date TEXT ,
            invoice_id INTEGER NOT NULL,     

            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
            
   
          )
          ''');

    await db.execute('''
          CREATE TABLE currency (
            id TEXT PRIMARY KEY,
            symbol TEXT NOT NULL,
            country TEXT ,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');

    await db.execute('''
          CREATE TABLE wallet (
            id INTEGER PRIMARY KEY,
            balance FLOAT NOT NULL,
            client_id INTEGER NOT NULL,
            currency TEXT,
            
            created_date TEXT,
            created_by TEXT,
            version INTEGER,
            last_modified_by TEXT,
            last_modified_date TEXT,
            is_deleted INTEGER,
            
            is_optimised INTEGER,
            is_synced INTEGER,
            origin_id INTEGER,
            universal_id INTEGER UNIQUE,
            is_confirmed   INTEGER   
          )
          ''');

    try{
      await db.execute('''
            CREATE TABLE client_objective (
              id INTEGER PRIMARY KEY, 
              client_id INTEGER NOT NULL, 
              objective_id INTEGER NOT NULL,  
            )
            ''');

    } catch (e) {
    log("Table client_objective already exists");
    }


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

  Future _onUpgrade(Database db, int version,  int version2) async {
    try {
      await db.execute(''' ALTER TABLE client ADD entitynum TEXT ;   ''');
    } catch (e) {
      log("Column entitynum already exists on table client");
    }
    try {
      await db.execute(''' ALTER TABLE client ADD oldaddress TEXT ;   ''');
    } catch (e) {
      log("Column oldaddress already exists on table client");
    }
    try {
      await db.execute(''' ALTER TABLE client ADD oldemail TEXT ;   ''');
    } catch (e) {
      log("Column oldemail already exists on table client");
    }
    try {
      await db.execute(''' ALTER TABLE client ADD newaddress TEXT ;   ''');
    } catch (e) {
      log("Column newaddress already exists on table client");
    }
    try {
      await db.execute(''' ALTER TABLE client ADD newpostal TEXT ;   ''');
    } catch (e) {
      log("Column newpostal already exists on table client");
    }
    try {
      await db.execute(''' ALTER TABLE client ADD newemail TEXT ;   ''');
    } catch (e) {
      log("Column newemail already exists on table client");
    }


    try {
      await db.execute('''
          CREATE TABLE client_objective (
            id INTEGER PRIMARY KEY, 
            client_id INTEGER NOT NULL, 
            objective_id INTEGER NOT NULL,  
          )
          ''');
    } catch (e) {
      log("Table client_objective already exists");
    }


  }

  // and the value is the column value. The return value is the id of the
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    return await _db.query(table);
  }

  Future<List<Map<String, dynamic>>> softQueryAllRows(String table) async {
    return await _db.rawQuery("select * from '$table' where (is_deleted = 0 or is_deleted is null)" );
  }
  Future<List<Map<String, dynamic>>> getTypeStages(String table, String type) async {
    return await _db.rawQuery("select * from '$table' where (is_deleted = 0 or is_deleted is null) and type = '$type' order by number asc" );
  }

  Future<List<Map<String, dynamic>>> stages(String table, int clientId) async {
      return await _db.rawQuery(
          "select * from '$table' where client_id = '$clientId' ");

  }


  Future<List<Map<String, dynamic>>> queryFilteredInvoices(String table,String type, String dateSort, {String? invoiceStatus, String? clientId}) async {
    return invoiceStatus != null && clientId != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "invoice_status = '${invoiceStatus}' and client_id = '${clientId}' and invoice_type = '${type}'"  )
        :  invoiceStatus != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "invoice_status = '${invoiceStatus}' and invoice_type = '${type}'"  )
        :  clientId != null
        ?  await _db.query(table,orderBy: 'invoice_date ${dateSort}' , where: "client_id = '${clientId}' and invoice_type = '${type}'"  )
        : await _db.query(table,orderBy: 'invoice_date ${dateSort}', where: "invoice_type = '${type}'");
  }

  Future<List<Map<String, dynamic>>>  getReadyForSyc(table) async {
    // List<Map<String, Object?>> results =
    return await _db.rawQuery('SELECT * FROM $table WHERE is_synced = 0 or is_synced is null');;
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

  Future<Map<String, dynamic>?> findByIdUni(String table, int id) async {
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
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE company_id = $id');
    return results;
  }
  Future<List<Map<String, dynamic>>> findClientObjectives(String table, int id) async {
    List<Map<String, Object?>> results = await _db.rawQuery('SELECT * FROM $table WHERE client_id = $id');
    return results;
  }


  Future<List<Map<String, dynamic>>> searchClients(String query) async {
    List<Map<String, Object?>> results = await _db.rawQuery("SELECT * FROM client WHERE name LIKE '%$query%' OR email LIKE '%$query%'");
    return results;
  }

  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    List<Map<String, Object?>> results = await _db.rawQuery("SELECT * FROM product WHERE name LIKE '%$query%' OR sku LIKE '%$query%'");
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
      "is_deleted":  1,
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

  Future<int> detach(String table,int clientId, int objectiveId ) async {
    return await _db.delete(
      table,
      where: 'client_id = ? and objective_id =?',
      whereArgs: [clientId, objectiveId],
    );
  }
}