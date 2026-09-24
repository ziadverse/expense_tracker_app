import 'package:expense_tracker_app/features/home/data/models/expense_categories_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/income_categories_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/home/data/models/Transaction.dart';

class DatabaseServices {
  DatabaseServices._();

  static Database? _database;
  static final String _table = "transactions";
  static final String _name = "transactions.db";

  static Future<Database> initDatabase() async{
    String path = await getDatabasesPath();
    String fullPath = join(path, _name);
    return await openDatabase(fullPath, version: 1, onCreate: onCreate);
  }

  static Future<Database> get database async{
    _database ??= await initDatabase();
    return _database!;
  }

  static void onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type VARCHAR(25) NOT NULL,
      date DATETIME NOT NULL,
      amount REAL NOT NULL,
      description VARCHAR(255) NOT NULL,
      category VARCHAR(255) NOT NULL
    )
    ''');
  }

  static Future<List<TransactionModel>> readDatabase() async {
    try {
      final Database db = await database;
      final List<Map<String, dynamic>> transactions = await db.query(_table);
      return transactions.map<TransactionModel>((transaction_json) {
        if (transaction_json['type'] == TransactionType.expense.name) {
          return ExpenseTransaction.fromJson(transaction_json);
        } else {
          return IncomeTransaction.fromJson(transaction_json);
        }
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<int> createTransaction(TransactionModel model, ExpenseCategories? exp_category, IncomeCategories? inc_category) async {
    try{
      final Database db = await database;
      if(exp_category != null && inc_category == null) {
        ExpenseTransaction transaction = ExpenseTransaction(
            type: TransactionType.expense,
            date: DateTime.now(),
            amount: model.amount,
            description: model.description,
            category: exp_category);
        return await db.insert(
            _table, transaction.toJson(), conflictAlgorithm: .replace);
      }else {
        IncomeTransaction transaction = IncomeTransaction(
            type: TransactionType.income,
            date: DateTime.now(),
            amount: model.amount,
            description: model.description,
            category: inc_category);
        return await db.insert(
            _table, transaction.toJson(), conflictAlgorithm: .replace);
      }
    }catch(e){
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<TransactionModel?> getById(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;

    final json = result.first;
    if (json['type'] == TransactionType.expense.name) {
      return ExpenseTransaction.fromJson(json);
    } else {
      return IncomeTransaction.fromJson(json);
    }
  }

  static Future<int> updateTransaction(int id, {TransactionType? type, double? amount, String? description, DateTime? date, ExpenseCategories? exp_category, IncomeCategories? inc_category}) async{
    try{
      final Database db = await database;
      Map<String, dynamic> newValues = {};
      TransactionModel? model = await getById(id);
      if (model is ExpenseTransaction){
        if (exp_category != null && inc_category == null){
          newValues['category'] = exp_category;
        }
      }else{
        if (exp_category == null && inc_category != null){
          newValues['category'] = inc_category;
        }
      }
      if (type != null) newValues['type'] = type;
      if (amount != null) newValues['amount'] = amount;
      if (description != null) newValues['description'] = description;
      if (date != null) newValues['date'] = date;
      if (type != null) newValues['type'] = type;
      if (type != null) newValues['type'] = type;
      return await db.update(_table, newValues, where: "id = ?", whereArgs: [id]);
    }catch(e){
      return -1;
    }
  }

  static Future<int> deleteTransaction(int id) async{
    try{
      final Database db = await database;
      return await db.delete(_table, where: "id = ?", whereArgs: [id]);
    }catch(e){
      return -1;
    }
  }
  
  static void dropDatabase() async{
    try{
      String path = await getDatabasesPath();
      String fullPath = join(path, _name);
      return await deleteDatabase(fullPath);
    } catch(e){
      debugPrint(e.toString());
    }

  }

}