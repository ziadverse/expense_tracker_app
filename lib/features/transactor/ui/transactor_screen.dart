import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/core/services/database_services.dart';
import 'package:expense_tracker_app/features/home/models/expense_category.dart';
import 'package:expense_tracker_app/features/home/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/models/income_category.dart';
import 'package:expense_tracker_app/features/home/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/models/transaction_type.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/amount_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/category_selector_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/description_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/save_button_widget.dart';
import 'package:expense_tracker_app/features/transactor/ui/widgets/type_widget.dart';
import 'package:flutter/material.dart';

class TransactorScreen extends StatefulWidget {
  final TransactionModel? transaction;

  const TransactorScreen({this.transaction, super.key});

  @override
  State<TransactorScreen> createState() => _TransactorScreenState();
}

class _TransactorScreenState extends State<TransactorScreen> {
  bool isLoading = false;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  TransactionType selectedType = TransactionType.expense;
  IncomeCategory incomeCategory = IncomeCategory.values.first;
  ExpenseCategory expenseCategory = ExpenseCategory.values.first;

  Color get color => selectedType == TransactionType.income
      ? const Color(0xFF4CD964)
      : const Color(0xFFFF6B6B);

  void initData() {
    final t = widget.transaction;
    if (t == null) return;
    amountController.text = t.amount.toString();
    descriptionController.text = t.description ?? '';
    selectedType = t.type ?? TransactionType.expense;
    if (t is IncomeTransaction) {
      incomeCategory = t.category ?? incomeCategory;
    } else if (t is ExpenseTransaction) {
      expenseCategory = t.category ?? expenseCategory;
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (isLoading) return;
    final description = descriptionController.text.trim();
    final amount = int.tryParse(amountController.text.trim());
    if (description.isEmpty || amount == null || amount <= 0) return;
    setState(() => isLoading = true);
    await Future.delayed(2.sec);
    final isIncome = selectedType == TransactionType.income;
    if (widget.transaction == null) {
      if (isIncome) {
        await DatabaseServices.createTransaction(
          IncomeTransaction(
            amount: amount,
            description: description,
            type: selectedType,
            date: DateTime.now(),
            category: incomeCategory,
          ),
          incomeCategory,
          null,
        );
      } else {
        await DatabaseServices.createTransaction(
          ExpenseTransaction(
            amount: amount,
            description: description,
            type: selectedType,
            date: DateTime.now(),
            category: expenseCategory,
          ),
          null,
          expenseCategory,
        );
      }
    } else {
      await DatabaseServices.updateTransaction(
        widget.transaction!.id!,
        amount: amount,
        description: description,
        type: selectedType,
        date: DateTime.now(),
        incCat: isIncome ? incomeCategory : null,
        expCat: isIncome ? null : expenseCategory,
      );
    }
    if (!mounted) return;
    setState(() => isLoading = false);
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = selectedType == TransactionType.income;
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8FF),
      appBar: AppBar(
        title: Text(
          widget.transaction == null ? "Add Transaction" : "Update Transaction",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6B3FA0),
        foregroundColor: const Color(0xFF1FD6D9),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () =>
                        setState(() => selectedType = TransactionType.income),
                    child: TypeWidget(
                      text: "Income",
                      isClicked: isIncome,
                      color: const Color(0xFF4CD964),
                    ),
                  ),
                ),
                12.hGap,
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () =>
                        setState(() => selectedType = TransactionType.expense),
                    child: TypeWidget(
                      text: "Expense",
                      isClicked: !isIncome,
                      color: const Color(0xFFFF6B6B),
                    ),
                  ),
                ),
              ],
            ),
            24.vGap,
            AmountWidget(type: selectedType, controller: amountController),
            8.vGap,
            DescriptionWidget(controller: descriptionController),
            24.vGap,
            const Text(
              "Category",
              style: TextStyle(
                color: Color(0xFF6B3FA0),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            8.vGap,
            CategorySelectorWidget(
              names: isIncome
                  ? IncomeCategory.values.map((e) => e.name).toList()
                  : ExpenseCategory.values.map((e) => e.name).toList(),
              selectedIndex: isIncome
                  ? incomeCategory.index
                  : expenseCategory.index,
              color: color,
              onSelected: (i) => setState(() {
                if (isIncome) {
                  incomeCategory = IncomeCategory.values[i];
                } else {
                  expenseCategory = ExpenseCategory.values[i];
                }
              }),
            ),
            32.vGap,
            SaveButtonWidget(
              isLoading: isLoading,
              label: widget.transaction == null
                  ? "Create Transaction"
                  : "Update Transaction",
              onPressed: save,
            ),
          ],
        ),
      ),
    );
  }
}
