import 'package:expense_tracker_app/core/constants/constant_assets.dart';
import 'package:expense_tracker_app/features/home/models/expense_category.dart';
import 'package:expense_tracker_app/features/home/models/income_category.dart';

class AssetsMap {
  AssetsMap._();

  static String getExpenseImage(ExpenseCategory category) {
    switch(category) {
      case ExpenseCategory.food:
        return ConstantAssets.food;
      case ExpenseCategory.groceries:
        return ConstantAssets.groceries;
      case ExpenseCategory.transport:
        return ConstantAssets.transport;
      case ExpenseCategory.rent:
        return ConstantAssets.rent;
      case ExpenseCategory.utilities:
        return ConstantAssets.utilities;
      case ExpenseCategory.health:
        return ConstantAssets.health;
      case ExpenseCategory.education:
        return ConstantAssets.education;
      case ExpenseCategory.shopping:
        return ConstantAssets.shopping;
      case ExpenseCategory.entertainment:
        return ConstantAssets.entertainment;
      case ExpenseCategory.travel:
        return ConstantAssets.travel;
      case ExpenseCategory.subscription:
        return ConstantAssets.subscription;
      case ExpenseCategory.insurance:
        return ConstantAssets.insurance;
      case ExpenseCategory.donations:
        return ConstantAssets.donations;
      case ExpenseCategory.debts:
        return ConstantAssets.debts;
      case ExpenseCategory.other:
        return ConstantAssets.other;
    }
  }

  static String getIncomeImage(IncomeCategory category) {
    switch(category) {
      case IncomeCategory.freelance:
        return ConstantAssets.freelance;
      case IncomeCategory.investment:
        return ConstantAssets.investment;
      case IncomeCategory.refunds:
        return ConstantAssets.refunds;
      case IncomeCategory.bonus:
        return ConstantAssets.bonus;
      case IncomeCategory.gift:
        return ConstantAssets.gift;
      case IncomeCategory.salary:
        return ConstantAssets.salary;
      case IncomeCategory.other:
        return ConstantAssets.other;
    }
  }
}
