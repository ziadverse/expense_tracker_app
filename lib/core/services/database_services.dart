import 'package:expense_tracker_app/features/home/models/expense_category.dart';
import 'package:expense_tracker_app/features/home/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/models/income_category.dart';
import 'package:expense_tracker_app/features/home/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/models/transaction_type.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  DatabaseServices._();

  static Database? _database;
  static final String _table = "Transactions";
  static final String _name = "Expense_App.db";

  static Future<Database> initDatabase() async{
    String path = await getDatabasesPath();
    String fullPath = join(path, _name);
    return openDatabase(fullPath, version: 1, onCreate: onCreate);
  }

  static Future<Database> get database async{
    _database ??= await initDatabase();
    return _database!;
  }

  static void onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE transactions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount INTEGER NOT NULL,
    description TEXT NOT NULL,
    type TEXT NOT NULL,
    date TEXT NOT NULL, -- check its datatype
    category TEXT NOT NULL
    );
    ''');
  }

  static Future<List<TransactionModel>> readTransaction() async{
     try{
       Database db = await database;
       List<Map<String, dynamic>> transactions = await db.query(_table);
       return transactions.map<TransactionModel>((transaction){
        return transaction['type'] == TransactionType.income.name? IncomeTransaction.fromJson(transaction):
            ExpenseTransaction.fromJson(transaction);
       }).toList();
     }catch(e){
       print("READ ERROR: $e");
       return [];
     }
  }

  static Future<int> createTransaction(TransactionModel model, IncomeCategory? incCat, ExpenseCategory? expCat) async{
      try{
        Database db = await database;
        if (incCat != null && expCat == null){
          IncomeTransaction incTrans = IncomeTransaction(id: model.id, amount: model.amount, description: model.description, type: model.type, date: model.date, category: incCat);
          return await db.insert(_table, incTrans.toJson(), conflictAlgorithm: .replace);
        }else{
          ExpenseTransaction expTrans = ExpenseTransaction(id: model.id, amount: model.amount, description: model.description, type: model.type, date: model.date, category: expCat);
          return await db.insert(_table, expTrans.toJson(), conflictAlgorithm: .replace);
        }
      }catch(e){
        return -1;
      }

  }

  static Future<int> updateTransaction(int id, {int? amount, String? description, TransactionType? type, DateTime? date, IncomeCategory? incCat, ExpenseCategory? expCat}) async {
    try{
      Database db = await database;
      Map<String, dynamic> newValues = {};
      if (amount != null) newValues['amount'] = amount;
      if (description != null) newValues['description'] = description;
      if (type != null) newValues['type'] = type;
      if (date != null) newValues['date'] = date;
      if (incCat != null) newValues['category'] = incCat;
      if (expCat != null) newValues['category'] = expCat;
      return await db.update(_table, newValues, where: "id = ?", whereArgs: [id]);
    }catch(e){
      return -1;
    }
  }

  static Future<int> deleteTransaction(int id) async{
    try{
      Database db = await database;
      return await db.delete(_table, where: "id = ?", whereArgs: [id]);
    }catch(e){
      return -1;
    }
  }

  static void dropDatabase() async{
    String path = await getDatabasesPath();
    String fullPath = join(path, _name);
    return deleteDatabase(fullPath);
  }
}